# Gradient Descent, from Scratch — Syllabus

**Goal:** Rebuild gradient descent from scratch in base R — measure a slope, roll
downhill, generalize to a gradient over several knobs — use it to fit a line to data,
and then read the documentation and output of a *real* optimizer (`optim()`,
`scipy.optimize.minimize`) explaining every field, having verified your from-scratch
version matches it.

**Source:** Concept course built with the **port-library** skill: the method is ported
from `scipy.optimize.minimize` (L-BFGS-B) and R's `optim()`, and the from-scratch
rebuild is validated against `scipy` at the **full** tier (see the equivalence fixture
`equivalence/fixtures/gradient-descent-full-scipy.json`).

**Source license:** scipy BSD-3-Clause (permissive) — OK; gradient descent itself is a
public-domain method, and only scipy's numeric outputs are transcribed for validation.

## How to take this course

- **One module per sitting.** Lesson first, then its practice — don't split them.
- **Space it out.** Start the next sitting (ideally the next day) with the new lesson's
  Warm-up — it deliberately re-tests what you did last time. Don't binge the course in a
  day; the forgetting between sittings is what makes the warm-ups work.
- **The mastery rule:** move on only when every "What you can now do" bullet feels solid.
  Shaky bullet → redo that section or its practice problems first.
- **Missed the Module check?** Don't re-grind the same problems — you remember
  their *answers* by now, not the skill. Ask for a fresh round ("add problems to
  <module>"), work it, then retake the check in a later session. Passing after
  another gap is the evidence that counts.
- **Answers are hidden for a reason.** Commit to an answer (or a prediction) before you
  click — that's the part that makes it stick. And these lessons *run in your browser*:
  edit the live cells and re-run them; predicting then running is where the learning is.

## Prerequisites from the foundations library

Take these first, in this order. Already done one (check its Status in
[foundations/README.md](../../foundations/README.md))? Skim its pronunciation table as a
refresher instead.

| Module | Why this course needs it |
|---|---|
| [reading-math-notation](../../foundations/reading-math-notation/lesson.qmd) | The standing first prerequisite — it decodes the accents, Greek letters, subscripts, and operators every other formula uses. New? take it fully; done before? skim its symbol table. |
| [derivative-as-slope](../../foundations/derivative-as-slope/lesson.qmd) | Gradient descent's compass is the slope of a curve; this teaches how to *measure* one numerically — the tool every module here reuses. |
| [vectors-and-summation](../../foundations/vectors-and-summation/lesson.qmd) | With more than one knob, the slope becomes a *vector* of slopes (the gradient), and the loss is a *sum* over data points. |
| [partial-derivatives-and-the-gradient](../../foundations/partial-derivatives-and-the-gradient/lesson.qmd) | Module 2 applies the gradient to *walk* downhill; this foundation teaches what the gradient is and how to measure it numerically. |

## Course modules

### 1. Rolling downhill (`modules/01-rolling-downhill/`)

**Why you need this:** It's the whole algorithm in its simplest form — one input, one
curve — so the core move (step against the slope) is crystal clear before anything scales
up.
**You'll learn:** the gradient-descent update rule $x \leftarrow x - \alpha f'(x)$, why
it's a minus sign, and how the learning rate makes descent converge, crawl, or diverge.
**Time:** ~25 min lesson + ~20 min practice

### 2. The gradient (`modules/02-the-gradient/`)

**Why you need this:** Real problems tune several numbers at once; this makes the leap
from one knob to many with almost no change to the recipe.
**You'll learn:** the gradient as a vector of partial slopes (measured numerically), and
the vector update $\mathbf{v} \leftarrow \mathbf{v} - \alpha \nabla f(\mathbf{v})$.
**Time:** ~30 min lesson + ~25 min practice

### 3. Fitting a line by descent (`modules/03-fitting-a-line-by-descent/`)

**Why you need this:** It turns the machinery on real data and — the point of the whole
course — proves the from-scratch build matches a professional optimizer.
**You'll learn:** the mean-squared-error loss as a bowl over (intercept, slope), fitting a
line by descent, and validating it against `scipy`'s L-BFGS-B, R's `optim()`, and `lm()`.
**Time:** ~30 min lesson + ~25 min practice

### 4. Capstone: decode a real optimizer (`modules/04-capstone-decode-the-optimizer/`)

**Why you need this:** It's the goal made into an exercise — read a real optimizer's call
and output cold, mapping every field to what you built.
**You'll learn:** how to decode `optim()` / `scipy.minimize` output field by field
(objective, parameters, gradient, iterations, convergence), and what methods like L-BFGS-B
add over plain descent. No new concepts — a cumulative review.
**Time:** ~25 min lesson + ~30 min practice
