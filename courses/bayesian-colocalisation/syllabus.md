# Bayesian Colocalisation — Syllabus

**Goal:** read the methods of Giambartolomei et al. (2014) and the `coloc::coloc.abf`
interface, and rebuild the colocalisation test from scratch in base R — taking two
studies' per-SNP Wakefield Bayes factors over one region and combining them, with the
priors $p_1, p_2, p_{12}$, into the five posterior probabilities $\text{PP0}\dots\text{PP4}$,
and explaining every term of $\ell_{H_3}$ and $\ell_{H_4}$ (including the $\sum_{i\neq j}$
trick) so you can tell a **shared** causal variant (large PP4) from **distinct** ones
(large PP3).

**Source:** Giambartolomei, C. et al. (2014). "Bayesian test for colocalisation between
pairs of genetic association studies using summary statistics." *PLoS Genetics*
10(5):e1004383, doi:10.1371/journal.pgen.1004383. The from-scratch reimplementation is
validated against `coloc::coloc.abf` 5.2.3 via this repo's equivalence harness.

**Source license:** paper is open access under **CC-BY 4.0** — OK; we transcribe its
published equations and attribute it in `resources.md`. The reference implementation
`coloc` is **GPL-3** (copyleft) — we rebuild the method from scratch from the paper's
equations and copy no `coloc` source → flagged, confirmed by human 2026-07-05. See
`.claude/course-authoring/source-licensing.md`.

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

- [**Approximate Bayes Factors**](../approximate-bayes-factors/syllabus.md) — that
  course built `wakefield_abf(beta, se, W)`, which turns one SNP's summary statistics
  $(\hat\beta, \text{se})$ into a log Bayes factor for association (coloc sign
  convention: large = strong). **This course starts from those per-SNP log Bayes
  factors** — one vector `l1` for trait 1, one vector `l2` for trait 2 — and never
  re-derives the ABF; it combines them across a region and across two traits.
  (That course in turn builds on [Logistic Regression](../logistic-regression/syllabus.md),
  because a GWAS effect $\hat\beta$ is a log odds ratio; skim it only if a fitted
  coefficient and its standard error feel rusty.)

## Prerequisites from the foundations library

Take these first, in this order. Already done one (check its Status in
[foundations/README.md](../../foundations/README.md))? Skim its pronunciation
table as a refresher instead.

| Module | Why this course needs it |
|---|---|
| [reading-math-notation](../../foundations/reading-math-notation/lesson.qmd) | The standing first prerequisite — it decodes the accents, Greek letters, subscripts, and operators every other formula uses. New? take it fully; done before? skim its symbol table. |
| [distributions-and-densities](../../foundations/distributions-and-densities/lesson.qmd) | A Wakefield Bayes factor is a ratio of two normal densities; you need "density of an estimate" to know what each per-SNP number means before you combine them. |
| [likelihood-and-log-likelihood](../../foundations/likelihood-and-log-likelihood/lesson.qmd) | The whole test is built by adding and multiplying likelihood-like quantities in **log space** — you need "why we work with logs of probabilities." |
| [priors-posteriors-and-updating](../../foundations/priors-posteriors-and-updating/lesson.qmd) | Each hypothesis $H_0\dots H_4$ gets a prior weight ($p_1, p_2, p_{12}$) that multiplies its evidence; normalising the five is Bayesian updating over five models. |
| [marginal-likelihood-and-model-evidence](../../foundations/marginal-likelihood-and-model-evidence/lesson.qmd) | Each hypothesis's support is a model evidence — the likelihood of the region's data *under that hypothesis*, summed over which SNP is causal; this is exactly averaging over a discrete prior. |
| [bayes-factors-and-posterior-odds](../../foundations/bayes-factors-and-posterior-odds/lesson.qmd) | The five hypotheses are compared by their evidences $\times$ priors, then turned into posterior probabilities — the same "posterior odds = prior odds × Bayes factor" machinery, extended from two models to five. |

## Course modules

### 1. The colocalisation question (`modules/01-the-colocalisation-question/`)

**Why you need this:** before any formula, you need the picture — two studies over one
stretch of genome, and the yes/no question that the whole method answers.
**You'll learn:** what a genomic region and two association studies (a GWAS and an eQTL)
are; the plain-English question "do these two traits share a causal variant?"; that each
SNP in each trait already has a Wakefield log Bayes factor from the ABF course; setting up
the two per-SNP vectors $\ell_1$ and $\ell_2$.
**Time:** ~30 min lesson + ~25 min practice

### 2. Five hypotheses (`modules/02-five-hypotheses/`)

**Why you need this:** the method's whole output is five numbers — this module makes each
of the five hypotheses a concrete statement about the region, so PP3 and PP4 mean
something before you compute them.
**You'll learn:** $H_0$–$H_4$ as statements about the region (no signal / trait-1 only /
trait-2 only / both but distinct SNPs / both sharing one SNP); the idea of a
*configuration* of which SNP is causal for which trait; **PP3 (distinct) vs PP4 (shared)**
as the two outcomes that matter; the per-SNP priors $p_1, p_2, p_{12}$ and coloc's
defaults ($10^{-4}, 10^{-4}, 10^{-5}$).
**Time:** ~35 min lesson + ~25 min practice

### 3. Combining ABFs with priors (`modules/03-combining-abfs-with-priors/`)

**Why you need this:** this is the method — turning $\ell_1$, $\ell_2$, and the priors
into the five posterior probabilities, all in numerically stable log space.
**You'll learn:** the log-support formulas $\ell_{H_0}\dots\ell_{H_4}$; the
$\sum_{i\neq j}$ identity $\big(\sum \text{BF}_1\big)\big(\sum \text{BF}_2\big) -
\sum_i \text{BF}_{1,i}\text{BF}_{2,i}$ and its log-space `logdiff` form; `logsum` and
`logdiff` in base R; normalising to $\text{PP0}\dots\text{PP4}$; building `coloc_abf(...)`
from scratch; a live in-browser self-check against the frozen `coloc` reference numbers.
**Time:** ~40 min lesson + ~30 min practice

### 4. Capstone: reading coloc.abf (`modules/04-capstone-reading-coloc-abf/`)

**Why you need this:** the goal made into an exercise — decode the paper's equations and
`coloc::coloc.abf` line by line, then assemble and validate the whole method on both a
shared-variant and a distinct-variant region.
**You'll learn:** how to read the paper's $H_0$–$H_4$ formulas and the `coloc.abf`
interface, backlinking each term to the module that built it; assembling the full
`coloc_abf()`; running it on a simulated eQTL + biomarker region for **both** a
shared-variant and a distinct-variant scenario, and interpreting PP4 vs PP3; the paper's
sample-size / power note; a live self-check against the frozen reference; the validation
tier (full, vs `coloc` 5.2.3).
**Time:** ~40 min lesson + ~35 min practice (cumulative)
