# Proportional Colocalisation — Syllabus

**Goal:** read the methods of Wallace, Robins & Johnson (2025) and the `colocPropTest`
interface, and rebuild the proportional colocalisation test from scratch in base R — so you can
explain *why* variable statistical information across SNPs biases fine-mapping and corrupts
`coloc` (confident but wrong H3-vs-H4 calls), and *how* the proportional test sidesteps
fine-mapping by asking whether two traits' effect estimates are proportional ($b_1 = \eta\,b_2$,
a line through the origin), testing it with a profiled Fieller $\chi^2$ statistic whose **null is
colocalisation**, and running it as all pairwise-variant tests with a multiplicity correction.

**Source:** Wallace, C., Robins, C. & Johnson, T. (2025). "Variable information across SNPs in
GWAS data can cause false rejections of colocalisation which can be resolved by proportional
colocalisation tests." *bioRxiv* 2025.09.08.674910, doi:10.1101/2025.09.08.674910. All three
authors are employees of GSK. The from-scratch reimplementation is validated against
`colocPropTest` 0.9.3 via this repo's equivalence harness.

**Source license:** paper is open access under **CC-BY 4.0** — OK; we transcribe its published
equations and attribute it in `resources.md`. The reference implementation `colocPropTest` is on
CRAN under **GPL** (copyleft) — we rebuild the method from scratch from the paper's equations and
copy no `colocPropTest` source → flagged, confirmed by human 2026-07-06. See
`.claude/course-authoring/source-licensing.md`.

## How to take this course

- **One module per sitting.** Lesson first, then its practice — don't split them.
- **Space it out.** Start the next sitting (ideally the next day) with the new lesson's Warm-up —
  it deliberately re-tests what you did last time. Don't binge the course in a day; the
  forgetting between sittings is what makes the warm-ups work.
- **The mastery rule:** move on only when every "What you can now do" bullet feels solid. Shaky
  bullet → redo that section or its practice problems first.
- **Answers are hidden for a reason.** Commit to an answer (or a prediction) before you click —
  that's the part that makes it stick.

## Before you start: course(s) this one builds on

This course reuses the anchors of a course you should have met already instead of re-teaching
them:

- [**Bayesian Colocalisation**](../bayesian-colocalisation/syllabus.md) — that course built
  `coloc_abf(...)`, which takes two traits' per-SNP Wakefield Bayes factors over a region and
  returns the five posterior probabilities, telling a **shared** causal variant (large PP4) from
  **distinct** ones (large PP3). **This course starts from that `coloc` machinery** — it shows
  how variable per-SNP information corrupts those PP3/PP4 calls, then offers a *different* test
  (proportional colocalisation) that never fine-maps. Its null hypothesis is the **opposite**
  framing: for `coloc`, a high PP4 *supports* colocalisation; for the proportional test, a
  **small p-value means NOT colocalised**. (That course in turn builds on
  [Approximate Bayes Factors](../approximate-bayes-factors/syllabus.md) and
  [Logistic Regression](../logistic-regression/syllabus.md); skim them only if a per-SNP Bayes
  factor or a GWAS effect estimate $\hat\beta$ and its standard error feel rusty.)

## Prerequisites from the foundations library

Take these first, in this order. Already done one (check its Status in
[foundations/README.md](../../foundations/README.md))? Skim its pronunciation table as a
refresher instead.

| Module | Why this course needs it |
|---|---|
| [reading-math-notation](../../foundations/reading-math-notation/lesson.qmd) | The standing first prerequisite — it decodes the accents, Greek letters, subscripts, and operators every other formula uses. New? take it fully; done before? skim its symbol table. |
| [matrices-and-linear-transforms](../../foundations/matrices-and-linear-transforms/lesson.qmd) | The test statistic is a matrix sandwich $d^\top V^{*-1} d$; you need matrix × vector, the transpose, and the inverse as "undo." |
| [distributions-and-densities](../../foundations/distributions-and-densities/lesson.qmd) | The statistic follows a $\chi^2$ distribution and effect estimates are normal; you need "density of an estimate" and the bell curve. |
| [variance-structure-and-standardization](../../foundations/variance-structure-and-standardization/lesson.qmd) | The LD covariance $V = (\sigma\sigma^\top)\odot\Sigma$ is a covariance matrix built from standard errors and a correlation matrix — read here first. |
| [hypothesis-tests-p-values-and-confidence-intervals](../../foundations/hypothesis-tests-p-values-and-confidence-intervals/lesson.qmd) | The whole method is a hypothesis test; you need p-values, the null, and Type I error — plus the twist that here the **null is colocalisation**. |
| [likelihood-and-log-likelihood](../../foundations/likelihood-and-log-likelihood/lesson.qmd) | The angle $\theta$ is removed by a profile-*likelihood* argument; you need the likelihood/MLE idea it rests on. |
| [quadratic-forms-and-the-chi-square-statistic](../../foundations/quadratic-forms-and-the-chi-square-statistic/lesson.qmd) | The Fieller statistic $X^2(\theta) = d^\top V^{*-1} d$ is exactly a standardised squared distance (a quadratic form) that is $\chi^2$-distributed — this is its skeleton. |
| [profile-likelihood](../../foundations/profile-likelihood/lesson.qmd) | The nuisance angle $\theta$ is profiled out by minimising $X^2$ over it, which is why the statistic ends up $\chi^2_{n-1}$ (one df lost to profiling). |
| [false-discovery-rate](../../foundations/false-discovery-rate/lesson.qmd) | The power fix runs *all* pairwise tests and corrects over the total number of pairs with `p.adjust`; you need multiple-testing, FWER vs FDR, and Holm vs Benjamini–Hochberg. |

