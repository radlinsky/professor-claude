# AUTHORING-TIME generator — FULL tier, oracles = R's own lm() / solve() / exhaustive
# best-subset search. The "real reference" for the SwitchStep method is the full-data
# computation each summary-statistic shortcut is supposed to reproduce:
#   joint fit from summaries  vs  lm() on the standardized full data
#   summary-stat BIC          vs  BIC(lm(...)) up to a per-data additive constant
#   the switching search      vs  exhaustive best-subset over BIC(lm) (2^12 subsets)
#   rank-1 bordering update   vs  a fresh solve() of the grown matrix
#   ridge reconstruction      vs  solve(R + lambda*I, b) at rho = 0.999
#
# Emits five fixtures under equivalence/fixtures/. Base R only; no external package but
# jsonlite for writing.
#
# Run from repo root (regenerate-all.sh runs it with renv's autoloader off):
#   RENV_CONFIG_AUTOLOADER_ENABLED=FALSE R_LIBS_USER=equivalence/env/rlib \
#     Rscript equivalence/generate/switchstep_full_oracles.R

suppressWarnings(suppressMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE))
    install.packages("jsonlite", repos = "https://cloud.r-project.org")
  library(jsonlite)
}))

# The economic-indicator panel (spec §6); rho_max dials the strongest twin correlation.
sim <- function(n = 200, seed = 1, rho_max = 0.95) {
  set.seed(seed); p <- 12
  R <- diag(p)
  R[1, 2] <- R[2, 1] <- 0.90                 # rate_10y / rate_2y
  R[3, 4] <- R[4, 3] <- rho_max              # cpi_infl / pce_infl
  R[8, 10] <- R[10, 8] <- 0.70               # sentiment / pmi
  R[11, 12] <- R[12, 11] <- 0.65             # credit_spread / vix
  X <- matrix(rnorm(n * p), n, p) %*% chol(R)
  beta <- numeric(p); beta[c(1, 3, 5)] <- c(0.5, -0.4, -0.3)   # sparse truth
  list(X = X, y = drop(X %*% beta + rnorm(n, sd = 1)))
}

# Exhaustive best-subset over BIC(lm) on the RAW data — the selection oracle.
exhaustive_bic_lm <- function(X, y) {
  p <- ncol(X); best <- integer(0); best_bic <- BIC(lm(y ~ 1))
  for (k in 1:p) {
    cb <- combn(p, k)
    for (i in seq_len(ncol(cb))) {
      bic <- BIC(lm(y ~ X[, cb[, i], drop = FALSE]))
      if (bic < best_bic) { best_bic <- bic; best <- cb[, i] }
    }
  }
  sort(best)
}

indicator <- function(cols, p = 12) as.integer(seq_len(p) %in% cols)
wr <- function(fx, out) { write_json(fx, out, auto_unbox = TRUE, digits = 15, pretty = TRUE)
                          cat("wrote", out, "\n") }
stamp <- function() format(Sys.time(), "%Y-%m-%dT%H:%M:%S%z")
GEN <- "equivalence/generate/switchstep_full_oracles.R"

## 1) Joint-from-summaries + summary-stat BIC (seed 2) ------------------------------
s <- sim(seed = 2); X <- s$X; y <- s$y; n <- nrow(X)
R <- cor(X); b <- as.numeric(cor(X, y))
subsets <- list(c(1), c(1, 3), c(1, 3, 5), c(1, 2, 3, 4, 5), 1:12)   # candidate models
beta_std <- as.numeric(coef(lm(scale(y) ~ scale(X) - 1)))            # oracle: lm on std data
bic_lm   <- vapply(subsets, function(c) BIC(lm(y ~ X[, c, drop = FALSE])), numeric(1))
wr(list(
  meta = list(slug = "switchstep-joint-from-summaries", tier = "full",
              source = paste0("stats::lm on standardized data (R ", R.version$major, ".", R.version$minor, ")"),
              tolerance = list(abs = 1e-8, rel = 1e-8), seed = 2, generated = stamp(), generator = GEN),
  inputs = list(R = R, b = b, n = n, subsets = subsets),
  reference = list(beta = beta_std,
                   r2 = summary(lm(y ~ X))$r.squared,
                   bic_centered = bic_lm - bic_lm[1])),   # additive constant cancels
  "equivalence/fixtures/switchstep-joint-from-summaries.json")

## 2) Switching search vs exhaustive BIC(lm) — clean case, true set {1,3,5} (seed 2)
wr(list(
  meta = list(slug = "switchstep-selection-clean", tier = "full",
              source = "exhaustive best-subset over BIC(lm), 2^12 subsets",
              tolerance = list(abs = 1e-9, rel = 1e-9), seed = 2, generated = stamp(), generator = GEN),
  inputs = list(R = R, b = b, n = n),
  reference = list(selected = indicator(exhaustive_bic_lm(X, y)))),
  "equivalence/fixtures/switchstep-selection-clean.json")

## 3) Switching search vs exhaustive — collinear twins-confusion case (seed 1, {2,4,5})
s1 <- sim(seed = 1); X1 <- s1$X; y1 <- s1$y
R1 <- cor(X1); b1 <- as.numeric(cor(X1, y1))
wr(list(
  meta = list(slug = "switchstep-selection-collinear", tier = "full",
              source = "exhaustive best-subset over BIC(lm), 2^12 subsets",
              tolerance = list(abs = 1e-9, rel = 1e-9), seed = 1, generated = stamp(), generator = GEN),
  inputs = list(R = R1, b = b1, n = nrow(X1)),
  reference = list(selected = indicator(exhaustive_bic_lm(X1, y1)))),
  "equivalence/fixtures/switchstep-selection-collinear.json")

## 4) Rank-1 bordering update vs fresh solve() ------------------------------------
set.seed(1); k <- 4
M <- crossprod(matrix(rnorm(k * k), k)); Mi <- solve(M)
b_new <- rnorm(k); d <- rnorm(1)^2 + 2
M_grown <- rbind(cbind(M, b_new), c(b_new, d))
wr(list(
  meta = list(slug = "switchstep-rank1-bordering", tier = "full",
              source = "fresh solve() of the grown (k+1)x(k+1) matrix",
              tolerance = list(abs = 1e-9, rel = 1e-9), seed = 1, generated = stamp(), generator = GEN),
  inputs = list(Mi = Mi, b_new = b_new, d = d),
  reference = list(inv_grown = as.numeric(solve(M_grown)))),
  "equivalence/fixtures/switchstep-rank1-bordering.json")

## 5) Ridge-stabilised reconstruction at rho = 0.999 ------------------------------
s2 <- sim(seed = 3, rho_max = 0.999); X2 <- s2$X; y2 <- s2$y
R2 <- cor(X2); b2 <- as.numeric(cor(X2, y2)); lambda <- 0.1
wr(list(
  meta = list(slug = "switchstep-ridge", tier = "full",
              source = "solve(R + lambda*I, b); unregularized R is near-singular at rho=0.999",
              tolerance = list(abs = 1e-8, rel = 1e-8), seed = 3, generated = stamp(),
              generator = GEN, note = paste0("kappa(R)=", round(kappa(R2)), ", kappa(R+lambda I)=", round(kappa(R2 + lambda * diag(12))))),
  inputs = list(R = R2, b = b2, lambda = lambda),
  reference = list(beta_ridge = as.numeric(solve(R2 + lambda * diag(12), b2)))),
  "equivalence/fixtures/switchstep-ridge.json")

cat("\nAll SwitchStep fixtures written. Verify with:  Rscript equivalence/check.R\n")
