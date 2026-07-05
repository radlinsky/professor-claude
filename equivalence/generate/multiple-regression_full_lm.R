# AUTHORING-TIME generator — FULL tier, reference = R's own stats::lm() / lm.fit().
#
# The "real library" being ported here is base R's linear-model fitter (stats::lm,
# which ships with R and fits by QR decomposition). We simulate an economic-indicator
# panel, fit lm(y ~ .), and freeze lm()'s coefficients, fitted values, residual sum of
# squares and R^2. The from-scratch normal-equations reimplementation
# (equivalence/reimplementations/multiple-regression.R) must reproduce those numbers.
#
# Two fixtures, tolerance-tiered:
#   multiple-regression-full-lm.json        — a normal panel (correlated twins up to
#                                              0.95); normal equations vs QR agree to ~1e-10.
#   multiple-regression-collinear-lm.json    — a near-collinear panel (one twin pair at
#                                              0.999). Squaring the design in the normal
#                                              equations squares the condition number, so
#                                              the two solvers agree only to a looser
#                                              tolerance — recorded honestly below.
#
# Run from the repo root (regenerate-all.sh runs it with renv's autoloader off so any
# jsonlite install lands in the separate lib, not the course renv):
#   RENV_CONFIG_AUTOLOADER_ENABLED=FALSE R_LIBS_USER=equivalence/env/rlib \
#     Rscript equivalence/generate/multiple-regression_full_lm.R

suppressWarnings(suppressMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    install.packages("jsonlite", repos = "https://cloud.r-project.org")
  }
  library(jsonlite)
}))

# The shared running example (spec §6). Signal sits on ONE member of each correlated
# twin pair, so marginal regressions flag both twins while the joint fit disentangles
# them. `rho_max` lets us dial the strongest twin correlation up for the collinear panel.
sim_indicators <- function(n = 30, seed = 1, rho_max = 0.95) {
  set.seed(seed)
  nm <- c("rate_10y", "rate_2y", "cpi_infl", "pce_infl", "unemp",
          "oil", "usd_index", "sentiment", "housing", "pmi",
          "credit_spread", "vix")
  p <- length(nm)
  R <- diag(p)
  dimnames(R) <- list(nm, nm)                                        # name the axes
  R["rate_10y", "rate_2y"] <- R["rate_2y", "rate_10y"] <- 0.90        # yield twins
  R["cpi_infl", "pce_infl"] <- R["pce_infl", "cpi_infl"] <- rho_max   # inflation twins
  R["sentiment", "pmi"]     <- R["pmi", "sentiment"]     <- 0.70
  R["credit_spread", "vix"] <- R["vix", "credit_spread"] <- 0.65
  X <- matrix(rnorm(n * p), n, p) %*% chol(R)
  colnames(X) <- nm
  beta <- setNames(numeric(p), nm)
  beta[c("rate_10y", "cpi_infl", "unemp")] <- c(0.5, -0.4, -0.3)      # sparse truth
  y <- drop(X %*% beta + rnorm(n, sd = 1))
  list(X = X, y = y)
}

# Fit lm() and package the frozen reference. The design matrix stored in the fixture
# includes the intercept column, so the reimplementation and lm() use the same X.
make_fixture <- function(seed, rho_max, tol_abs, tol_rel) {
  sim <- sim_indicators(n = 30, seed = seed, rho_max = rho_max)
  Xd  <- cbind(`(Intercept)` = 1, sim$X)      # explicit intercept column
  y   <- sim$y

  fit    <- lm(y ~ sim$X)                      # QR-based reference fit
  beta   <- unname(coef(fit))                  # intercept first, then 12 slopes
  fitted <- unname(fitted(fit))
  rss    <- sum(residuals(fit)^2)
  r2     <- summary(fit)$r.squared

  list(
    meta = list(
      slug = "multiple-regression",
      tier = "full",
      source = paste0("stats::lm (R ", R.version$major, ".", R.version$minor, ")"),
      tolerance = list(abs = tol_abs, rel = tol_rel),
      seed = seed,
      generated = format(Sys.time(), "%Y-%m-%dT%H:%M:%S%z"),
      generator = "equivalence/generate/multiple-regression_full_lm.R"
    ),
    inputs = list(X = Xd, y = y),
    reference = list(beta = beta, fitted = fitted, rss = rss, r2 = r2)
  )
}

write_fixture <- function(fx, out) {
  write_json(fx, out, auto_unbox = TRUE, digits = 15, pretty = TRUE)
  cat("wrote", out, "\n")
}

# Normal panel: twins up to 0.95 — normal equations vs QR agree to ~1e-10.
write_fixture(
  make_fixture(seed = 1, rho_max = 0.95, tol_abs = 1e-10, tol_rel = 1e-8),
  "equivalence/fixtures/multiple-regression-full-lm.json"
)

# Near-collinear panel: one twin pair at 0.999. Normal equations square the condition
# number, so agreement with lm()'s QR is looser — tolerance widened and documented.
write_fixture(
  make_fixture(seed = 2, rho_max = 0.999, tol_abs = 1e-6, tol_rel = 1e-6),
  "equivalence/fixtures/multiple-regression-collinear-lm.json"
)
