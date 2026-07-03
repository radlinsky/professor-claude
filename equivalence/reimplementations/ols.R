# From-scratch ordinary least squares via the normal equations, base R only.
#
# Solves the same problem as numpy.linalg.lstsq (full tier, Python reference):
# find the coefficient vector b minimizing the sum of squared residuals ||X b - y||^2.
# For a full-rank design X, the minimizer solves the normal equations
# (X'X) b = X'y, which base R's solve() handles directly.
#
# X : design matrix, rows = observations, columns = predictors (intercept column
#     included explicitly by the caller / fixture, so both sides use the same X).
# y : response vector.
ols_reimpl <- function(X, y) {
  X <- as.matrix(X)
  y <- as.numeric(y)
  as.numeric(solve(t(X) %*% X, t(X) %*% y))
}
