#!/usr/bin/env Rscript
# equivalence/check.R
#
# Run every frozen fixture's from-scratch reimplementation against its reference and
# report pass/fail. Exits 1 if ANY target fails, so CI and pre-commit hooks can gate
# on it. This is the LIGHT half of the harness: it needs only base R + jsonlite (no
# reference library, no compiler, no venv) because every reference is already frozen
# in its fixture. Regenerating the fixtures from the real libraries is the separate,
# heavy authoring step — see equivalence/generate/regenerate-all.sh.
#
# Usage (from anywhere):  Rscript equivalence/check.R

# Resolve this script's own directory so paths work from any CWD.
.args <- commandArgs(trailingOnly = FALSE)
.file <- sub("^--file=", "", .args[grep("^--file=", .args)])
EQ <- if (length(.file)) normalizePath(dirname(.file)) else "equivalence"

source(file.path(EQ, "harness.R"))
source(file.path(EQ, "reimplementations", "trapz.R"))
source(file.path(EQ, "reimplementations", "ols.R"))
source(file.path(EQ, "reimplementations", "welford.R"))
source(file.path(EQ, "reimplementations", "gradient_descent.R"))
source(file.path(EQ, "reimplementations", "multiple-regression.R"))
source(file.path(EQ, "reimplementations", "switchstep.R"))

fixture <- function(name) file.path(EQ, "fixtures", name)

# Each target: a fixture + the reimplementation call that must reproduce it. The
# reimpl closure returns a named list whose names match the fixture's `reference`.
targets <- list(
  list(path = fixture("trapz-full-pracma.json"),
       fn = function(inp) list(integral = trapz_reimpl(inp$x, inp$y))),
  list(path = fixture("trapz-fallback-analytic.json"),
       fn = function(inp) list(integral = trapz_reimpl(inp$x, inp$y))),
  list(path = fixture("ols-full-numpy.json"),
       fn = function(inp) list(coef = ols_reimpl(inp$X, inp$y))),
  list(path = fixture("welford-full-c.json"),
       fn = function(inp) welford_reimpl(inp$x)),
  list(path = fixture("gradient-descent-full-scipy.json"),
       fn = function(inp) list(coef = gradient_descent_reimpl(inp$x, inp$y, inp$lr, inp$n_iter))),
  list(path = fixture("multiple-regression-full-lm.json"),
       fn = function(inp) multiple_regression_reimpl(inp$X, inp$y)),
  list(path = fixture("multiple-regression-collinear-lm.json"),
       fn = function(inp) multiple_regression_reimpl(inp$X, inp$y)),
  list(path = fixture("switchstep-joint-from-summaries.json"),
       fn = function(inp) {
         j <- sw_joint(inp$R, inp$b)
         bicc <- vapply(inp$subsets, function(c) sw_bic(inp$R, inp$b, inp$n, c), numeric(1))
         list(beta = j$beta, r2 = j$r2, bic_centered = bicc - bicc[1])
       }),
  list(path = fixture("switchstep-selection-clean.json"),
       fn = function(inp) list(selected = as.integer(seq_along(inp$b) %in% sw_search(inp$R, inp$b, inp$n)))),
  list(path = fixture("switchstep-selection-collinear.json"),
       fn = function(inp) list(selected = as.integer(seq_along(inp$b) %in% sw_search(inp$R, inp$b, inp$n)))),
  list(path = fixture("switchstep-rank1-bordering.json"),
       fn = function(inp) list(inv_grown = as.numeric(sw_border(inp$Mi, inp$b_new, inp$d)))),
  list(path = fixture("switchstep-ridge.json"),
       fn = function(inp) list(beta_ridge = sw_ridge_joint(inp$R, inp$b, inp$lambda)))
)

cat("== Professor Claude — equivalence checks ==\n\n")
results <- lapply(targets, function(t) {
  if (!file.exists(t$path)) {
    cat(sprintf("[MISSING] %s — run equivalence/generate/regenerate-all.sh\n", t$path))
    return(list(pass = FALSE))
  }
  print_check(check_fixture(t$path, t$fn))
})

n_pass <- sum(vapply(results, function(r) isTRUE(r$pass), logical(1)))
n_total <- length(results)
cat(sprintf("\n%d/%d targets passed.\n", n_pass, n_total))
if (n_pass < n_total) quit(status = 1L)
