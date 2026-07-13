---
title: "James et al. (2021) — An Introduction to Statistical Learning"
---

<!-- Copy of .claude/course-authoring/kb-source-template.md. Rules:
     knowledge-base.md + citations.md + source-licensing.md.
     The record is created by the survey-source skill (license, big ideas,
     chapter map, relevance proposal, goal) and then driven by extract-knowledge:
     the chapter table IS the resume mechanism — update a row the moment its
     chapter (or, for long chapters, its page slice) is finished, before
     starting the next one. -->

**File:** source-papers/2021-james-introduction-statistical-learning.pdf *(PDF removed after extraction; to resume extraction re-download via <https://www.statlearning.com>)*
**Bib key:** james2021introductionstatisticallearning
**Source license:** © Springer, all rights reserved; free PDF officially distributed by the authors at statlearning.com — flagged, confirmed by human 2026-07-11
**Extraction goal:** Extract chapters 2, 4, 5, 6, 12, 13 — targeted to feed foundations on bias-variance/model validation, classification evaluation, kNN, resampling/bootstrap, model selection/regularization, PCA/clustering, and false discovery rate

## Bibliographic record

Full reference as it appears in `knowledge/references.bib`:

> James, G., Witten, D., Hastie, T., & Tibshirani, R. (2021). *An Introduction to Statistical Learning: with Applications in R* (2nd ed.). Springer. <https://www.statlearning.com>

Second edition, corrected printing June 21, 2023. Companion website with free PDF, datasets, slides, and video lectures: <https://www.statlearning.com>. More advanced companion: *The Elements of Statistical Learning* (Hastie, Tibshirani, Friedman).

## Big ideas (backward design)

What this source wants a reader to be able to DO after working through it: [@james2021introductionstatisticallearning]

- Diagnose whether a model is overfitting or underfitting by reasoning about the bias-variance trade-off and validating with held-out data or cross-validation
- Choose an appropriate supervised learning method (regression vs classification, linear vs flexible) for a given data problem and defend the choice
- Evaluate a classifier's performance using confusion matrices, sensitivity/specificity, ROC curves, and the Bayes error rate
- Select predictors and control model complexity using subset selection, ridge regression, the lasso, and information criteria
- Reduce dimensionality with PCA and discover groups with k-means and hierarchical clustering
- Control false discoveries when testing many hypotheses simultaneously (Bonferroni, Benjamini-Hochberg)

## Chapter coverage map & extraction state

| Chapter | Pages | Status | Concepts extracted | Confidence notes |
|---|---|---|---|---|
| 1 — Introduction | pp. 1–14 | skipped (out of scope for targeted extraction) | — | — |
| 2 — Statistical Learning | pp. 15–57 | done | bias-variance-trade-off (created), k-nearest-neighbors (created); glossary: Bayes classifier, Bayes decision boundary, Bayes error rate, degrees of freedom, irreducible error, mean squared error, overfitting, parametric methods, reducible error, supervised learning, test error, training error, unsupervised learning | pp. 42--57 are R lab (skipped -- no new conceptual content) |
| 3 — Linear Regression | pp. 59–127 | skipped (out of scope for targeted extraction) | — | — |
| 4 — Classification | pp. 129–195 | done | classification-evaluation (created); glossary: AUC, confusion matrix, confounding, generalized linear model, linear discriminant analysis, link function, logistic regression, naive Bayes classifier, positive predictive value, posterior probability (classification), prior probability (classification), quadratic discriminant analysis, ROC curve, sensitivity, specificity | pp. 171--195 are R lab + exercises (skipped -- no new conceptual content) |
| 5 — Resampling Methods | pp. 197–224 | done | resampling-bootstrap-and-permutation (created); glossary: bootstrap, cross-validation, $k$-fold cross-validation, leave-one-out cross-validation (LOOCV), model assessment, model selection, validation set approach | pp. 213--224 are R lab + exercises (skipped -- no new conceptual content) |
| 6 — Linear Model Selection and Regularization | pp. 225–287 | done | model-selection-and-information-criteria (created), ridge-regularization (created); glossary: adjusted $R^2$, AIC, backward stepwise selection, best subset selection, BIC, $C_p$ (Mallow's $C_p$), deviance, forward stepwise selection, lasso, one-standard-error rule, partial least squares (PLS), principal components regression (PCR), ridge regression, shrinkage penalty, soft-thresholding, sparse model, tuning parameter | pp. 266--287 are R lab + exercises (skipped -- no new conceptual content) |
| 7 — Moving Beyond Linearity | pp. 289–325 | skipped (out of scope for targeted extraction) | — | — |
| 8 — Tree-Based Methods | pp. 327–365 | skipped (out of scope for targeted extraction) | — | — |
| 9 — Support Vector Machines | pp. 367–401 | skipped (out of scope for targeted extraction) | — | — |
| 10 — Deep Learning | pp. 403–459 | skipped (out of scope for targeted extraction) | — | — |
| 11 — Survival Analysis and Censored Data | pp. 461–493 | skipped (out of scope for targeted extraction) | — | — |
| 12 — Unsupervised Learning | pp. 495–549 | done | principal-component-analysis (augmented), clustering-and-k-means (augmented); glossary: biplot, correlation-based distance, dendrogram, hierarchical clustering, linkage (clustering), loading vector (PCA), matrix completion, scree plot, within-cluster variation | pp. 530--549 are R lab + exercises (skipped -- no new conceptual content) |
| 13 — Multiple Testing | pp. 551–593 | done | false-discovery-rate (created); glossary: alternative hypothesis, Benjamini--Hochberg procedure, Bonferroni correction, false discovery proportion (FDP), family-wise error rate (FWER), Holm's method, multiple testing, null distribution, null hypothesis, $p$-value, power (statistical), test statistic, Type I error, Type II error; augmented glossary: false discovery rate (FDR) | pp. 580--593 are R lab + exercises (skipped -- no new conceptual content) |

## Relevance proposal

Filled by the survey-source skill from `courses/README.md` + `foundations/README.md`:
what each part of the source could feed, so the user can pick the extraction goal
from an informed menu. "No clear match" is an honest entry.

| Chapter/section | Relevant to (existing) | New opportunity |
|---|---|---|
| 2 — Statistical Learning (bias-variance, MSE, flexibility) | [model-fit-error-and-validation](../../foundations/model-fit-error-and-validation/lesson.qmd) — second source for bias-variance trade-off, MSE, train/test | — |
| 3 — Linear Regression | [simple-linear-regression](../../courses/simple-linear-regression/syllabus.md), [multiple-regression](../../courses/multiple-regression/syllabus.md) — overlaps existing courses | — |
| 4 — Classification (logistic regression, LDA, kNN, ROC/AUC) | [classification-evaluation](../../foundations/classification-evaluation/lesson.qmd) — confusion matrix, ROC, AUC; [k-nearest-neighbors](../../foundations/k-nearest-neighbors/lesson.qmd) — kNN classifier; [logistic-regression](../../courses/logistic-regression/syllabus.md) — overlaps existing course | — |
| 5 — Resampling Methods (CV, bootstrap) | [resampling-bootstrap-and-permutation](../../foundations/resampling-bootstrap-and-permutation/lesson.qmd) — CV variants, bootstrap; [model-fit-error-and-validation](../../foundations/model-fit-error-and-validation/lesson.qmd) — cross-validation details | — |
| 6 — Linear Model Selection and Regularization | [model-selection-and-information-criteria](../../foundations/model-selection-and-information-criteria/lesson.qmd) — subset selection, AIC/BIC; [ridge-regularization](../../foundations/ridge-regularization/lesson.qmd) — ridge and lasso | — |
| 7 — Moving Beyond Linearity | No clear match | Potential new foundation on splines/GAMs |
| 8 — Tree-Based Methods | No clear match | Potential new course on decision trees / random forests |
| 9 — Support Vector Machines | No clear match | Potential new course on SVMs |
| 10 — Deep Learning | No clear match | — |
| 11 — Survival Analysis and Censored Data | No clear match | Potential new course on survival analysis |
| 12 — Unsupervised Learning (PCA, clustering) | [pca-and-svd](../../foundations/pca-and-svd/lesson.qmd) — PCA exposition; [clustering-k-means-and-hierarchical](../../foundations/clustering-k-means-and-hierarchical/lesson.qmd) — k-means, hierarchical clustering | — |
| 13 — Multiple Testing (FWER, FDR, BH) | [false-discovery-rate](../../foundations/false-discovery-rate/lesson.qmd) — FWER, FDR, Bonferroni, BH | — |

**Decision (2026-07-11):** Extract chapters 2, 4, 5, 6, 12, 13 — targeted to feed foundations on bias-variance/model validation, classification evaluation, kNN, resampling/bootstrap, model selection/regularization, PCA/clustering, and false discovery rate. Skip other chapters.

## Extraction log

- 2026-07-11 — Source record created (survey-source). License flagged and confirmed by human. Extraction goal set to targeted chapters 2, 4, 5, 6, 12, 13.
- 2026-07-11 — Extraction order (dependency-first): ch. 2 → ch. 4 → ch. 5 → ch. 6 → ch. 12 → ch. 13. Ch. 2 is foundational (bias-variance, flexibility); ch. 4 builds on ch. 2 (classification framework); ch. 5 builds on ch. 2 (resampling/CV for model assessment); ch. 6 builds on chs. 2+5 (model selection uses CV); ch. 12 builds on ch. 2 (unsupervised/PCA); ch. 13 builds on hypothesis testing concepts. BATCH MODE — gen-kb-index, render, check-indexes deferred to parent.
- 2026-07-11 — Ch. 2 done. Created concept pages: bias-variance-trade-off, k-nearest-neighbors. Added 13 glossary entries. pp. 42--57 (R lab) skipped -- no conceptual content.
- 2026-07-11 — Ch. 4 done. Created concept page: classification-evaluation. Added 15 glossary entries. pp. 171--195 (R lab + exercises) skipped -- no new conceptual content. Logistic regression, LDA, QDA, naive Bayes, and comparison of classification methods all extracted as glossary entries (the extraction goal targets classification-evaluation metrics rather than full pages for each classifier method). Generalized linear models (GLMs) covered as a glossary entry linking linear/logistic/Poisson regression.
- 2026-07-11 — Ch. 5 done. Created concept page: resampling-bootstrap-and-permutation (matching foundation module slug). Added 7 glossary entries. pp. 213--224 (R lab + exercises) skipped -- no new conceptual content. Chapter covers cross-validation (validation set, LOOCV, k-fold CV), the bias-variance trade-off in choosing k, CV for classification, and the bootstrap. Model assessment vs model selection distinction captured as glossary entries.
- 2026-07-11 — Ch. 6 done. Created concept pages: model-selection-and-information-criteria, ridge-regularization (both matching foundation module slugs). Added 17 glossary entries covering subset selection methods, information criteria, shrinkage/regularization methods, dimension reduction alternatives. pp. 225--265 read (Sections 6.1--6.4); pp. 266--287 (R lab + exercises) skipped. Two concept pages split the chapter: subset selection + information criteria on model-selection-and-information-criteria; ridge, lasso, PCR, PLS on ridge-regularization.
- 2026-07-11 — Ch. 12 done. Augmented concept pages: principal-component-analysis (ISL's loading/score notation, two interpretations, PVE as R^2, scaling, matrix completion, scree plot), clustering-and-k-means (hierarchical clustering, dendrogram, linkage types, dissimilarity measures, within-cluster variation formulation). Added 9 glossary entries. pp. 495--530 read (Sections 12.1--12.4); pp. 530--549 (R lab + exercises) skipped.
- 2026-07-11 — Ch. 13 done. Created concept page: false-discovery-rate (matching foundation module slug). Added 14 glossary entries covering hypothesis testing fundamentals, FWER/FDR definitions, Bonferroni, Holm, Benjamini--Hochberg. Augmented existing FDR glossary entry with ISL's formal definition (E(V/R)) and ISL citation. pp. 551--580 read (Sections 13.1--13.5); pp. 580--593 (R lab + exercises) skipped. BATCH MODE -- gen-kb-index, render, check-indexes deferred to parent.

## Open questions & low-confidence extractions

- (none yet)
