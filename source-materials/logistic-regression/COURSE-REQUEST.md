# Course request: logistic-regression

> **How to use this file:** in this repo, tell Claude —
> *"Create a course from `source-materials/logistic-regression/COURSE-REQUEST.md`"* —
> and let the `create-course` skill (or the `course-creator` agent for a one-shot build)
> run its phases against everything below. This file is also the worked **example** of the
> COURSE-REQUEST format for this repo: copy its shape for your own requests.

## Goal

Teach logistic regression from the ground up — how a straight-line predictor is bent into a
probability, why we model the *log-odds* as linear, and how the fit is found by maximizing a
likelihood (gradient ascent). Work UP from what the learner already met in the
`simple-linear-regression` and `gradient-descent` courses to the real thing: reading and
running a logistic regression the way a paper's methods section states it.

Suggested slug: `logistic-regression`.

## Learner notes beyond the standard profile

- Assume the learner has worked through this repo's `simple-linear-regression` and
  `gradient-descent` courses — reuse those anchors (fitting a line; the cost-surface-with-knobs
  picture; taking a step downhill) instead of re-teaching them.
- The blockers to dissolve are the notation-heavy pieces: the sigmoid/logistic function, "odds"
  and "log-odds", and the likelihood / log-likelihood. Give each a spoken name and a small
  numeric example before any formula.

## Target concepts (the "real things" the course works up to)

1. **From line to probability** — why a linear predictor can fall outside 0–1, and how the
   logistic (sigmoid) function squashes any number into a probability.
2. **Odds and log-odds (the logit)** — odds as a ratio; the log-odds as the quantity logistic
   regression models linearly; reading a coefficient as "change in log-odds per unit of x".
3. **Likelihood and log-likelihood** — what "the parameters that make the observed 0/1 data
   most probable" means, and why we maximize the *log*-likelihood.
4. **Fitting by gradient ascent** — reuse the gradient-descent course: the log-likelihood is the
   surface, its gradient points uphill, iterate to the top. (No closed form, unlike OLS.)
5. **Reading and running it** — interpret coefficients as odds ratios; run
   `glm(..., family = binomial)` in R and map every piece of the output back to the concepts above.

## Constraints

- R/Quarto lessons per house style; interactive `{webr}` cells where the learner tweaks or solves.
- Reuse `foundations/` where a building block already exists (summation, derivative-as-slope);
  add a foundation module only for a genuinely generic new block (e.g. exponentials & logs, or
  probability-and-odds) per the genericity rule — don't fold a reusable prerequisite into the course.
- Keep the shape close to the existing two courses (~4 modules, capstone last).
- No external paper or library to rebuild — this is a concept course, so the source-license
  verdict is `n/a — no external source`.
