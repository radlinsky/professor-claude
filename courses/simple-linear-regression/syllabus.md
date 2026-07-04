
# Simple Linear Regression from Scratch — Syllabus

**Goal:** read `summary(lm(y ~ x))` output and the regression tables in academic
papers, and explain every symbol in the least-squares formulas
$\hat{\beta}_1 = s_{xy}/s_x^2$ and $\hat{\beta}_0 = \bar{y} - \hat{\beta}_1\bar{x}$ —
including where they come from.

**Source:** demo course (no paper) — the reference example for this repo.

**Source license:** n/a — no external source (self-authored demo course).

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

## Prerequisites from the foundations library

Take these first, in this order. Already done one (check its Status in
[foundations/README.md](../../foundations/README.md))? Skim its pronunciation
table as a refresher instead.

| Module | Why this course needs it |
|---|---|
| [reading-math-notation](../../foundations/reading-math-notation/lesson.qmd) | The standing first prerequisite — it decodes the accents, Greek letters, subscripts, and operators every other formula uses. New? take it fully; done before? skim its symbol table. |
| [vectors-and-summation](../../foundations/vectors-and-summation/lesson.qmd) | Every regression formula is written with $x_i$, $n$, and Σ; the derivation in Module 2 leans on sum-Rules 1–3. |
| [mean-variance-covariance](../../foundations/mean-variance-covariance/lesson.qmd) | The slope estimate IS covariance ÷ variance; deviations-from-the-mean do all the work. |

## Course modules

### 1. Lines and the least-squares idea (`modules/01-least-squares-idea/`)

**Why you need this:** before any formula, you need the *decision rule* — what makes
one line through a point cloud "better" than another. Everything else is solving
that.
**You'll learn:** intercept & slope notation ($\beta_0$, $\beta_1$), predictions
($\hat{y}_i$), residuals ($e_i$), sum of squared errors (SSE), argmin.
**Time:** ~30 min lesson + ~25 min practice

### 2. Deriving the OLS formulas (`modules/02-deriving-the-ols-formulas/`)

**Why you need this:** this is where the famous formulas come from — and the
derivation is a guided tour of the exact algebra/calculus tricks papers use
everywhere ("expand the square", "take the derivative, set it to zero").
**You'll learn:** the tricks themselves, partial derivatives (gently), the full
derivation of $\hat{\beta}_0$ and $\hat{\beta}_1$, and a numeric check against `lm()`.
**Time:** ~45 min lesson + ~30 min practice

### 3. Reading `lm()` output and papers (`modules/03-reading-lm-output-and-papers/`)

**Why you need this:** the payoff — decode every number `summary(lm())` prints, then
map it onto how the same model appears in an academic paper (the model equation with
$\varepsilon_i$, the coefficient table with standard errors and stars, $R^2$).
**You'll learn:** the model equation $y_i = \beta_0 + \beta_1 x_i + \varepsilon_i$,
standard errors, t values, p-values, $R^2$, residual standard error, paper-table
conventions.
**Time:** ~40 min lesson + ~25 min practice

### 4. Capstone — reading a real regression (`modules/04-capstone-reading-a-real-regression/`)

**Why you need this:** the proof you reached the goal — no new concepts, just every
tool at once, aimed at a real `summary(lm())` (R's `cars` data) and its journal-table
twin, decoded number by number, each traced back to the module that taught it.
**You'll learn:** nothing new — you *consolidate* by decoding a real regression
end-to-end and doing a cumulative, mixed problem set spanning all three modules.
**Time:** ~30 min lesson + ~30 min practice
