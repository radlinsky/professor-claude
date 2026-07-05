# Resources: Multiple Regression from Scratch

External readings, videos, and interactives per module. All links verified 2026-07-05.
(Each foundation module has its own `resources.md` next to its lesson.)

The two free textbooks this course is built from are worth bookmarking whole:

- 📖 [*An Introduction to Statistical Learning*, 2nd ed.](https://www.statlearning.com/)
  (James, Witten, Hastie, Tibshirani) — free PDF:
  [ISLRv2_corrected_June_2023.pdf](https://hastie.su.domains/ISLR2/ISLRv2_corrected_June_2023.pdf).
  Chapter 3 is multiple regression; §6.1–6.2 preview the next course.
- 📖 [*Introduction to Applied Linear Algebra* (VMLS)](https://web.stanford.edu/~boyd/vmls/)
  (Boyd & Vandenberghe) — free PDF:
  [vmls.pdf](https://web.stanford.edu/~boyd/vmls/vmls.pdf). Chapters 12–13 are least
  squares and data fitting.

## Module 01 — Many knobs, one model

- 📺 [StatQuest: Multiple Regression, Clearly Explained!!!](https://www.youtube.com/watch?v=EkAQAi3a4js)
  (video) — the exact content of this module, animated: how the single-predictor idea
  extends to many predictors, each with its own coefficient. Watch right after the toy
  example.
- 📖 [ISLR §3.1–3.2](https://hastie.su.domains/ISLR2/ISLRv2_corrected_June_2023.pdf)
  (book, PDF) — "Multiple Linear Regression": the model equation and how to interpret a
  coefficient as an effect with the *others held fixed*. Our running example mirrors its
  `Advertising` story.
- 🎮 [Seeing Theory: Regression Analysis](https://seeing-theory.brown.edu/regression-analysis/index.html)
  (interactive) — drag data points and watch the least-squares fit and residuals react;
  the fastest way to *feel* what a fitted model is doing (single-predictor, but the
  intuition carries).

## Module 02 — Least squares and the normal equations

- 📖 [VMLS Ch. 12, "Least squares"](https://web.stanford.edu/~boyd/vmls/vmls.pdf)
  (book, PDF) — §12.1–12.2 set up the least-squares problem and derive the normal
  equations $A^\top A\,\hat{x} = A^\top b$ — exactly this module's
  $X^\top X\,\hat\beta = X^\top y$, in the same notation you'll meet in papers.
- 📖 [ISLR §3.2](https://hastie.su.domains/ISLR2/ISLRv2_corrected_June_2023.pdf)
  (book, PDF) — the estimation view: how the coefficients are chosen to minimize the
  residual sum of squares, and what the fitted values represent.
- 📺 [StatQuest: Multiple Regression, Clearly Explained!!!](https://www.youtube.com/watch?v=EkAQAi3a4js)
  (video) — re-watch the fitting portion after the derivation to see the machinery you
  built by hand used fluently.

## Module 03 — Marginal vs joint

- 📖 [ISLR §3.3.3, "Potential Problems" → collinearity](https://hastie.su.domains/ISLR2/ISLRv2_corrected_June_2023.pdf)
  (book, PDF) — the textbook treatment of collinearity, the variance inflation factor,
  and why correlated predictors make individual coefficients unreliable. The `Credit`
  data's `limit`/`rating` pair is the twin story on real data.
- 📖 [ISLR §3.2.2, "Some Important Questions"](https://hastie.su.domains/ISLR2/ISLRv2_corrected_June_2023.pdf)
  (book, PDF) — includes the classic marginal-vs-joint reversal (the "shark attacks vs
  ice-cream sales" aside): a predictor significant on its own losing meaning in the
  joint fit.
- 🎮 [Seeing Theory: Correlation](https://seeing-theory.brown.edu/regression-analysis/index.html)
  (interactive) — the "Correlation" panel lets you feel how strongly two variables move
  together; that correlation between *predictors* is the engine of this module.

## Module 04 — Capstone: reading a multiple regression

No new concepts, so the best resource is your own R console. Fit and decode
`summary(lm(...))` on built-in data the way the lesson decodes the indicator panel:

- `lm(mpg ~ wt + hp + disp, data = mtcars)` — several correlated predictors; compute
  their VIFs and watch coefficients get uncertain.
- `lm(Fertility ~ ., data = swiss)` — a full multi-predictor summary to read end to end.

For the textbook framing of the whole-model F-test vs individual coefficients, re-read
[ISLR §3.2.2](https://hastie.su.domains/ISLR2/ISLRv2_corrected_June_2023.pdf).
