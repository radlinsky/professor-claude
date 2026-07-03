# From-scratch trapezoidal integration, base R only.
#
# This is the kind of "rebuilt from scratch in teachable pieces" function a Stage-4
# course would walk the learner up to. It is validated against a real library
# (pracma::trapz, full tier) AND against a closed-form integral (fallback tier) —
# the same reimplementation, checked two different ways.
#
# Approximates the integral of y with respect to x by summing trapezoids:
# each adjacent pair contributes (width) * (average height).
trapz_reimpl <- function(x, y) {
  x <- as.numeric(x)
  y <- as.numeric(y)
  n <- length(x)
  sum((x[-1] - x[-n]) * (y[-1] + y[-n]) / 2)
}
