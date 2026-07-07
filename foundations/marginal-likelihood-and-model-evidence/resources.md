# Resources — Marginal likelihood and model evidence

External explanations of the marginal likelihood (model evidence). Use them after the
lesson's toy example, to see the same "average over the prior" idea in another voice.

- 📖 [The Marginal Likelihood as Model Evidence, Explained Simply (MetricGate)](https://metricgate.com/blogs/model-evidence-marginal-likelihood/)
  (written post, ~2,000–2,500 words) — opens with "ask a frequentist / ask a Bayesian,"
  defines the marginal likelihood as "a prior-weighted average of the likelihood," and
  works a full R simulation of two competing Normal-mean models showing the evidence peak
  then fall as the prior gets vaguer (the built-in Occam's razor) — plain language, worked
  R, and the same averaging-not-maximizing point the lesson makes.
  Read after the "Getting a feel for it" section.
- 📖 [Marginal likelihood (Wikipedia)](https://en.wikipedia.org/wiki/Marginal_likelihood)
  (reference article) — states the definition as "a likelihood function integrated over
  the parameter space" and connects it to Bayes factors and model comparison, and is
  honest that marginal likelihoods are usually hard to compute (which is exactly why the
  normal closed form the lesson teaches is so valuable). Skim it for the formal $\int
  L(\theta)P(\theta)\,d\theta$ statement once the intuition is solid; heavier going than
  the post above, so use it second.
- 🎮 [Seeing Theory: Bayesian Inference (Brown University)](https://seeing-theory.brown.edu/bayesian-inference/index.html)
  (interactive) — the "Likelihood Function" and "Prior to Posterior" panels let you pick a
  distribution, set a sample size, and watch the likelihood and posterior curves respond as
  data arrive. Great for *feeling* how a prior reshapes the likelihood before you average
  over it. Play with it alongside the lesson's "Explore it" cells.
