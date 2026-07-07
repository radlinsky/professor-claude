# Resources: Ridge regularization

All links verified 2026-07-05.

- 📺 [StatQuest — Ridge vs Lasso Regression, Visualized!!!](https://www.youtube.com/watch?v=Xm2C_gTAl8c)
  (video) — animates the exact point of this module's second trap: ridge shrinks
  coefficients toward zero but lasso can drive them *to* zero. Watch after the "ridge vs
  lasso" trap to see it geometrically.
- 📖 [ISLR §6.2.1 — Ridge Regression](https://hastie.su.domains/ISLR2/ISLRv2_corrected_June_2023.pdf)
  (book, PDF) — the penalty + $\lambda$ dial, the coefficient-path-vs-$\lambda$ figure, and
  the warning (eq. 6.6) that ridge needs standardized predictors — exactly this module's
  arc, with the book's `Credit`-data path plot.
- 📖 [VMLS Ch. 15 — Multi-objective / regularized least squares](https://web.stanford.edu/~boyd/vmls/vmls.pdf)
  (book, PDF) — the "two goals traded off" framing (§15.1) and the key fact (§15.3) that
  $A^\top A + \lambda I$ is invertible for **any** $\lambda > 0$, which is ridge's second
  job (making a near-collinear fit computable).
