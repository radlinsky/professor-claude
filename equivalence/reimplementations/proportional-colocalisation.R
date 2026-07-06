# From-scratch PROPORTIONAL COLOCALISATION TEST, base R only.
#
# Rebuilds what the coloc PropTest package computes (full tier, R reference):
# Wallace, Robins & Johnson (2025, bioRxiv 2025.09.08.674910) test whether two GWAS
# traits over one region share a causal signal by asking whether their per-SNP effect
# estimates are PROPORTIONAL -- b1 = eta * b2 -- i.e. the points (b2_j, b1_j) fall on a
# straight line through the origin. Unlike coloc.abf (which fine-maps and is biased when
# statistical information varies across SNPs), this absorbs that information through the
# standard errors. The null hypothesis here is COLOCALISATION, so a small p-value means
# NOT colocalised.
#
# The test statistic (Fieller): for a set of SNPs with effect estimates b1, b2 and their
# variance-covariance matrices V1, V2, and eta reparametrised as theta = atan(eta),
#   d(theta)     = sin(theta) * b1 - cos(theta) * b2
#   Vstar(theta) = sin(theta)^2 * V1 + cos(theta)^2 * V2
#   X2(theta)    = d(theta)' Vstar(theta)^{-1} d(theta)
# Profiling out theta (minimising X2 over theta in (0, pi)) gives a statistic that is
# chi-squared with n-1 degrees of freedom under the null. For a PAIR of SNPs, n = 2, so
# df = 1. This matches colocPropTest::estprop / estprop_slow.

# Variance-covariance of a pair of marginal effect estimates: V = (sigma sigma') (.) Sigma,
# with sigma = sqrt(vbeta) the standard errors and Sigma = [[1, rho],[rho, 1]] the LD
# (correlation) between the two SNPs. Matches colocPropTest::marg_with_V.
prop_V <- function(vbeta, rho) {
  V <- diag(vbeta)
  V[1, 2] <- V[2, 1] <- sqrt(vbeta[1] * vbeta[2]) * rho
  V
}

# Profiled Fieller chi-square for one set of SNPs (works for the pairwise case n = 2).
# Returns eta_hat, the chi-square statistic, theta_hat, and the df = length(b1) - 1.
prop_test <- function(b1, b2, V1, V2) {
  chisq <- function(theta) {
    d     <- sin(theta) * b1 - cos(theta) * b2
    Vstar <- sin(theta)^2 * V1 + cos(theta)^2 * V2
    as.numeric(t(d) %*% solve(Vstar, d))
  }
  # theta lives in (0, pi); split at pi/2 (where eta -> infinity) and take the better min,
  # exactly as colocPropTest does, so we find the global minimum robustly.
  o_left  <- optimize(chisq, interval = c(0, pi / 2))
  o_right <- optimize(chisq, interval = c(pi / 2, pi))
  o <- if (o_left$objective < o_right$objective) o_left else o_right
  list(eta_hat = tan(o$minimum), chisquare = o$objective,
       theta_hat = o$minimum, df = length(b1) - 1L)
}

# Convenience: the pairwise test straight from summary statistics for two SNPs.
#   beta1/vbeta1, beta2/vbeta2 : the two traits' effect estimates & variances at the pair
#   rho1, rho2                 : LD between the pair in each study (usually equal)
# Returns the chi-square and its df = 1 p-value.
prop_test_pair <- function(beta1, vbeta1, beta2, vbeta2, rho1, rho2 = rho1) {
  r <- prop_test(beta1, beta2, prop_V(vbeta1, rho1), prop_V(vbeta2, rho2))
  r$p <- pchisq(r$chisquare, df = r$df, lower.tail = FALSE)
  r
}

# Run the pairwise tests over a supplied list of SNP-index pairs and apply the multiplicity
# correction colocPropTest uses: p.adjust over the TOTAL number of possible pairs (ntests),
# rejecting colocalisation if any adjusted value is small. (colocPropTest calls p.adjust
# with its default method -- Holm -- despite naming the column `fdr`.)
#   beta1, vbeta1, beta2, vbeta2 : per-SNP vectors (same SNP order, same length)
#   LD                           : SNP x SNP correlation matrix
#   pairs                        : 2 x m matrix of 1-based index pairs (i < j) to test
#   ntests                       : denominator for the correction (default = all n(n-1)/2)
#   method                       : p.adjust method (default "holm", matching the package)
prop_run <- function(beta1, vbeta1, beta2, vbeta2, LD, pairs,
                     ntests = NULL, method = "holm") {
  n <- length(beta1)
  if (is.null(ntests)) ntests <- n * (n - 1) / 2
  chi <- numeric(ncol(pairs)); p <- numeric(ncol(pairs))
  for (m in seq_len(ncol(pairs))) {
    i <- pairs[1, m]; j <- pairs[2, m]
    r <- prop_test_pair(beta1[c(i, j)], vbeta1[c(i, j)],
                        beta2[c(i, j)], vbeta2[c(i, j)], LD[i, j])
    chi[m] <- r$chisquare; p[m] <- r$p
  }
  adjusted <- p.adjust(p, method = method, n = ntests)
  list(chisquare = chi, p = p, adjusted = adjusted, min_adjusted = min(adjusted))
}
