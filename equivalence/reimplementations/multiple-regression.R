# From-scratch MULTIPLE linear regression via the normal equations, base R only.
#
# Rebuilds what stats::lm() / stats::lm.fit() compute (full tier, R reference): for a
# full-rank design X, the coefficient vector b that minimises the sum of squared
# residuals ||y - X b||^2 solves the normal equations (X'X) b = X'y, which base R's
# solve() handles directly. From b we get the fitted values, the residual sum of
# squares, and R^2 — the four numbers a course rebuilds and checks against lm().
#
# X : design matrix, rows = observations, columns = predictors. The INTERCEPT column
#     of 1s is included explicitly by the caller / fixture, so the reimplementation and
#     lm(y ~ .) (which adds its own intercept) are compared on the same design.
# y : response vector.
#
# Returns a named list matching the fixture's `reference` keys:
#   beta   : the coefficient vector (intercept first, then one per column of X)
#   fitted : the predicted values  X b
#   rss    : residual sum of squares  sum((y - fitted)^2)
#   r2     : coefficient of determination  1 - rss / tss,  tss = sum((y - mean(y))^2)
multiple_regression_reimpl <- function(X, y) {
  X <- as.matrix(X)
  y <- as.numeric(y)

  beta   <- as.numeric(solve(t(X) %*% X, t(X) %*% y))   # (X'X) b = X'y
  fitted <- as.numeric(X %*% beta)                       # predictions
  resid  <- y - fitted
  rss    <- sum(resid^2)                                 # residual sum of squares
  tss    <- sum((y - mean(y))^2)                         # total sum of squares
  r2     <- 1 - rss / tss                                # fraction of variance explained

  list(beta = beta, fitted = fitted, rss = rss, r2 = r2)
}
