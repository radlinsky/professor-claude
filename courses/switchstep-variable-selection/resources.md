# Resources: SwitchStep Variable Selection

External readings and videos per module. All links verified 2026-07-05. The method itself —
a frequentist, likelihood-based variable-selection procedure — is specified for this course
and decoded claim by claim in the capstone. The two free textbooks it builds on:

- 📖 [*An Introduction to Statistical Learning*, 2nd ed. (ISLR)](https://www.statlearning.com/)
  (James, Witten, Hastie, Tibshirani) — free PDF: [ISLRv2_corrected_June_2023.pdf](https://hastie.su.domains/ISLR2/ISLRv2_corrected_June_2023.pdf).
  Ch. 3 (marginal vs joint), Ch. 6 (subset selection, stepwise, Cp/AIC/BIC, ridge & lasso).
- 📖 [*Introduction to Applied Linear Algebra* (VMLS)](https://web.stanford.edu/~boyd/vmls/)
  (Boyd & Vandenberghe) — free PDF: [vmls.pdf](https://web.stanford.edu/~boyd/vmls/vmls.pdf).
  Ch. 11 (inverses), Ch. 12–13 (least squares), Ch. 15 (regularized least squares).

## Module 01 — The joint fit from summaries

- 📖 [ISLR §3.2 — Multiple Linear Regression](https://hastie.su.domains/ISLR2/ISLRv2_corrected_June_2023.pdf)
  (book, PDF) — the joint fit and the marginal-vs-joint contrast that $\hat\beta = R^{-1}b$
  converts between; the standardized normal equations underlie the reconstruction.
- 📖 [VMLS §12.1–12.2 — Least squares & the normal equations](https://web.stanford.edu/~boyd/vmls/vmls.pdf)
  (book, PDF) — the normal equations $A^\top A\hat x = A^\top b$ that become $R\hat\beta = b$
  once columns are standardized (so $A^\top A/n = R$).

## Module 02 — The switching search

- 📖 [ISLR §6.1 — Subset Selection](https://hastie.su.domains/ISLR2/ISLRv2_corrected_June_2023.pdf)
  (book, PDF) — best-subset vs forward/backward stepwise (§6.1.2, incl. the "hybrid approaches"
  that add *and* remove — the switching idea) and BIC as the selection criterion (§6.1.3).

## Module 03 — Rank-one speed-ups

- 📖 [Wikipedia — Sherman–Morrison formula](https://en.wikipedia.org/wiki/Sherman%E2%80%93Morrison_formula)
  (article) — the rank-1 inverse-update identity the bordering move specializes; states the
  formula and the singular-when-denominator-zero condition (our Schur complement $s$).
- 📖 [The Matrix Cookbook (Petersen & Pedersen), §3.2](https://www.math.uwaterloo.ca/~hwolkowi/matrixcookbook.pdf)
  (PDF) — Sherman–Morrison and the Woodbury / block-inverse (bordering) family in one place.

## Module 04 — Lambda for stability

- 📺 [StatQuest — Ridge vs Lasso Regression, Visualized!!!](https://www.youtube.com/watch?v=Xm2C_gTAl8c)
  (video) — the shrinkage picture: how a penalty pulls coefficients toward zero (ridge) and how
  lasso differs; the intuition behind adding $\lambda$ to stabilize.
- 📖 [VMLS §15.3 — Regularized least squares](https://web.stanford.edu/~boyd/vmls/vmls.pdf)
  (book, PDF) — the key fact that $A^\top A + \lambda I$ (here $R + \lambda I$) is invertible for
  any $\lambda > 0$, exactly why the ridge diagonal-loading rescues a near-collinear $R$.

## Module 05 — Capstone: assembling SwitchStep

No new concepts — the best resource is your own R console. Re-run `switchstep()` on your own
simulated correlated panels, vary $\lambda$ and the study seeds, and compare to `lm()`-based
best-subset on the pooled data. For the textbook framing of the whole subset-selection +
regularization arc, re-read [ISLR Chapter 6](https://hastie.su.domains/ISLR2/ISLRv2_corrected_June_2023.pdf).
