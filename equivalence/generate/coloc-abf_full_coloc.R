# AUTHORING-TIME generator -- FULL tier, reference = coloc::coloc.abf (v5.2.3).
#
# The "real library" being ported here is the coloc colocalisation test (Giambartolomei
# et al. 2014, PLoS Genet 10(5):e1004383). We simulate TWO association studies over one
# region of Q SNPs and freeze coloc.abf's five posterior probabilities (PP0..PP4). The
# from-scratch reimplementation (equivalence/reimplementations/coloc-abf.R) must
# reproduce them. Two scenarios exercise the two interesting outcomes:
#
#   shared   -- both traits driven by the SAME SNP  -> PP4 (colocalisation) dominates
#   distinct -- each trait driven by a DIFFERENT SNP -> PP3 (two causal SNPs) dominates
#
# Both traits are case-control, so coloc's effect-size prior is sd.prior = 0.2 and the
# prior variance W = 0.04 for each; the per-SNP colocalisation priors are coloc's
# defaults p1 = p2 = 1e-4, p12 = 1e-5. All are stored in the fixture inputs.
#
# Run from the repo root (see regenerate-all.sh):
#   RENV_CONFIG_AUTOLOADER_ENABLED=FALSE R_LIBS_USER=equivalence/env/rlib \
#     Rscript equivalence/generate/coloc-abf_full_coloc.R

suppressWarnings(suppressMessages({
  options(repos = "https://cloud.r-project.org")
  for (pkg in c("jsonlite", "coloc")) {
    if (!requireNamespace(pkg, quietly = TRUE)) install.packages(pkg)
  }
  library(jsonlite); library(coloc)
}))

W   <- 0.2^2
p1  <- 1e-4; p2 <- 1e-4; p12 <- 1e-5
Q   <- 10
snp <- paste0("rs", seq_len(Q))
maf <- {
  set.seed(7); runif(Q, 0.1, 0.5)
}
se1 <- rep(0.030, Q)
se2 <- rep(0.035, Q)

mkds <- function(b, se) list(beta = b, varbeta = se^2, snp = snp,
                             type = "cc", N = 5000, s = 0.5, MAF = maf)

make_fixture <- function(scenario, beta1, beta2, out) {
  res <- suppressWarnings(coloc.abf(mkds(beta1, se1), mkds(beta2, se2),
                                    p1 = p1, p2 = p2, p12 = p12))
  pp  <- as.numeric(res$summary[paste0("PP.H", 0:4, ".abf")])
  fx  <- list(
    meta = list(
      slug = "coloc-abf",
      tier = "full",
      scenario = scenario,
      source = paste0("coloc::coloc.abf ", as.character(packageVersion("coloc"))),
      tolerance = list(abs = 1e-7, rel = 1e-6),
      generated = format(Sys.time(), "%Y-%m-%dT%H:%M:%S%z"),
      generator = "equivalence/generate/coloc-abf_full_coloc.R"
    ),
    inputs = list(beta1 = beta1, se1 = se1, beta2 = beta2, se2 = se2,
                  W1 = W, W2 = W, p1 = p1, p2 = p2, p12 = p12),
    reference = list(pp = pp)
  )
  write_json(fx, out, auto_unbox = TRUE, digits = 15, pretty = TRUE)
  cat("wrote", out, "\n")
}

# Shared causal variant at SNP 4 for BOTH traits -> PP4 should dominate.
set.seed(101)
b1 <- rnorm(Q, 0, 0.03); b2 <- rnorm(Q, 0, 0.03)
b1[4] <- 0.16; b2[4] <- 0.15
make_fixture("shared", b1, b2, "equivalence/fixtures/coloc-abf-shared.json")

# Distinct causal variants: trait 1 at SNP 3, trait 2 at SNP 7 -> PP3 should dominate.
# Both signals must be strong (each trait clearly associated) but at DIFFERENT SNPs.
set.seed(202)
b1 <- rnorm(Q, 0, 0.03); b2 <- rnorm(Q, 0, 0.03)
b1[3] <- 0.20; b2[7] <- 0.22
make_fixture("distinct", b1, b2, "equivalence/fixtures/coloc-abf-distinct.json")
