# Logistic Regression from Scratch — Syllabus

**Goal:** read and run a logistic regression the way a paper's methods section states
it — decode `summary(glm(y ~ x, family = binomial))` field by field, interpret a
coefficient as a change in log-odds *and* as an odds ratio ($e^{\hat{\beta}_1}$), and
explain how the sigmoid, the logit link $\log\!\big(\tfrac{p}{1-p}\big) = \beta_0 +
\beta_1 x$, and the log-likelihood fit together and are found by gradient ascent.

**Source:** concept course (no paper) — built from
`source-materials/logistic-regression/COURSE-REQUEST.md`.

**Source license:** n/a — no external source.

## How to take this course

- **One module per sitting.** Lesson first, then its practice — don't split them.
- **Space it out.** Start the next sitting (ideally the next day) with the new
  lesson's Warm-up — it deliberately re-tests what you did last time. Don't binge
  the course in a day; the forgetting between sittings is what makes the warm-ups
  work.
- **The mastery rule:** move on only when every "What you can now do" bullet feels
  solid. Shaky bullet → redo that section or its practice problems first.
- **Answers are hidden for a reason.** Commit to an answer (or a prediction) before
  you click — that's the part that makes it stick. And these lessons *run in your
  browser*: edit the live cells and re-run them; predicting then running is where
  the learning is.

## Before you start: two courses this one builds on

This course stands on the shoulders of two you should have met already. It **reuses**
their anchors instead of re-teaching them:

- [**Simple Linear Regression**](../simple-linear-regression/syllabus.md) — fitting a
  straight line $\beta_0 + \beta_1 x$ and reading model output. Logistic regression is
  what you do when the thing you're predicting is a yes/no, not a number.
- [**Gradient Descent, from Scratch**](../gradient-descent/syllabus.md) — the
  cost-surface-with-knobs picture and "step downhill by the slope." Logistic
  regression is fit by stepping *uphill* on a different surface (the log-likelihood).

## Prerequisites from the foundations library

Take these first, in this order. Already done one (check its Status in
[foundations/README.md](../../foundations/README.md))? Skim its pronunciation
table as a refresher instead.

| Module | Why this course needs it |
|---|---|
| [reading-math-notation](../../foundations/reading-math-notation/lesson.qmd) | The standing first prerequisite — it decodes the accents, Greek letters, subscripts, and operators every other formula uses. New? take it fully; done before? skim its symbol table. |
| [exponentials-and-logs](../../foundations/exponentials-and-logs/lesson.qmd) | The sigmoid is built from $e^{-z}$; log-odds and the log-likelihood are built from the natural log. You need $e^x$, $\log$, and the log rules fluently. |
| [probability-and-odds](../../foundations/probability-and-odds/lesson.qmd) | Logistic regression predicts a *probability*, and the quantity it models linearly is the *log-odds*. This teaches probability, odds, and the odds↔probability conversion. |
| [vectors-and-summation](../../foundations/vectors-and-summation/lesson.qmd) | The log-likelihood is a $\Sigma$ over every data point; you'll read $x_i$, $y_i$, $n$ throughout. |
| [derivative-as-slope](../../foundations/derivative-as-slope/lesson.qmd) | Fitting is gradient ascent — the "slope of the log-likelihood surface" is the compass. This teaches how to measure a slope numerically. |
| [likelihood-and-log-likelihood](../../foundations/likelihood-and-log-likelihood/lesson.qmd) | Module 3 builds the Bernoulli likelihood and maximizes its log. You need the general idea of likelihood-as-product and why we take the log first. |

## Course modules

### 1. From a line to a probability (`modules/01-from-line-to-probability/`)

**Why you need this:** a straight-line predictor can spit out $-4$ or $1.7$ — nonsense
as a probability. The **sigmoid** function is the bend that squashes any number into a
clean 0-to-1 probability, and it's the heart of the whole method.
**You'll learn:** the linear predictor $\eta = \beta_0 + \beta_1 x$ (why it overflows
the [0,1] box), the logistic/sigmoid function $\sigma(z) = 1/(1+e^{-z})$, and the S-shaped
curve it draws.
**Time:** ~30 min lesson + ~25 min practice

### 2. Odds, log-odds, and the logit link (`modules/02-odds-log-odds-and-the-logit/`)

**Why you need this:** logistic regression doesn't model the probability with a line —
it models the **log-odds** with a line. This module explains that choice and, as the
payoff, teaches you to read a coefficient two ways: as a change in log-odds and as an
**odds ratio**.
**You'll learn:** odds and the logit (log-odds), the link equation
$\log\!\big(\tfrac{p}{1-p}\big) = \beta_0 + \beta_1 x$ (the exact inverse of the sigmoid),
and interpreting $\hat{\beta}_1$ and $e^{\hat{\beta}_1}$.
**Time:** ~35 min lesson + ~30 min practice

### 3. Likelihood and fitting by gradient ascent (`modules/03-likelihood-and-gradient-ascent/`)

**Why you need this:** there's no tidy formula for the coefficients like there was for
least squares. Instead we ask "which $\beta$'s make the observed 0/1 data most
probable?" — the **likelihood** — and climb to the top of it.
**You'll learn:** the Bernoulli likelihood $\prod p_i^{y_i}(1-p_i)^{1-y_i}$, why we
maximize the *log*-likelihood, and fitting by gradient **ascent** (reusing the
gradient-descent course, with the sign flipped to go uphill).
**Time:** ~40 min lesson + ~30 min practice

### 4. Capstone — reading a real logistic regression (`modules/04-capstone-reading-a-real-logistic-regression/`)

**Why you need this:** the proof you reached the goal — no new concepts, just every
tool at once, aimed at a real `summary(glm(..., family = binomial))` and its
journal-table twin, decoded number by number, each traced back to the module that
taught it.
**You'll learn:** nothing new — you *consolidate* by decoding a real logistic
regression end-to-end (coefficients, std. errors, z values, p-values, deviance,
predicted probabilities, odds ratios) and doing a cumulative, mixed problem set
spanning all three modules.
**Time:** ~30 min lesson + ~30 min practice
