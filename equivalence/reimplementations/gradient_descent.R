# From-scratch gradient descent for fitting a line, base R only.
#
# Fits y ~ b0 + b1*x by minimizing the mean squared error: start anywhere, then take
# repeated steps DOWNHILL. "Downhill" is found WITHOUT any calculus rules — the slope
# of the error in each direction is measured NUMERICALLY (nudge the parameter up and
# down, rise over run), the exact building block the gradient-descent course teaches
# (foundation: derivative-as-slope; Module 02: the gradient as a vector of such slopes).
#
# Validated (full tier) against scipy.optimize.minimize(method="L-BFGS-B") — a
# compiled-Fortran quasi-Newton optimizer. Both roads minimize the same bowl-shaped
# error, so the from-scratch coefficients match scipy's converged coefficients to
# tolerance. Written exactly the way Module 03 builds it, so it runs unchanged in a
# live {webr} cell in the browser.
#
# x, y   : the data (predictor, response) — the exact numbers the reference saw.
# lr     : learning rate (how big a step to take each iteration).
# n_iter : how many downhill steps to take.
# Returns c(intercept, slope) — the coefficients at the bottom of the bowl. (check.R
# names this `coef` to line it up with the fixture's `reference` key.)
gradient_descent_reimpl <- function(x, y, lr, n_iter) {
  x <- as.numeric(x)
  y <- as.numeric(y)

  # The loss: mean squared error of the candidate line b[1] + b[2]*x.
  mse <- function(b) mean((b[1] + b[2] * x - y)^2)

  # The gradient: the slope of that loss in each parameter direction, measured
  # numerically (central difference — nudge up, nudge down, rise over run).
  grad <- function(b, h = 1e-5) {
    c((mse(b + c(h, 0)) - mse(b - c(h, 0))) / (2 * h),
      (mse(b + c(0, h)) - mse(b - c(0, h))) / (2 * h))
  }

  b <- c(0, 0)                       # start: intercept 0, slope 0
  for (i in seq_len(n_iter)) {
    b <- b - lr * grad(b)            # step downhill (opposite the gradient)
  }
  b
}
