
# SwitchStep Variable Selection — Syllabus

**Goal:** given only each indicator's published one-at-a-time (marginal) coefficient and a
known correlation matrix among the indicators — never the raw data — reconstruct the joint
multiple regression, search predictor subsets by *switching* indicators in and out under
the joint likelihood, stop with BIC, keep it fast with rank-1 (Sherman–Morrison) updates,
and keep it stable with a ridge $\lambda$ on the correlation matrix.

**Source:** concept — the method described in the course-request brief
`docs/fable-switchstep-prompt.md` (a frequentist, likelihood-based variable-selection
procedure; quoted and decoded in the capstone), built up from ISLR ch. 3 & 6 and VMLS
ch. 12–15. Rebuilt from scratch in base R and validated against `lm()`/`solve()` oracles
via this repo's equivalence harness.

**Source license:** n/a — no external source code; the method is described in prose and
rebuilt from public-domain statistics (normal equations, BIC, Sherman–Morrison). See
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

## Before you start: courses this one builds on

This course reuses the anchors of courses you should have met already instead of
re-teaching them:

- [**Multiple Regression from Scratch**](../multiple-regression/syllabus.md) — the joint
  fit via the normal equations $X^\top X\hat\beta = X^\top y$, and *why joint ≠ marginal*
  under correlated predictors. SwitchStep reconstructs that joint fit from summary
  statistics and then searches over which predictors to keep. (Transitively, that course's
  own prerequisite, [Simple Linear Regression](../simple-linear-regression/syllabus.md).)

## Prerequisites from the foundations library

Take these first, in this order. Already done one (check its Status in
[foundations/README.md](../../foundations/README.md))? Skim its pronunciation
table as a refresher instead.

| Module | Why this course needs it |
|---|---|
| [reading-math-notation](../../foundations/reading-math-notation/lesson.qmd) | The standing first prerequisite — it decodes the accents, Greek letters, subscripts, and operators every other formula uses. New? take it fully; done before? skim its symbol table. |
| [model-selection-and-information-criteria](../../foundations/model-selection-and-information-criteria/lesson.qmd) | The switching search stops with **BIC**; you need why RSS can't choose model size and how the $2^p$ search and greedy stepwise work (Module 2). |
| [sherman-morrison-rank-one-updates](../../foundations/sherman-morrison-rank-one-updates/lesson.qmd) | Every add/remove/swap re-inverts the correlation matrix; the rank-1 / bordering update avoids that (Module 3). |
| [ridge-regularization](../../foundations/ridge-regularization/lesson.qmd) | Near-collinear indicators make the correlation matrix hard to invert; a ridge $\lambda$ on its diagonal fixes it (Module 4). |
| [hypothesis-tests-p-values-and-confidence-intervals](../../foundations/hypothesis-tests-p-values-and-confidence-intervals/lesson.qmd) | Module 2 contrasts BIC with a p-value threshold and explains why a *post-selection* p-value isn't honest — you need to know what a p-value claims first. |

(You'll also lean on Course-A anchors — standardization and the correlation matrix, and the
log-likelihood behind BIC — linked inline where they come up.)

## Course modules

### 1. The joint fit from summaries (`modules/01-joint-fit-from-summaries/`)

**Why you need this:** the meta-analysis superpower — with only marginal coefficients and a
correlation matrix, you can rebuild the *entire* joint regression, its $R^2$, and its BIC,
never touching the raw rows.
**You'll learn:** the standardized-world identity $\hat\beta_{\text{joint}} = R^{-1}b$, the
residual variance $1 - b^\top R^{-1} b$, and how to get the log-likelihood and BIC from
summaries alone — verified against a full-data `lm()`.
**Time:** ~40 min lesson + ~30 min practice

### 2. The switching search (`modules/02-the-switching-search/`)

**Why you need this:** greedy forward stepwise can get stuck; adding a *swap* move lets the
search escape early mistakes and land on the BIC-best subset.
**You'll learn:** scoring subsets by the summary-stat BIC, the add/remove/**swap** move,
stopping when no move improves BIC, why a selection p-value isn't an honest p-value, and
validation against exhaustive best-subset BIC.
**Time:** ~40 min lesson + ~30 min practice

### 3. Rank-one speed-ups (`modules/03-rank-one-speedups/`)

**Why you need this:** re-inverting the correlation matrix on every move is the search's
bottleneck; the Sherman–Morrison/bordering family removes it.
**You'll learn:** the bordering update to grow $R_S^{-1}$ by one indicator, its twin to
shrink by one, swap = remove + add, agreement with a fresh `solve()` to machine precision,
and the $O(p^2)$-vs-$O(p^3)$ timing payoff.
**Time:** ~35 min lesson + ~25 min practice

### 4. Lambda for stability (`modules/04-lambda-stability/`)

**Why you need this:** at near-perfect collinearity the reconstruction explodes; a ridge
$\lambda$ on the correlation matrix keeps it sane.
**You'll learn:** why $R$ becomes near-singular at $\rho \to 1$, replacing $R$ with
$R + \lambda I$ (invertible for any $\lambda > 0$), how $\lambda$ trades stability for
shrinkage, and a sensitivity sweep showing selected sets stabilize.
**Time:** ~35 min lesson + ~25 min practice

### 5. Capstone — assembling SwitchStep (`modules/05-capstone-switchstep/`)

**Why you need this:** the proof you reached the goal — decode the method's own description
claim by claim and assemble the full procedure as a small base-R function suite.
**You'll learn:** nothing new — you *consolidate* by decoding the method spec, building
`switchstep(b, R, n, lambda)` end-to-end, and comparing its selected set and joint
coefficients against a full-data oracle on a simulated multi-study meta-analysis.
**Time:** ~40 min lesson + ~40 min practice
