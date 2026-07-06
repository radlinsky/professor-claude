# From-scratch COLOC (Bayesian colocalisation) posterior probabilities, base R only.
#
# Rebuilds what coloc::coloc.abf computes (full tier, R reference): Giambartolomei et
# al. (2014, PLoS Genet 10(5):e1004383, doi:10.1371/journal.pgen.1004383) test whether
# two association studies over one genomic region share a single causal variant, using
# only per-SNP summary statistics.
#
# For each SNP the two traits each get a Wakefield log Bayes factor (see
# wakefield-abf.R): l1[i] for trait 1, l2[i] for trait 2. With per-SNP priors
#   p1  = P(a SNP is causal for trait 1 only)
#   p2  = P(a SNP is causal for trait 2 only)
#   p12 = P(a SNP is causal for BOTH traits)
# the (log) support for each of the five hypotheses is
#   H0 (no causal SNP):                    0
#   H1 (trait 1 only):                     log p1  + logsum(l1)
#   H2 (trait 2 only):                     log p2  + logsum(l2)
#   H3 (both, DISTINCT causal SNPs):       log p1 + log p2 + logdiff( logsum(l1)+logsum(l2), logsum(l1+l2) )
#   H4 (both, ONE SHARED causal SNP):      log p12 + logsum(l1 + l2)
# The H3 term is the "sum over i != j" trick in log space:
#   sum_{i!=j} BF1_i BF2_j = (sum BF1)(sum BF2) - sum_i BF1_i BF2_i.
# Normalising the five terms gives PP0..PP4; a large PP4 is the colocalisation signal.

# Depends on wakefield_abf() from wakefield-abf.R -- callers (check.R, the generator)
# source that file first.

# log-sum-exp: log(sum(exp(x))) computed stably.
.logsum <- function(x) {
  m <- max(x)
  m + log(sum(exp(x - m)))
}
# stable log(exp(x) - exp(y)) for x > y.
.logdiff <- function(x, y) {
  m <- max(x, y)
  m + log(exp(x - m) - exp(y - m))
}

# coloc_abf: five posterior probabilities PP0..PP4 from the two studies' summary stats.
#   beta1/se1, beta2/se2 : per-SNP effect estimates and standard errors (same SNP order)
#   W1, W2               : prior variance on the effect for each trait (coloc: sd.prior^2)
#   p1, p2, p12          : per-SNP colocalisation priors (coloc defaults 1e-4/1e-4/1e-5)
# Returns list(pp = c(H0, H1, H2, H3, H4)).
coloc_abf <- function(beta1, se1, beta2, se2, W1, W2,
                      p1 = 1e-4, p2 = 1e-4, p12 = 1e-5) {
  l1 <- wakefield_abf(beta1, se1, W1)      # per-SNP lABF, trait 1
  l2 <- wakefield_abf(beta2, se2, W2)      # per-SNP lABF, trait 2

  s1  <- .logsum(l1)                       # log sum BF1
  s2  <- .logsum(l2)                       # log sum BF2
  s12 <- .logsum(l1 + l2)                  # log sum_i BF1_i BF2_i

  lH0 <- 0
  lH1 <- log(p1)  + s1
  lH2 <- log(p2)  + s2
  lH3 <- log(p1)  + log(p2)  + .logdiff(s1 + s2, s12)
  lH4 <- log(p12) + s12

  all <- c(lH0, lH1, lH2, lH3, lH4)
  pp  <- exp(all - .logsum(all))           # normalise across the five hypotheses
  list(pp = pp)
}
