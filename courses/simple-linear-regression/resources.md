# Resources: Simple Linear Regression from Scratch

External videos and interactives per module. All links verified 2026-07-02.
(Each foundation module has its own `resources.md` next to its lesson.)

## Module 01 — Lines and the least-squares idea

- 📺 [StatQuest: The Main Ideas of Fitting a Line to Data (Least Squares)](https://youtu.be/PaFPbb66DxQ)
  (video) — the exact content of this module, animated: candidate lines, squared
  residuals, and "the best line minimizes the sum of squares". Watch right after
  the lesson's toy example.
- 🎮 [Seeing Theory: Regression Analysis](https://seeing-theory.brown.edu/regression-analysis/index.html)
  (interactive) — drag data points and watch the fitted line and residuals react in
  real time; the fastest way to *feel* what least squares is doing.

## Module 02 — Deriving the OLS formulas

- 📺 [3Blue1Brown: The Essence of Calculus, ch. 1](https://www.3blue1brown.com/lessons/essence-of-calculus)
  (video + article) — rebuilds "what a derivative even is" visually. Ideal if the
  AP-Calc memories feel too thin before the derivation.
- 📺 [3Blue1Brown: The paradox of the derivative](https://www.3blue1brown.com/lessons/derivatives)
  (video + article, ch. 2) — the slope-at-a-point idea this module's
  "derivative = slope, zero at the bottom" argument rests on.
- 📺 [StatQuest: Linear Regression, Clearly Explained!!!](https://youtu.be/7ArmBVF2dCs)
  (video) — a full pass over least squares fitting; watch after the derivation to
  see the formulas you built used fluently.

## Module 03 — Reading lm() output and papers

- 📺 [StatQuest: The standard error, Clearly Explained!!!](https://youtu.be/XNgt7F6FqDU)
  (video) — the "estimates bounce from sample to sample" idea (our three-seasons
  game) done with animations.
- 📺 [StatQuest: p-values: What they are and how to interpret them](https://youtu.be/vemZtEM63GY)
  (video) — plain-English p-values, careful about what they do NOT mean.
- 📺 [StatQuest: R-squared, Clearly Explained!!!](https://youtu.be/2AQKmw14mHM)
  (video) — R² as "how much better than the flat line at the mean", which is
  literally this module's formula.
- 📺 [StatQuest: Linear Regression in R, Step-by-Step](https://youtu.be/u1cc1r_Y7M0)
  (video) — walks `lm()` and `summary()` in R end-to-end; a nice recap of the whole
  course in your native language.

## Module 04 — Capstone: reading a real regression

No new concepts, so no new videos — the best resource is your own R console. Run
`summary(lm(...))` on built-in datasets and decode every printed number the way the
lesson decodes `cars`:

- `lm(dist ~ speed, data = cars)` — the lesson's own fit; re-derive each cell.
- `lm(weight ~ height, data = women)` — a near-perfect fit ($R^2 \approx 0.99$).
- `lm(mpg ~ wt, data = mtcars)` — the fit from Modules 2–3, now read end-to-end.

For anything that stays fuzzy, the StatQuest R walkthrough under Module 03 is the
best single recap.
