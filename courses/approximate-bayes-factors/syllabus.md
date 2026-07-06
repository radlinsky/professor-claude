# Approximate Bayes Factors — Syllabus

**Goal:** read Wakefield's (2009) Approximate Bayes Factor paper and the
`coloc::approx.bf.estimates` / `coloc.abf` interface, and rebuild the ABF from scratch in
base R — turning a single genetic association's summary statistics $(\hat\beta, V)$ into a
Bayes factor and a posterior probability of association, and explaining every symbol in
the closed form $\text{lABF} = \tfrac12\big(\log(1-r) + r Z^2\big)$.

**Source:** Wakefield, J. (2009). "Bayes factors for genome-wide association studies:
comparison with P-values." *Genetic Epidemiology* 33(1):79–86, doi:10.1002/gepi.20359.
The from-scratch reimplementation is validated against `coloc::coloc.abf` 5.2.3 via this
repo's equivalence harness.

**Source license:** paper is © John Wiley & Sons (Genetic Epidemiology) — we transcribe
its published equations only (facts/formulas are not copyrightable) and copy no text; the
reference implementation `coloc` is GPL-3 (≥2) — we rebuild the method from scratch from
the paper's equations and copy no `coloc` source. GPL is copyleft → flagged, confirmed by
human 2026-07-05. See `.claude/course-authoring/source-licensing.md`.

## How to take this course

- **One module per sitting.** Lesson first, then its practice — don't split them.
- **Space it out.** Start the next sitting (ideally the next day) with the new
  lesson's Warm-up — it deliberately re-tests what you did last time. Don't binge
  the course in a day; the forgetting between sittings is what makes the warm-ups
  work.
- **The mastery rule:** move on only when every "What you can now do" bullet feels
  solid. Shaky bullet → redo that section or its practice problems first.
- **Answers are hidden for a reason.** Commit to an answer (or a prediction) before
  you click — that's the part that makes it stick.

## Before you start: course(s) this one builds on

This course reuses the anchors of a course you should have met already instead of
re-teaching them:

- [**Logistic Regression**](../logistic-regression/syllabus.md) — a GWAS effect estimate
  $\hat\beta$ is a **log odds ratio**, exactly the coefficient on the log-odds scale you
  built there, with its standard error. This course starts from that $(\hat\beta, \text{se})$
  pair and never re-derives how it was fitted. (Logistic regression in turn builds on
  [Simple Linear Regression](../simple-linear-regression/syllabus.md) and
  [Gradient Descent](../gradient-descent/syllabus.md) — skim those only if the idea of a
  fitted coefficient and its standard error is rusty.)

## Prerequisites from the foundations library

Take these first, in this order. Already done one (check its Status in
[foundations/README.md](../../foundations/README.md))? Skim its pronunciation table as a
refresher instead.

| Module | Why this course needs it |
|---|---|
| [reading-math-notation](../../foundations/reading-math-notation/lesson.qmd) | The standing first prerequisite — it decodes the accents, Greek letters, subscripts, and operators every other formula uses. New? take it fully; done before? skim its symbol table. |
| [probability-and-odds](../../foundations/probability-and-odds/lesson.qmd) | The posterior step converts freely between probability and odds — prior odds $=\pi/(1-\pi)$, and posterior probability from posterior odds. |
| [distributions-and-densities](../../foundations/distributions-and-densities/lesson.qmd) | The whole method is built on the normal density `dnorm` and the curve $N(\mu,\sigma^2)$ — the estimate's density and the prior are both normal curves. |
| [likelihood-and-log-likelihood](../../foundations/likelihood-and-log-likelihood/lesson.qmd) | The Bayes factor is a ratio of likelihoods (here, marginal ones); you need "how probable is my data as the parameter varies." |
| [priors-posteriors-and-updating](../../foundations/priors-posteriors-and-updating/lesson.qmd) | The prior $N(0,W)$ on the true effect, and posterior $\propto$ prior $\times$ likelihood, are the Bayesian scaffolding of the ABF. |
| [hypothesis-tests-p-values-and-confidence-intervals](../../foundations/hypothesis-tests-p-values-and-confidence-intervals/lesson.qmd) | The p-value is the ABF's rival; you need the z-statistic $Z=\hat\beta/\text{se}$ and "a p-value is a transform of Z" to make the comparison the paper's headline result rests on. |
| [marginal-likelihood-and-model-evidence](../../foundations/marginal-likelihood-and-model-evidence/lesson.qmd) | The engine of the ABF: averaging the likelihood over the prior, and the normal closed form that the density of an estimate under a prior $N(0,W)$ is $N(0,V+W)$. |
| [bayes-factors-and-posterior-odds](../../foundations/bayes-factors-and-posterior-odds/lesson.qmd) | The ABF *is* a Bayes factor — a ratio of two model evidences — run through "posterior odds = prior odds × Bayes factor." |

