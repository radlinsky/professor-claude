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
source(file.path(EQ, "reimplementations", "swap-stepwise.R"))
source(file.path(EQ, "reimplementations", "wakefield-abf.R"))
source(file.path(EQ, "reimplementations", "coloc-abf.R"))
source(file.path(EQ, "reimplementations", "proportional-colocalisation.R"))

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
  list(path = fixture("swap-stepwise-joint-from-summaries.json"),
       fn = function(inp) {
         j <- sw_joint(inp$R, inp$b)
         bicc <- vapply(inp$subsets, function(c) sw_bic(inp$R, inp$b, inp$n, c), numeric(1))
         list(beta = j$beta, r2 = j$r2, bic_centered = bicc - bicc[1])
       }),
  list(path = fixture("swap-stepwise-selection-clean.json"),
       fn = function(inp) list(selected = as.integer(seq_along(inp$b) %in% sw_search(inp$R, inp$b, inp$n)))),
  list(path = fixture("swap-stepwise-selection-collinear.json"),
       fn = function(inp) list(selected = as.integer(seq_along(inp$b) %in% sw_search(inp$R, inp$b, inp$n)))),
  list(path = fixture("swap-stepwise-rank1-bordering.json"),
       fn = function(inp) list(inv_grown = as.numeric(sw_border(inp$Mi, inp$b_new, inp$d)))),
  list(path = fixture("swap-stepwise-ridge.json"),
       fn = function(inp) list(beta_ridge = sw_ridge_joint(inp$R, inp$b, inp$lambda))),
  list(path = fixture("wakefield-abf-full-coloc.json"),
       fn = function(inp) list(labf = wakefield_abf(inp$beta, inp$se, inp$W))),
  list(path = fixture("coloc-abf-shared.json"),
       fn = function(inp) coloc_abf(inp$beta1, inp$se1, inp$beta2, inp$se2,
                                    inp$W1, inp$W2, inp$p1, inp$p2, inp$p12)),
  list(path = fixture("coloc-abf-distinct.json"),
       fn = function(inp) coloc_abf(inp$beta1, inp$se1, inp$beta2, inp$se2,
                                    inp$W1, inp$W2, inp$p1, inp$p2, inp$p12)),
  list(path = fixture("propcoloc-pairwise.json"),
       fn = function(inp) {
         m <- nrow(inp$beta1)
         out <- vapply(seq_len(m), function(i) {
           r <- prop_test_pair(inp$beta1[i, ], inp$vbeta1[i, ],
                               inp$beta2[i, ], inp$vbeta2[i, ], inp$rho[i])
           c(r$chisquare, r$eta_hat, r$p)
         }, numeric(3))
         list(chisquare = out[1, ], eta = out[2, ], p = out[3, ])
       }),
  list(path = fixture("propcoloc-run-shared.json"),
       fn = function(inp) prop_run(inp$beta1, inp$vbeta1, inp$beta2, inp$vbeta2,
                                   inp$LD, inp$pairs, inp$ntests)),
  list(path = fixture("propcoloc-run-distinct.json"),
       fn = function(inp) prop_run(inp$beta1, inp$vbeta1, inp$beta2, inp$vbeta2,
                                   inp$LD, inp$pairs, inp$ntests))
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
