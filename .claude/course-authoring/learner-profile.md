# Learner profile

The single source of truth about WHO you are teaching. Every authoring decision —
vocabulary, pacing, what to explain, what to skip — follows from this file.
(HOW to teach them — the golden order, notation rules, tone, retrieval/practice
design — is the separate contract in root `TEACHING.md`; this file describes only
the person.)

## Background

- **Programming:** strong, professional-level R. Comfortable with vectors, data
  frames, functions, plotting, packages, pipes. Never explain R syntax; instead,
  explain the MATH that a line of R computes.
- **Math education:** AP Calculus A/B (high school) and one college intro course in
  statistics and probability theory — taken many, many years ago. The concepts left
  an imprint but the mechanics are gone.
- **Self-described:** "not comfortable reading maths formulas", "hard time
  understanding the math/stats sections of academic papers", "my memory of all the
  algebra and calc tricks to solve problems is hazy".

## What the learner knows (the baseline — the floor you build from)

Rusty but recoverable with a short refresher; do not build modules below this line,
but DO give one-line reminders when you rely on it:

- Arithmetic, fractions, percentages, exponents, square roots.
- Basic algebra: solving a linear equation for x, plugging values into a formula.
- The *idea* of a derivative (slope/rate of change) and an integral (area under a
  curve) — conceptually, not mechanically.
- The *idea* of probability, independence, and an average.
- Reading a scatter plot, a histogram, a line chart.

## What the learner does NOT know (never assume any of these)

Each of these, if needed, is a prerequisite module or an explicitly taught step:

- **Linear algebra:** vectors as math objects, dot products, matrices, matrix
  multiplication, transposes, inverses. (They know R vectors — bridge from that.)
- **Notation fluency:** Σ and Π notation, subscripts/indices, hats (β̂), bars (x̄),
  |x|, ‖x‖, ∈, ∀, argmin/argmax, E[X], Var(X), P(A|B), ∝, ~, matrix notation like
  X'X or Xᵀ X.
- **Algebra/calc manipulation tricks:** expanding (a+b)², factoring, splitting and
  reindexing sums, log rules, the chain/product/quotient rules, "take the derivative,
  set it to zero, solve", completing the square.
- **Distribution theory:** density vs. probability, likelihoods, the normal
  distribution's role, degrees of freedom, sampling distributions.
- **Proof/paper conventions:** "it follows that", "WLOG", "iid", asymptotics, big-O,
  what a theorem/lemma is for.

## How to teach this person

Two facts about them drive the whole teaching contract: they read R fluently (use
it as the bridge to the math — "new notation = R function you already know"), and
a bare formula is a wall (so concrete numbers and intuition always come before
symbols). The full HOW — the golden order, notation and tone rules, retrieval and
practice design — is `TEACHING.md` at the repo root. Read it before writing
anything that teaches.

Voice: warm, encouraging, concrete. It's fine to be a little fun. It is never fine
to be vague.
