---
title: "Austin (2023) — Understanding Linear Algebra"
---

<!-- Copy of .claude/course-authoring/kb-source-template.md. Rules:
     knowledge-base.md + citations.md + source-licensing.md.
     The record is created by the survey-source skill (license, big ideas,
     chapter map, relevance proposal, goal) and then driven by extract-knowledge:
     the chapter table IS the resume mechanism — update a row the moment its
     chapter (or, for long chapters, its page slice) is finished, before
     starting the next one. -->

**File:** source-papers/2022-austin-understanding-linear-algebra.pdf *(PDF removed after extraction; to resume extraction re-download from <https://scholarworks.gvsu.edu/cgi/viewcontent.cgi?article=1026&context=books>)*
**Bib key:** austin2022understandinglinearalgebra
**Source license:** CC-BY-4.0 (Creative Commons Attribution 4.0 International) — OK; attribute David Austin, Grand Valley State University
**Extraction goal:** foundations pca-and-svd, quadratic-forms-and-the-chi-square-statistic, matrices-and-linear-transforms, distance-similarity-and-geometry, multivariate-normal-distribution, and the planned rank-and-linear-independence module — Ch 2 §2.3–2.4, Ch 3 §3.4, Ch 4, Ch 6, Ch 7

## Bibliographic record

Austin, David. *Understanding Linear Algebra*. 2023 Update. Grand Valley State
University. Licensed under CC-BY-4.0. Website: http://gvsu.edu/s/0Ck. Also
available via ScholarWorks: https://scholarworks.gvsu.edu/books/26.

## Big ideas (backward design)

What this source wants a reader to be able to DO after working through it
[@austin2022understandinglinearalgebra]:

- Set up and solve systems of linear equations using Gaussian elimination and
  back-substitution, and classify the solution space (unique, infinitely many,
  none) by reading pivot positions
- Perform matrix–vector and matrix–matrix multiplication and interpret the result
  geometrically as transformations that rotate, stretch, shear, or project
- Determine whether a set of vectors is linearly independent and find the rank of
  a matrix — deciding when a system is over- or under-determined
- Find eigenvalues and eigenvectors of a matrix, diagonalize it when possible, and
  apply eigendecomposition to dynamical systems and Markov chains
- Project a vector onto a subspace, construct orthogonal bases (Gram-Schmidt), and
  derive least-squares solutions as orthogonal projections
- Compute and interpret the SVD and PCA of a data matrix, including variance
  explained and dimensionality reduction
- Use computational tools (Sage) to carry out all of the above on larger examples

## Chapter coverage map & extraction state

| Chapter | Pages | Status | Concepts extracted | Confidence notes |
|---|---|---|---|---|
| 1 — Systems of equations | pp. 1–44 | skipped (out of scope for targeted extraction) | — | — |
| 2 — Vectors, matrices, and linear combinations | pp. 45–144 | done | span-of-vectors, linear-independence | Extracted §2.3 span and §2.4 linear independence only; skipped §2.1–2.2, §2.5–2.6 per scope |
| 3 — Invertibility, bases, and coordinate systems | pp. 145–228 | done | determinants | Extracted §3.4 determinants only; skipped §3.1–3.3, §3.5 per scope |
| 4 — Eigenvalues and eigenvectors | pp. 229–310 | done | eigenvalues-and-eigenvectors | Full extraction; §4.4 dynamical systems and §4.5 Markov chains/PageRank captured as teaching insights only |
| 5 — Linear algebra and computing | pp. 311–334 | skipped (out of scope for targeted extraction) | — | — |
| 6 — Orthogonality and Least Squares | pp. 335–414 | done | orthogonality-and-inner-products, orthogonal-projection | Full extraction: §6.1 dot product, §6.2 orthogonal complements & transpose, §6.3 projections, §6.4 Gram-Schmidt & QR, §6.5 least squares |
| 7 — Singular value decompositions | pp. 415–490 | done | spectral-theorem-and-symmetric-matrices, quadratic-forms, singular-value-decomposition, principal-component-analysis | Full extraction: §7.1 symmetric matrices/variance/covariance, §7.2 quadratic forms/definiteness, §7.3 PCA, §7.4 SVD construction/four subspaces, §7.5 SVD applications (LS, rank-k, compression, condition number) |
| A — Sage Reference | pp. 491–497 | skipped (out of scope for targeted extraction) | — | — |

## Relevance proposal

| Chapter/section | Relevant to (existing) | New opportunity |
|---|---|---|
| 1 — Systems of equations | [matrices-and-linear-transforms](../../foundations/matrices-and-linear-transforms/lesson.qmd) — solving Ax=b underpins the inverse/`solve()` material | no clear match |
| 2 — Vectors, matrices, and linear combinations | [vectors-and-summation](../../foundations/vectors-and-summation/lesson.qmd) — vectors, dot products; [matrices-and-linear-transforms](../../foundations/matrices-and-linear-transforms/lesson.qmd) — matrix multiplication, transpose; [linear-combinations-and-data-matrices](../../foundations/linear-combinations-and-data-matrices/lesson.qmd) — linear combinations; [distance-similarity-and-geometry](../../foundations/distance-similarity-and-geometry/lesson.qmd) — geometry of transformations | Could anchor a rank-and-linear-independence foundation (§2.4 linear independence, §2.3 span) — the learner could decide when a system is over-/under-determined |
| 3 — Invertibility, bases, and coordinate systems | [matrices-and-linear-transforms](../../foundations/matrices-and-linear-transforms/lesson.qmd) — invertibility (§3.1); [multivariate-normal-distribution](../../foundations/multivariate-normal-distribution/lesson.qmd) — determinant mini-lesson (§3.4) | §3.5 subspaces could feed the planned rank-and-linear-independence module |
| 4 — Eigenvalues and eigenvectors | [pca-and-svd](../../foundations/pca-and-svd/lesson.qmd) — eigenvalues/eigenvectors are the core PCA mechanism; [quadratic-forms-and-the-chi-square-statistic](../../foundations/quadratic-forms-and-the-chi-square-statistic/lesson.qmd) — diagonalization (§4.3) | §4.4–4.5 dynamical systems and Markov chains — no clear match to current modules |
| 5 — Linear algebra and computing | no clear match — numerical methods are not directly taught in current modules | no clear match |
| 6 — Orthogonality and Least Squares | [distance-similarity-and-geometry](../../foundations/distance-similarity-and-geometry/lesson.qmd) — dot product, projection (§6.1, §6.3); [simple-linear-regression](../../courses/simple-linear-regression/syllabus.md) — least squares (§6.5); [multiple-regression](../../courses/multiple-regression/syllabus.md) — normal equations as projection (§6.5) | — |
| 7 — Singular value decompositions | [pca-and-svd](../../foundations/pca-and-svd/lesson.qmd) — symmetric matrices & variance (§7.1), PCA (§7.3), SVD (§7.4–7.5); [quadratic-forms-and-the-chi-square-statistic](../../foundations/quadratic-forms-and-the-chi-square-statistic/lesson.qmd) — quadratic forms (§7.2); [variance-structure-and-standardization](../../foundations/variance-structure-and-standardization/lesson.qmd) — covariance matrix and variance (§7.1) | — |
| A — Sage Reference | no clear match | no clear match |

**Decision (2026-07-11):** Extract Ch 2 §2.3–2.4 (span, linear independence), Ch 3 §3.4 (determinants), Ch 4 (eigenvalues/eigenvectors), Ch 6 (orthogonality & least squares), Ch 7 (symmetric matrices, quadratic forms, PCA, SVD). Skip Ch 1 (systems), Ch 5 (numerical), App A (Sage reference).

## Extraction log

- 2026-07-11: Extraction order (dependency-first, matches page order): Ch 2 §2.3–2.4 → Ch 3 §3.4 → Ch 4 → Ch 6 → Ch 7
- 2026-07-11: Ch 2 §2.3–2.4 done. Created: span-of-vectors, linear-independence.
- 2026-07-11: Ch 3 §3.4 done. Created: determinants.
- 2026-07-11: Ch 4 done. Created: eigenvalues-and-eigenvectors. §4.1–4.3 core material (definitions, characteristic equation, eigenspaces, diagonalization, similarity, powers). §4.4 dynamical systems and §4.5 Markov chains/PageRank captured as teaching insights (eigenvalue magnitude interpretation, Perron-Frobenius) rather than separate concepts — application material, not PCA prerequisites.
- 2026-07-11: Ch 6 done. Created: orthogonality-and-inner-products, orthogonal-projection. Two concept pages: (1) inner products/orthogonality/orthonormal bases/orthogonal matrices as building blocks, (2) projection formula/decomposition/least squares/normal equations/QR as the central application. k-means clustering (§6.1.2) and correlation-as-cosine captured as teaching insights.
- 2026-07-11: Ch 7 done. Created: spectral-theorem-and-symmetric-matrices, quadratic-forms, singular-value-decomposition, principal-component-analysis. Four concept pages spanning §7.1–7.5: spectral theorem + covariance matrix + variance-via-eigenvalues; quadratic forms + definiteness + principal axes theorem; SVD construction + four subspaces + rank-k + pseudoinverse; PCA as variance-maximizing projection + SVD shortcut. Image compression, Supreme Court analysis, condition number captured as teaching insights.

## Open questions & low-confidence extractions

- *(none yet)*
