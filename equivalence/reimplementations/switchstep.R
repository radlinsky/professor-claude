# From-scratch SwitchStep: likelihood-based variable selection from summary statistics.
#
# Rebuilds the method Course B teaches, in base R, from only a predictor correlation
# matrix R and a vector b of marginal (standardized, one-at-a-time) coefficients — never
# the raw data. Each function is mirrored by a Course B lesson and checked against a
# runnable oracle in equivalence/check.R:
#   sw_joint       -> lm() on standardized data           (joint fit from summaries)
#   sw_bic         -> BIC(lm(...)) up to an additive const (summary-stat BIC)
#   sw_search      -> exhaustive best-subset BIC(lm)        (the switching search)
#   sw_border      -> fresh solve() of the grown matrix     (rank-1 bordering update)
#   sw_ridge_joint -> solve(R + lambda*I, b)                (ridge-stabilised reconstruction)

# Joint multiple-regression coefficients (standardized world) from summaries:
# in the standardized world the Gram matrix X'X/n IS the correlation matrix R and X'y/n
# IS the marginal-coefficient vector b, so the normal equations give beta = R^{-1} b.
# R^2 for standardized y is b' R^{-1} b.
sw_joint <- function(R, b) {
  R <- as.matrix(R); b <- as.numeric(b)
  beta <- solve(R, b)
  list(beta = as.numeric(beta), r2 = as.numeric(crossprod(b, beta)))
}

# Summary-stat BIC for a subset `cols` (indices into 1..p), up to an additive constant
# that is the same for every model on the same data (so model *comparisons* are exact).
# Standardized world: residual variance for subset S is 1 - R2_S, and the Gaussian
# -2 log-likelihood is n*log(1 - R2_S) plus that constant; the BIC penalty is k*log(n).
sw_bic <- function(R, b, n, cols) {
  cols <- as.integer(cols)
  if (length(cols) == 0) return(0)                       # empty model: R2 = 0, penalty 0
  RS <- as.matrix(R)[cols, cols, drop = FALSE]
  bS <- as.numeric(b)[cols]
  r2 <- as.numeric(crossprod(bS, solve(RS, bS)))
  n * log(1 - r2) + length(cols) * log(n)
}

# The switching search: from a start subset, repeatedly try every ADD / REMOVE / SWAP
# move and take the one that most improves BIC; stop when no move improves it.
sw_search <- function(R, b, n, start = integer(0)) {
  p <- length(as.numeric(b))
  cur <- sort(as.integer(start))
  cur_bic <- sw_bic(R, b, n, cur)
  repeat {
    moves <- list()
    for (j in setdiff(1:p, cur)) moves[[length(moves) + 1L]] <- sort(c(cur, j))         # add
    for (j in cur)              moves[[length(moves) + 1L]] <- setdiff(cur, j)           # remove
    for (j in cur) for (k in setdiff(1:p, cur))                                          # swap
      moves[[length(moves) + 1L]] <- sort(c(setdiff(cur, j), k))
    if (!length(moves)) break
    bics <- vapply(moves, function(m) sw_bic(R, b, n, m), numeric(1))
    best <- which.min(bics)
    if (bics[best] < cur_bic - 1e-9) { cur <- moves[[best]]; cur_bic <- bics[best] }
    else break
  }
  sort(cur)
}

# Bordering (block-inverse) rank-1 update: grow a k x k matrix M (whose inverse Mi is
# known) by one new row/column [b_new ; d], returning the (k+1) x (k+1) inverse WITHOUT
# re-inverting. This is the Sherman-Morrison/Woodbury family the search uses to add a
# predictor to R_S.
sw_border <- function(Mi, b_new, d) {
  Mi <- as.matrix(Mi); b_new <- as.numeric(b_new); d <- as.numeric(d)
  Mib <- Mi %*% b_new
  s   <- as.numeric(d - crossprod(b_new, Mib))           # Schur complement (scalar)
  TL  <- Mi + (Mib %*% t(Mib)) / s
  TR  <- -Mib / s
  rbind(cbind(TL, TR), c(t(TR), 1 / s))
}

# Ridge-stabilised joint reconstruction: add lambda down the diagonal of R before
# inverting, so it stays invertible even when predictors are near-collinear.
sw_ridge_joint <- function(R, b, lambda) {
  R <- as.matrix(R); b <- as.numeric(b)
  as.numeric(solve(R + lambda * diag(nrow(R)), b))
}
