# Resources — Approximate Bayes Factors

Verified external explanations, one section per module. Watch/read after the lesson's toy
example, not before — the lesson builds the intuition these expand on.

## Module 01 — The summary of an association

- 📺 [StatQuest: p-values, What they are and how to interpret them](https://www.youtube.com/watch?v=vemZtEM63GY)
  (video) — Josh Starmer builds the p-value from scratch with small examples. This module
  treats the p-value as a transform of $Z$; watch this to solidify what that p-value *means*
  before you learn the ABF re-weighs the same evidence. (Title confirmed; StatQuest's
  small-example style suits this learner.)
- 📖 [Hypothesis tests, p-values & CIs (foundation)](../../foundations/hypothesis-tests-p-values-and-confidence-intervals/lesson.qmd)
  (this repo) — the prerequisite that builds the z-statistic estimate ÷ SE and the p-value.
  Skim its pronunciation table if $Z = \hat\beta/\text{se}$ isn't yet automatic.

## Module 02 — A prior on the effect

- 📖 [Normal distribution (Wikipedia)](https://en.wikipedia.org/wiki/Normal_distribution)
  (reference) — the density formula $f(x) = \tfrac{1}{\sqrt{2\pi\sigma^2}}
  \exp(-\tfrac{(x-\mu)^2}{2\sigma^2})$ and its two parameters (mean, variance). This module's
  two curves $N(0, V)$ and $N(0, V+W)$ are both this formula with different variances; skim the
  opening density section to see the exact form we divide in Module 3.
- 📖 [Marginal likelihood & model evidence (foundation)](../../foundations/marginal-likelihood-and-model-evidence/lesson.qmd)
  (this repo) — the prerequisite that proves averaging a normal estimate over a normal prior
  gives $N(0, V+W)$, the exact result the alternative curve uses. Re-read its "normal closed
  form" section if the variances-add step feels shaky.

## Module 03 — The Approximate Bayes Factor

- 📖 [Bayes factor (Wikipedia)](https://en.wikipedia.org/wiki/Bayes_factor)
  (reference) — the Bayes factor as a ratio of model evidences, with the Jeffreys and Kass &
  Raftery strength-interpretation scales ("barely worth mentioning / substantial / strong /
  decisive"). Read it to calibrate what an lABF of $6$ (BF $\approx 452$) actually means on the
  standard scale.
- 📖 [coloc: a package for colocalisation analyses (Wallace group vignette)](https://chr1swallace.github.io/coloc/articles/vignette.html)
  (written vignette with R code) — the maintainer's own walkthrough of the ABF and
  `coloc.abf`, with worked simulations and `finemap.abf`. This is the real package you rebuilt;
  read the ABF section to see your closed form in its native habitat. (More detail on priors is
  in the separate "sensitivity to prior values" vignette.)

## Module 04 — Posterior probability of association

- 📖 [Lindley's / Jeffreys–Lindley paradox (Wikipedia)](https://en.wikipedia.org/wiki/Jeffreys%E2%80%93Lindley_paradox)
  (reference) — the formal name for this module's headline: a fixed p-value and a Bayes factor
  can disagree, and the disagreement grows with sample size unless the significance threshold
  tightens as $n$ grows. Read it to see the exact result ("keeping the significance level fixed
  is not justified") behind Wakefield's argument.
- 📖 [Bayes factors & posterior odds (foundation)](../../foundations/bayes-factors-and-posterior-odds/lesson.qmd)
  (this repo) — the prerequisite that builds "posterior odds = prior odds × Bayes factor" and
  the medical-test anchor the PPA reuses. Re-read it if converting BF → PPA feels mechanical
  rather than intuitive.

## Module 05 — Capstone: reading Wakefield's ABF

- 📖 [coloc.abf reference documentation](https://rdrr.io/cran/coloc/man/coloc.abf.html)
  (reference) — the actual function signature and output (the `lABF` column, `SNP.PP.H4`, the
  H0–H4 posteriors). Use it to check your decode of the `coloc.abf` interface against the real
  docs.
- 📖 [coloc: a package for colocalisation analyses (Wallace group vignette)](https://chr1swallace.github.io/coloc/articles/vignette.html)
  (written vignette with R code) — the full worked pipeline from per-SNP ABF to regional
  posterior to the two-trait colocalisation hypotheses. Read the `coloc.abf` and `finemap.abf`
  sections to see the "what you still can't read (yet)" next step — combining two studies — in
  action.
- 📖 [coloc introduction vignette](https://chr1swallace.github.io/coloc/articles/a01_intro.html)
  (written, navigation guide) — a short map of the package's methods and which vignette covers
  what, noting the ABF method rests on "Jon Wakefield's work on determining approximate Bayes
  Factors." A good jumping-off point into the colocalisation material that follows this course.
