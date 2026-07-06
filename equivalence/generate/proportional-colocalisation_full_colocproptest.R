# AUTHORING-TIME generator -- FULL tier, reference = colocPropTest (v0.9.3).
#
# The "real library" being ported here is the proportional colocalisation test of Wallace,
# Robins & Johnson (2025, bioRxiv 2025.09.08.674910), as implemented in the CRAN package
# colocPropTest (Chris Wallace). We simulate two GWAS traits over a small region of SNPs in
# LD and freeze:
#   * pairwise: colocPropTest::estprop's chi-square, eta, and df=1 p-value for several pairs
#   * run:      colocPropTest::run_proptests' per-pair chi-square / p / adjusted ("fdr")
#               columns for a whole region, in two scenarios (shared vs distinct signal).
# The from-scratch base-R reimplementation
# (equivalence/reimplementations/proportional-colocalisation.R) must reproduce these.
#
# run_proptests names its multiplicity column `fdr` but calls p.adjust() with its default
# method (Holm) over the total number of possible pairs; we freeze exactly that.
#
# Run from the repo root (see regenerate-all.sh):
#   RENV_CONFIG_AUTOLOADER_ENABLED=FALSE R_LIBS_USER=equivalence/env/rlib \
#     Rscript equivalence/generate/proportional-colocalisation_full_colocproptest.R

suppressWarnings(suppressMessages({
  options(repos = "https://cloud.r-project.org")
  for (pkg in c("jsonlite", "colocPropTest")) {
    if (!requireNamespace(pkg, quietly = TRUE)) install.packages(pkg)
  }
  library(jsonlite); library(colocPropTest)
}))

ver <- as.character(packageVersion("colocPropTest"))

# ---- simulate one region: n SNPs in equicorrelated LD; causal SNPs per the scenario ----
sim_region <- function(seed, n, rho, causal1, causal2) {
  set.seed(seed)
  snp <- paste0("s", seq_len(n))
  Sig <- matrix(rho, n, n); diag(Sig) <- 1; dimnames(Sig) <- list(snp, snp)
  L <- chol(Sig)
  mk <- function(causal) {
    b <- as.numeric(rnorm(n) %*% L) * 0.02      # small noise across the region
    b[causal] <- b[causal] + 0.30               # a strong signal at the causal SNP
    b
  }
  list(snp = snp, LD = Sig,
       beta1 = mk(causal1), vbeta1 = rep(0.03, n)^2,
       beta2 = mk(causal2), vbeta2 = rep(0.035, n)^2)
}

write_fixture <- function(fx, out) {
  write_json(fx, out, auto_unbox = TRUE, digits = 15, pretty = TRUE)
  cat("wrote", out, "\n")
}

# ---- Fixture 1: pairwise estprop on hand-chosen pairs -------------------------------------
# Three 2-SNP pairs (one row each), spanning a near-proportional pair and two clearly
# non-proportional ones. Stored as parallel matrices (row = pair) for a clean JSON round-trip.
beta1_m  <- rbind(c(0.20, 0.05), c(0.22, 0.02), c(0.15, 0.14))
vbeta1_m <- rbind(c(0.030, 0.035), c(0.030, 0.030), c(0.028, 0.030))^2
beta2_m  <- rbind(c(0.18, 0.06), c(0.03, 0.19), c(0.16, 0.02))
vbeta2_m <- rbind(c(0.032, 0.031), c(0.031, 0.033), c(0.033, 0.031))^2
rho_v    <- c(0.6, 0.5, 0.7)
pw_chi <- pw_eta <- pw_p <- numeric(nrow(beta1_m))
for (i in seq_len(nrow(beta1_m))) {
  V1 <- diag(vbeta1_m[i, ]); V1[1, 2] <- V1[2, 1] <- sqrt(prod(vbeta1_m[i, ])) * rho_v[i]
  V2 <- diag(vbeta2_m[i, ]); V2[1, 2] <- V2[2, 1] <- sqrt(prod(vbeta2_m[i, ])) * rho_v[i]
  r  <- colocPropTest::estprop(beta1_m[i, ], beta2_m[i, ], V1, V2)$result
  pw_chi[i] <- r["chisquare"]; pw_eta[i] <- r["eta.hat"]
  pw_p[i]   <- pchisq(r["chisquare"], df = 1, lower.tail = FALSE)
}
write_fixture(list(
  meta = list(slug = "propcoloc-pairwise", tier = "full",
              source = paste0("colocPropTest::estprop ", ver),
              tolerance = list(abs = 1e-7, rel = 1e-6),
              generator = "equivalence/generate/proportional-colocalisation_full_colocproptest.R"),
  inputs = list(beta1 = beta1_m, vbeta1 = vbeta1_m,
                beta2 = beta2_m, vbeta2 = vbeta2_m, rho = rho_v),
  reference = list(chisquare = pw_chi, eta = pw_eta, p = pw_p)
), "equivalence/fixtures/propcoloc-pairwise.json")

# ---- Fixtures 2 & 3: full run_proptests over a region ------------------------------------
make_run_fixture <- function(scenario, seed, causal2, out) {
  n <- 6; rho <- 0.7
  d <- sim_region(seed, n, rho, causal1 = 1, causal2 = causal2)
  S1 <- list(beta = d$beta1, varbeta = d$vbeta1, snp = d$snp,
             type = "quant", N = 5000, MAF = rep(0.3, n))
  S2 <- list(beta = d$beta2, varbeta = d$vbeta2, snp = d$snp,
             type = "quant", N = 5000, MAF = rep(0.3, n))
  # explicit topsnps + high thresholds => deterministic (no tagging drop, no sampling)
  rr <- colocPropTest::run_proptests(S1, S2, LD = d$LD, topsnps = d$snp,
                                     r2.thr = 0.999, maxtests = 1e6)
  rr <- rr[order(match(rr$snp1, d$snp), match(rr$snp2, d$snp))]
  pairs <- rbind(match(rr$snp1, d$snp), match(rr$snp2, d$snp))   # 2 x m, 1-based
  write_fixture(list(
    meta = list(slug = "propcoloc-run", tier = "full", scenario = scenario,
                source = paste0("colocPropTest::run_proptests ", ver),
                tolerance = list(abs = 1e-6, rel = 1e-6), seed = seed,
                generator = "equivalence/generate/proportional-colocalisation_full_colocproptest.R"),
    inputs = list(beta1 = d$beta1, vbeta1 = d$vbeta1,
                  beta2 = d$beta2, vbeta2 = d$vbeta2,
                  LD = d$LD, pairs = pairs, ntests = attr(rr, "ntests")),
    reference = list(chisquare = rr$chisquare, p = rr$p,
                     adjusted = rr$fdr, min_adjusted = min(rr$fdr))
  ), out)
}

# Shared causal variant (SNP 1 in both) -> colocalised -> null NOT rejected (min adj large).
make_run_fixture("shared", 101, causal2 = 1, "equivalence/fixtures/propcoloc-run-shared.json")
# Distinct causal variants in LD (SNP 1 vs SNP 4) -> not colocalised -> some pair rejects.
make_run_fixture("distinct", 202, causal2 = 4, "equivalence/fixtures/propcoloc-run-distinct.json")
