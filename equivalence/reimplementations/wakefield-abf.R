# From-scratch WAKEFIELD APPROXIMATE BAYES FACTOR, base R only.
#
# Rebuilds what coloc's approx.bf.estimates computes (full tier, R reference):
# Wakefield (2009, Genet Epidemiol 33:79-86, doi:10.1002/gepi.20359) turns a single
# association's summary statistics into a Bayes factor with a closed form -- no MCMC.
#
# Inputs per SNP: an effect estimate beta (a log odds ratio) and its standard error
# se, so the variance is V = se^2 and the usual z-statistic is z = beta / se. Put a
# normal prior N(0, W) on the true effect. The marginal (prior-predictive) density of
# beta is N(0, V) under the null and N(0, V + W) under the alternative; the Bayes
# factor is the ratio of those two normal densities at the observed beta, which
# collapses to the closed form below.
#
# We report lABF in coloc's SIGN CONVENTION: the LOG Bayes factor FOR association
# (alternative over null), so a LARGER lABF means MORE evidence of association. With
# r = W / (W + V):
#
#   lABF = 0.5 * ( log(1 - r) + r * z^2 )
#
# Because 1 - r = V/(V+W) and r = W/(V+W), this equals
#   -0.5*log((V+W)/V) + 0.5 * z^2 * W/(V+W),
# i.e. exp(lABF) = sqrt(V/(V+W)) * exp( 0.5 * z^2 * W/(V+W) ).
# (Wakefield's own ABF is the reciprocal -- null over alternative -- so his "small ABF
# = strong association"; coloc flips the sign so "large lABF = strong association".)

# Core: log Bayes factor for association from z-statistic, variance V, prior variance W.
# Vectorised over z / V (W is a scalar prior). Matches coloc:::approx.bf.estimates.
wakefield_labf <- function(z, V, W) {
  r <- W / (W + V)
  0.5 * (log(1 - r) + r * z^2)
}

# Convenience wrapper taking the raw summary statistics (beta, se) a course starts from.
# Returns the per-SNP lABF vector (coloc sign convention).
wakefield_abf <- function(beta, se, W) {
  z <- beta / se
  V <- se^2
  wakefield_labf(z, V, W)
}

# Posterior probability of association for a SINGLE variant, from its lABF and the
# prior odds of association pi/(1-pi). posterior odds = prior odds * BF; PPA = PO/(1+PO).
wakefield_ppa <- function(labf, prior = 1e-4) {
  prior_odds <- prior / (1 - prior)
  po <- prior_odds * exp(labf)
  po / (1 + po)
}
