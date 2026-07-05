
# Multiple Regression from Scratch — Syllabus

**Goal:** read and rebuild a multiple linear regression — fit it three ways (`lm()`,
the normal equations $X^\top X\,\hat\beta = X^\top y$, and by hand on a two-predictor
case) — and explain precisely *why* a predictor that looks important on its own can
shrink to nothing, or even flip sign, once its correlated neighbours join the model.

**Source:** concept — a port of base R's own least-squares fitter, `stats::lm` /
`lm.fit` (via the `port-library` skill). The running example is a simulated
economic-indicator panel (predict next quarter's GDP growth from twelve indicators).

**Source license:** GPL-2 | GPL-3 (base R `stats::lm`) — flagged (copyleft), confirmed by human 2026-07-05; the method itself (the normal equations) is public-domain mathematics, rebuilt from scratch in base R, no GPL source code copied. See `.claude/course-authoring/source-licensing.md`.

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

## Before you start: course this one builds on

This course reuses the anchors of a course you should have met already instead of
re-teaching them:

- [**Simple Linear Regression from Scratch**](../simple-linear-regression/syllabus.md)
  — one predictor, one slope, fit by least squares ($\hat\beta_1 = s_{xy}/s_x^2$).
  This course keeps the least-squares idea but hands it *many* predictors at once,
  where the single-predictor formula no longer works and correlated predictors start
  interfering with each other.

## Prerequisites from the foundations library

Take these first, in this order. Already done one (check its Status in
[foundations/README.md](../../foundations/README.md))? Skim its pronunciation
table as a refresher instead.

| Module | Why this course needs it |
|---|---|
| [reading-math-notation](../../foundations/reading-math-notation/lesson.qmd) | The standing first prerequisite — it decodes the accents, Greek letters, subscripts, and operators every other formula uses. New? take it fully; done before? skim its symbol table. |
| [matrices-and-linear-transforms](../../foundations/matrices-and-linear-transforms/lesson.qmd) | Module 2 forms $X^\top X$, calls `solve()`, and asks when a matrix *can't* be inverted — the transpose and the inverse are the tools. (Take before linear-combinations, which builds on it.) |
| [linear-combinations-and-data-matrices](../../foundations/linear-combinations-and-data-matrices/lesson.qmd) | A fit is a *linear combination* of predictor columns; the predictors stack into a data matrix $X$. Both are the vocabulary of Module 1. |
| [variance-structure-and-standardization](../../foundations/variance-structure-and-standardization/lesson.qmd) | Correlated predictors — "two knobs wired to one wheel" — are the whole story of Module 3; this module is where correlation between predictors gets its picture. |
| [partial-derivatives-and-the-gradient](../../foundations/partial-derivatives-and-the-gradient/lesson.qmd) | Module 2 sets every partial slope of the error to zero at once — the multi-knob version of "take the derivative, set it to zero". |

## Course modules

### 1. Many knobs, one model (`modules/01-many-knobs-one-model/`)

**Why you need this:** before any formula, you need the picture — one outcome, many
predictors, each with its own coefficient — and the one phrase that unlocks all of
multiple regression: *"holding the others fixed."*
**You'll learn:** the multiple-regression model $y = \beta_0 + \beta_1 x_1 + \dots +
\beta_p x_p$, reading a coefficient as "change per unit, others held fixed", fitted
values as a linear combination of predictor columns, and prediction with `lm(y ~ .)`.
**Time:** ~35 min lesson + ~25 min practice

### 2. Least squares and the normal equations (`modules/02-least-squares-and-the-normal-equations/`)

**Why you need this:** this is where the coefficients actually come from — the
one-predictor formula from the earlier course breaks with many predictors, and the
matrix version $X^\top X\,\hat\beta = X^\top y$ takes over. You'll rebuild `lm()`'s
answer in one line of base R.
**You'll learn:** the residual sum of squares over many knobs, why setting every
partial slope to zero gives the normal equations (derived in full for two
predictors), `solve(t(X) %*% X, t(X) %*% y)` matching `lm()` to machine precision,
and what breaks when two predictor columns are nearly identical.
**Time:** ~45 min lesson + ~30 min practice

### 3. Marginal vs joint: the vanishing coefficient (`modules/03-marginal-vs-joint/`)

**Why you need this:** the heart of the course. A predictor can be strongly related to
the outcome *one at a time* and yet contribute almost nothing *in the joint fit* — and
this is not a bug, it is what "holding the others fixed" costs when predictors travel
together.
**You'll learn:** one-at-a-time (marginal) regressions vs the joint fit, how a
correlated partner steals a coefficient (collapse and sign-flip), collinearity and why
it inflates uncertainty, a lightweight variance-inflation check, and a live control to
dial the correlation up and watch marginal and joint answers diverge.
**Time:** ~45 min lesson + ~30 min practice

### 4. Capstone — reading a multiple regression (`modules/04-capstone-reading-a-multiple-regression/`)

**Why you need this:** the proof you reached the goal — no new concepts, just every
tool at once, aimed at a full `summary(lm())` on a fresh indicator panel and the way
the same argument is framed in a statistics text, decoded line by line and traced back
to the module that taught each piece.
**You'll learn:** nothing new — you *consolidate* by decoding a real multiple-regression
summary end-to-end and doing a cumulative, mixed problem set spanning all three modules.
**Time:** ~35 min lesson + ~35 min practice