## Course modules

### 1. When fine-mapping breaks (`modules/01-when-fine-mapping-breaks/`)

**Why you need this:** the paper's whole motivation — before any new test, see the *disease*:
variable statistical information across SNPs quietly biases fine-mapping, and worse as sample
sizes grow.
**You'll learn:** the per-SNP Bayes-factor → posterior recap (from the ABF and coloc courses,
linked not re-derived); why unequal sample size, imputation $r^2$, call rate, or even rounding
summary stats make Bayes factors non-comparable across SNPs; a base-R reproduction of the
Figure-1 intuition (two SNPs in perfect LD, impose information loss on one, watch its posterior
drift from the expected 0.5, more so at large $N$).
**Time:** ~35 min lesson + ~25 min practice

### 2. How it corrupts coloc (`modules/02-how-it-corrupts-coloc/`)

**Why you need this:** the bias doesn't stay in fine-mapping — it propagates straight into the
`coloc` you built, producing confident but wrong answers.
**You'll learn:** how biased per-SNP posteriors flow into coloc's PP3 (distinct) vs PP4 (shared)
split; the paper's headline result — up to 100% false H3 calls when the truth is H4, with
posteriors near 1; why this motivates a colocalisation test that does *no* fine-mapping at all.
**Time:** ~30 min lesson + ~25 min practice

### 3. Proportionality is colocalisation (`modules/03-proportionality-is-colocalisation/`)

**Why you need this:** the key reframing — a shared causal signal means the two traits' effect
estimates are *proportional*, a fact you can test without ever fine-mapping.
**You'll learn:** why colocalisation $\iff$ effects proportional, $b_1 = \eta\,b_2$, a straight
line through the origin through the $(b_{2,j}, b_{1,j})$ points (Figure 2 intuition); the
**null = colocalisation** framing and the p-value-means-NOT-colocalised flip (the #1 confusion
vs coloc); the LD covariance $V = (\sigma\sigma^\top)\odot\Sigma$ built inline from standard
errors and the LD matrix.
**Time:** ~35 min lesson + ~30 min practice

### 4. The proportional test statistic (`modules/04-the-proportional-test-statistic/`)

**Why you need this:** the math that turns "are these points on a line through the origin?" into
a single p-value.
**You'll learn:** Fieller's statistic; the $\theta = \arctan(\eta)$ reparametrisation (so
$\eta = 0$ or $\infty$ become finite angles); the quadratic form
$X^2(\theta) = d(\theta)^\top V^{*}(\theta)^{-1} d(\theta)$ (leaning on the quadratic-forms
foundation); profiling out $\theta$ (leaning on the profile-likelihood foundation) →
$\chi^2_{n-1}$; building `prop_V()` and `prop_test_pair()` in base R; a **live in-browser
self-check** against the frozen `propcoloc-pairwise` reference.
**Time:** ~40 min lesson + ~30 min practice

### 5. The pairwise correction (`modules/05-the-pairwise-fdr-adaptation/`)

**Why you need this:** one test over all $n$ variants is too weak, and picking two variants is
biased — the paper's power fix is the clever compromise.
**You'll learn:** why all-$n$ variants gives a weak $n-1$ df test and two-selected-variants
biases Type I error; the compromise of running *all* $n(n-1)/2$ pairwise tests and correcting
over all possible pairs, rejecting colocalisation if **any** pair is significant; the
min-marginal-p lower bound that lets you test only a subset; building `prop_run()` (pairwise loop
+ `p.adjust`); **live self-checks** against the frozen `propcoloc-run-shared` (not rejected) and
`propcoloc-run-distinct` (rejected) references; the honest FDR-vs-Holm note (the paper says
"FDR"; the package calls `p.adjust`'s default, Holm).
**Time:** ~40 min lesson + ~30 min practice

### 6. Capstone: reading colocPropTest (`modules/06-capstone-reading-colocproptest/`)

**Why you need this:** the goal made into an exercise — decode the paper's equations and the real
`colocPropTest` interface line by line, then assemble and validate the whole pipeline.
**You'll learn:** how to read the paper's $H_0: \beta_1 = \eta\gamma_2$, the Fieller/$\theta$
equations, and the `colocPropTest` interface — `run_proptests(S1, S2, LD, ...)`,
`estprop(b1,b2,V1,V2)`, `tester_marg`, `marg_with_V(beta,vbeta,rho)`, and the
`p.adjust(p, n = ntests)` step — backlinking each term to the module that built it; assembling
the full pipeline on a simulated two-trait region for shared and distinct scenarios; **live
self-checks** against the frozen references; the validation tier (full, vs `colocPropTest`
0.9.3); the paper's practical guidance (proportional testing requires *equal LD* between studies
but does *not* require the causal variant to be typed; use it as an *accompaniment* to coloc, not
a replacement).
**Time:** ~45 min lesson + ~35 min practice (cumulative)