## Course modules

### 1. The summary of an association (`modules/01-the-summary-of-an-association/`)

**Why you need this:** everything Wakefield and `coloc` ever see is the pair
$(\hat\beta, V)$ — this module gets you from a fitted association to that pair, and shows a
p-value is just a transform of it.
**You'll learn:** the effect estimate $\hat\beta$ (a log odds ratio) and its standard error;
variance $V = \text{se}^2$; the z-statistic $Z = \hat\beta/\sqrt{V}$; the p-value as a
transform of $Z$; why the pair $(\hat\beta, V)$ is a sufficient summary.
**Time:** ~30 min lesson + ~25 min practice

### 2. A prior on the effect (`modules/02-a-prior-on-the-effect/`)

**Why you need this:** the Bayesian half of the ABF is a normal prior on the true effect —
this module puts it there and derives the two competing marginal curves.
**You'll learn:** the prior $\theta \sim N(0, W)$; the two marginals $N(0, V)$ under the
null and $N(0, V+W)$ under the alternative; what $W$ encodes (the plausible odds-ratio
range, `sd.prior = 0.2` $\Rightarrow W = 0.04$); MAF-dependent priors.
**Time:** ~30 min lesson + ~25 min practice

### 3. The Approximate Bayes Factor (`modules/03-the-approximate-bayes-factor/`)

**Why you need this:** this is the method — the Bayes factor as the ratio of the two
Gaussian marginals, collapsed to a closed form you build in base R.
**You'll learn:** the derivation of $\text{lABF} = \tfrac12\big(\log(1-r) + r Z^2\big)$
with $r = W/(W+V)$; building `wakefield_abf(beta, se, W)` from scratch; a live in-browser
self-check against the frozen `coloc` reference numbers.
**Time:** ~40 min lesson + ~30 min practice

### 4. Posterior probability of association (`modules/04-posterior-probability-of-association/`)

**Why you need this:** a Bayes factor isn't yet a probability — this module runs it through
prior odds to a posterior probability, and stages the paper's headline p-value comparison.
**You'll learn:** prior odds $=\pi/(1-\pi)$; posterior odds $=$ prior odds $\times$ BF;
posterior probability of association (PPA); why an honest significance threshold must
*shrink* as sample size grows; the prior that makes ABF and p-value *rankings* identical.
**Time:** ~35 min lesson + ~30 min practice

### 5. Capstone: reading Wakefield's ABF (`modules/05-capstone-reading-wakefields-abf/`)

**Why you need this:** the goal made into an exercise — decode the paper's own equations
and the `coloc` interface line by line, then assemble and validate the whole method.
**You'll learn:** how to read Wakefield's equations (including his reciprocal sign
convention) and `coloc::approx.bf.estimates` / `coloc.abf`; assembling the full
`wakefield_abf()` and running it on a simulated multi-SNP GWAS region; a live self-check
against the frozen reference; the validation tier (full, vs `coloc` 5.2.3).
**Time:** ~40 min lesson + ~35 min practice (cumulative)
