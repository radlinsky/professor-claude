# Resources: Ridge regularization

All links verified 2026-07-05.

- 📺 [StatQuest — Ridge vs Lasso Regression, Visualized!!!](https://www.youtube.com/watch?v=Xm2C_gTAl8c)
  (video) — animates the diamond-vs-circle picture: why lasso's $|\beta|$ constraint
  region has corners that produce exact zeros, while ridge's $\beta^2$ circle does not.
  Watch after the lasso section to see it geometrically.
- 📖 [ISLR §6.2 — Ridge Regression and the Lasso](https://hastie.su.domains/ISLR2/ISLRv2_corrected_June_2023.pdf)
  (book, PDF) — §6.2.1 covers the penalty + $\lambda$ dial and coefficient paths for
  ridge; §6.2.2 covers the lasso, soft-thresholding, the diamond-vs-circle geometry,
  and the ridge-vs-lasso comparison. The source for this module's full arc.
- 📖 [VMLS Ch. 15 — Multi-objective / regularized least squares](https://web.stanford.edu/~boyd/vmls/vmls.pdf)
  (book, PDF) — the "two goals traded off" framing (§15.1) and the key fact (§15.3) that
  $A^\top A + \lambda I$ is invertible for **any** $\lambda > 0$, which is ridge's second
  job (making a near-collinear fit computable).
