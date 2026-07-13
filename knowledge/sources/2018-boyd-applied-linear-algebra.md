---
title: "Boyd & Vandenberghe (2018) — Introduction to Applied Linear Algebra"
---

<!-- Copy of .claude/course-authoring/kb-source-template.md. Rules:
     knowledge-base.md + citations.md + source-licensing.md.
     The record is created by the survey-source skill (license, big ideas,
     chapter map, relevance proposal, goal) and then driven by extract-knowledge:
     the chapter table IS the resume mechanism — update a row the moment its
     chapter (or, for long chapters, its page slice) is finished, before
     starting the next one. -->

**File:** source-papers/2018-boyd-applied-linear-algebra.pdf *(PDF removed after extraction; to resume extraction re-download from <https://web.stanford.edu/~boyd/vmls/vmls.pdf>)*
**Bib key:** boyd2018appliedlinearalgebra
**Source license:** © Cambridge University Press, all rights reserved; free web copy permitted by publisher (web.stanford.edu/~boyd/vmls/) — flagged, confirmed by human 2026-07-11
**Extraction goal:** Extract the chapters covering vectors, linear functions, norm & distance, clustering, and least squares (chs. 1–4, 12–13). Skip other chapters.

## Bibliographic record

Boyd, S. and Vandenberghe, L. (2018). *Introduction to Applied Linear Algebra: Vectors, Matrices, and Least Squares*. Cambridge University Press. Full text available at <https://web.stanford.edu/~boyd/vmls/>.

## Big ideas (backward design)

- Represent real-world data (time series, images, word counts, feature vectors) as vectors and manipulate them with addition, scaling, and the inner product [@boyd2018appliedlinearalgebra, ch. 1]
- Recognise a linear function $f(x) = a^\top x + b$ (superposition property) and use it to build a regression model that predicts one quantity from many [@boyd2018appliedlinearalgebra, ch. 2]
- Compute norms, distances, and angles between vectors and use them to quantify similarity, deviation, and clustering quality [@boyd2018appliedlinearalgebra, ch. 3]
- Partition data points into groups by iterating the k-means algorithm (assign to nearest centroid, update centroids) and assess the result with the clustering objective [@boyd2018appliedlinearalgebra, ch. 4]
- Set up and solve a least squares problem $\min \lVert Ax - b \rVert^2$ via the normal equations, and apply it to data fitting (straight lines, polynomials, piecewise, feature engineering) with validation [@boyd2018appliedlinearalgebra, chs. 12–13]

## Chapter coverage map & extraction state

| Chapter | Pages | Status | Concepts extracted | Confidence notes |
|---|---|---|---|---|
| 1 — Vectors | pp. 3–27 | done | vectors-and-operations, inner-product; glossary: affine combination, convex combination, feature vector, sparse vector | — |
| 2 — Linear functions | pp. 29–43 | done | linear-functions; glossary: superposition, Taylor approximation | — |
| 3 — Norm and distance | pp. 45–67 | done | norm-and-distance; glossary: Cauchy--Schwarz inequality, correlation coefficient, Euclidean distance, Euclidean norm, orthogonal, root-mean-square, standardization (z-score) | — |
| 4 — Clustering | pp. 69–87 | done | clustering-and-k-means; glossary: cluster centroid (group representative), clustering objective, k-means algorithm, suboptimal clustering | — |
| 5 — Linear independence | pp. 89–104 | skipped (out of scope for targeted extraction) | — | — |
| 6 — Matrices | pp. 107–127 | skipped (out of scope for targeted extraction) | — | — |
| 7 — Matrix examples | pp. 129–145 | skipped (out of scope for targeted extraction) | — | — |
| 8 — Linear equations | pp. 147–161 | skipped (out of scope for targeted extraction) | — | — |
| 9 — Linear dynamical systems | pp. 163–176 | skipped (out of scope for targeted extraction) | — | — |
| 10 — Matrix multiplication | pp. 177–195 | skipped (out of scope for targeted extraction) | — | — |
| 11 — Matrix inverses | pp. 199–221 | skipped (out of scope for targeted extraction) | — | — |
| 12 — Least squares | pp. 225–243 | done | least-squares; glossary: normal equations, orthogonality principle (least squares), pseudo-inverse | — |
| 13 — Least squares data fitting | pp. 245–283 | done | least-squares-data-fitting; glossary: basis function (feature mapping), feature engineering, one-hot encoding | — |
| 14 — Least squares classification | pp. 285–307 | skipped (out of scope for targeted extraction) | — | — |
| 15 — Multi-objective least squares | pp. 309–337 | skipped (out of scope for targeted extraction) | — | — |
| 16 — Constrained least squares | pp. 339–355 | skipped (out of scope for targeted extraction) | — | — |
| 17 — Constrained least squares applications | pp. 357–379 | skipped (out of scope for targeted extraction) | — | — |
| 18 — Nonlinear least squares | pp. 381–417 | skipped (out of scope for targeted extraction) | — | — |
| 19 — Constrained nonlinear least squares | pp. 419–435 | skipped (out of scope for targeted extraction) | — | — |
| A — Notation | pp. 439–440 | skipped (out of scope for targeted extraction) | — | — |
| B — Complexity | pp. 441–442 | skipped (out of scope for targeted extraction) | — | — |
| C — Derivatives and optimization | pp. 443–449 | skipped (out of scope for targeted extraction) | — | — |
| D — Further study | pp. 451–453 | skipped (out of scope for targeted extraction) | — | — |

## Relevance proposal

| Chapter/section | Relevant to (existing) | New opportunity |
|---|---|---|
| 1 — Vectors | [vectors-and-summation](../../foundations/vectors-and-summation/lesson.qmd) — second source for vector definition, indexing, inner product, summation | — |
| 2 — Linear functions | [linear-combinations-and-data-matrices](../../foundations/linear-combinations-and-data-matrices/lesson.qmd) — superposition, regression model as linear function | — |
| 3 — Norm and distance | [distance-similarity-and-geometry](../../foundations/distance-similarity-and-geometry/lesson.qmd) — second source for Euclidean norm, distance, angle, standard deviation as RMS deviation | — |
| 4 — Clustering | [clustering-k-means-and-hierarchical](../../foundations/clustering-k-means-and-hierarchical/lesson.qmd) — second source for k-means algorithm, clustering objective, convergence | — |
| 5 — Linear independence | No clear match | Foundation on linear independence / basis if needed by a future course |
| 6 — Matrices | [matrices-and-linear-transforms](../../foundations/matrices-and-linear-transforms/lesson.qmd) — second source for matrix definition, transpose, matrix-vector multiplication | — |
| 7 — Matrix examples | No clear match | — |
| 8 — Linear equations | No clear match | — |
| 9 — Linear dynamical systems | No clear match | — |
| 10 — Matrix multiplication | [matrices-and-linear-transforms](../../foundations/matrices-and-linear-transforms/lesson.qmd) — matrix-matrix product, QR factorization | — |
| 11 — Matrix inverses | [matrices-and-linear-transforms](../../foundations/matrices-and-linear-transforms/lesson.qmd) — inverse, pseudo-inverse, solve() | — |
| 12 — Least squares | [simple-linear-regression](../../courses/simple-linear-regression/syllabus.md) — normal equations derivation, OLS solution; [multiple-regression](../../courses/multiple-regression/syllabus.md) — $X^\top X \hat\beta = X^\top y$ | — |
| 13 — Least squares data fitting | [simple-linear-regression](../../courses/simple-linear-regression/syllabus.md) — straight-line fit; [model-fit-error-and-validation](../../foundations/model-fit-error-and-validation/lesson.qmd) — validation, cross-validation; [multiple-regression](../../courses/multiple-regression/syllabus.md) — feature engineering, multi-predictor fits | — |
| 14 — Least squares classification | [classification-evaluation](../../foundations/classification-evaluation/lesson.qmd) — classification framing | Least-squares classifier as a lightweight alternative to logistic regression |
| 15 — Multi-objective least squares | [ridge-regularization](../../foundations/ridge-regularization/lesson.qmd) — regularized data fitting as a multi-objective problem | — |
| 16–17 — Constrained LS / applications | No clear match | — |
| 18–19 — Nonlinear LS | [gradient-descent](../../courses/gradient-descent/syllabus.md) — Gauss-Newton, Levenberg-Marquardt as optimization methods | — |
| C — Derivatives and optimization | [derivative-as-slope](../../foundations/derivative-as-slope/lesson.qmd), [loss-functions-and-optimization](../../foundations/loss-functions-and-optimization/lesson.qmd) — appendix review of calculus for least squares | — |

**Decision (2026-07-11):** Extract the chapters covering vectors, linear functions, norm & distance, clustering, and least squares (chs. 1–4, 12–13). Skip other chapters.

## Extraction log

- 2026-07-11 — Source record created (survey-source). No chapters extracted yet.
- 2026-07-11 — Extraction order (dependency-first): ch. 1 → 2 → 3 → 4 → 12 → 13. Ch. 1 is foundational for all; ch. 2 introduces linear functions needed by ch. 12; ch. 3 introduces norms/distances needed by ch. 4; ch. 12 precedes ch. 13.
- 2026-07-11 — Ch. 1 done. Created concepts: vectors-and-operations, inner-product. Glossary: affine combination, convex combination, feature vector, sparse vector.
- 2026-07-11 — Ch. 2 done. Created concept: linear-functions. Glossary: superposition, Taylor approximation.
- 2026-07-11 — Ch. 3 done. Created concept: norm-and-distance. Glossary: Cauchy--Schwarz inequality, correlation coefficient, Euclidean distance, Euclidean norm, orthogonal, root-mean-square, standardization (z-score).
- 2026-07-11 — Ch. 4 done. Created concept: clustering-and-k-means. Glossary: cluster centroid (group representative), clustering objective, k-means algorithm, suboptimal clustering.
- 2026-07-11 — Ch. 12 done. Created concept: least-squares. Glossary: normal equations, orthogonality principle (least squares), pseudo-inverse.
- 2026-07-11 — Ch. 13 done. Created concept: least-squares-data-fitting. Glossary: basis function (feature mapping), feature engineering, one-hot encoding. All in-scope chapters complete.

## Open questions & low-confidence extractions

- (none yet)
