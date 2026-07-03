# Resources: Gradient Descent, from Scratch

Verified external explanations, one section per module. All links checked this build;
watch/read alongside the lesson if a second voice helps.

## 1. Rolling downhill

- **[StatQuest — Gradient Descent, Step-by-Step](https://www.youtube.com/watch?v=sDv4f4s2SB8)**
  (video, ~24 min, Josh Starmer). Walks the descent loop with concrete numbers and a
  running plot — the same "measure the slope, step downhill, repeat" you build here, at a
  gentle pace. Ideal reinforcement for a learner who likes seeing every step.
- **[3Blue1Brown — Gradient descent, how neural networks learn](https://www.youtube.com/watch?v=IHZwWFHWa-w)**
  (video, ~21 min). The ball-in-a-valley picture, animated, and why you step against the
  slope. Watch the first ~8 minutes for the pure gradient-descent intuition (the rest
  applies it to neural nets, a preview of where this goes).

## 2. The gradient

- **[3Blue1Brown — Gradient descent, how neural networks learn](https://www.youtube.com/watch?v=IHZwWFHWa-w)**
  (video, ~21 min). Shows the gradient as the multi-direction slope you step against when
  there's more than one knob — exactly this module's leap from one input to many.
- **[StatQuest — Gradient Descent, Step-by-Step](https://www.youtube.com/watch?v=sDv4f4s2SB8)**
  (video, ~24 min). Its later part optimizes *two* parameters at once (intercept and
  slope), which is precisely the two-knob gradient this module introduces — a concrete
  companion before Module 3 uses it on real data.

## 3. Fitting a line by descent

- **[StatQuest — Linear Regression, Clearly Explained](https://www.youtube.com/watch?v=7ArmBVF2dCs)**
  (video, ~27 min). What "fitting a line by least squares" means and why we minimize
  squared error — the loss this module rolls down. Complements the lesson's error-bowl
  picture (and connects to the simple-linear-regression course).
- **[StatQuest — Gradient Descent, Step-by-Step](https://www.youtube.com/watch?v=sDv4f4s2SB8)**
  (video, ~24 min). Fits a line to data by gradient descent end to end — the same task as
  this module, useful for seeing the loop applied to real numbers a second time.

## 4. Capstone: decode a real optimizer

- **[R — `optim()` documentation ("General-purpose Optimization")](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/optim.html)**
  (reference). The official help for the optimizer we decode: the `method` choices (BFGS,
  L-BFGS-B, …) and the returned `par`, `value`, `counts`, `convergence`. Read it *after*
  the capstone — you'll find you can now parse every field.
- **[SciPy — `scipy.optimize.minimize` documentation](https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.minimize.html)**
  (reference). The Python reference this course validated against: `method="L-BFGS-B"`,
  and the `OptimizeResult` fields (`x`, `fun`, `jac`, `success`). The real-world artifact
  the capstone teaches you to read.
