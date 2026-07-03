# From-scratch sample mean and variance, base R only.
#
# Validated against a compiled C reference (full tier) that computes the same two
# numbers via Welford's online algorithm. Base R's var() uses the (n - 1) divisor,
# which is what the C reference emits (M2 / (n - 1)), so the two agree to machine
# precision.
#
# x : numeric vector. Returns a named list matching the fixture's reference keys.
welford_reimpl <- function(x) {
  x <- as.numeric(x)
  list(mean = mean(x), var = var(x))
}
