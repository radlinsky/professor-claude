# Resources: Choosing a model with information criteria

All links verified 2026-07-05.

- 📖 [ISLR §6.1 — Subset Selection](https://hastie.su.domains/ISLR2/ISLRv2_corrected_June_2023.pdf)
  (book, PDF) — best-subset selection and the $2^p$ explosion (6.1.1), forward/backward
  stepwise and the documented case where forward stepwise misses the best subset (6.1.2,
  Table 6.1), and choosing among models with $C_p$, AIC, BIC, and adjusted $R^2$ (6.1.3,
  including why BIC's $\log n$ penalty picks smaller models). This module's source chapter.
- 📖 [statlearning.com — course site, slides & labs](https://www.statlearning.com/)
  (site) — the free ISLR home: chapter-6 slides and the R lab for subset selection, if you
  want to run best-subset/stepwise on the book's own datasets after this module.
- 📺 [StatQuest — Ridge vs Lasso Regression, Visualized!!!](https://www.youtube.com/watch?v=Xm2C_gTAl8c)
  (video) — not selection per se, but the clearest picture of *why penalizing complexity*
  changes which model you keep; a good bridge from "penalize fit" here to the ridge module
  next.
