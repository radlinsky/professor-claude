# Knowledge base

A paper-agnostic, citable encyclopedia of what this repo's sources teach:
definitions, notation, derivations, terminology, misconceptions, teaching
insights, and prerequisite structure. Every claim carries a bracketed citation
into [`references.bib`](references.bib).

- **How entries get here:** the `extract-knowledge` skill (or the
  `knowledge-extractor` agent for a one-shot run) ingests a PDF from
  `source-papers/` — resumable chapter by chapter for big textbooks.
- **How they're used:** `create-course` consults the KB at intake,
  `knowledge-gap-check` audits existing material against it (report-only), and
  the `course-auditor` cross-checks lessons against it (checks 22–23).
- **Two tiers:** lesson-anchoring concepts get a page in
  [`concepts/`](concepts/); atomic vocabulary gets a row in
  [`glossary.md`](glossary.md). Rules: `.claude/course-authoring/knowledge-base.md`;
  citation convention: `.claude/course-authoring/citations.md`.

The table bodies below are **generated** by `Rscript scripts/gen-kb-index.R` —
never edit inside the markers (CI runs `gen-kb-index.R --check`). Unlike the
foundations index, there is no learner Status column: the knowledge base is
fully machine-owned.

## Concepts

| Concept | Topic | Sources | Referenced by |
|---|---|---|---|
<!-- >>> generated: knowledge concepts table (scripts/gen-kb-index.R) — do not edit by hand -->
| [clustering-and-k-means](concepts/clustering-and-k-means.md) | Linear algebra | boyd2018appliedlinearalgebra, james2021introductionstatisticallearning | — |
| [determinants](concepts/determinants.md) | Linear algebra | austin2022understandinglinearalgebra | — |
| [eigenvalues-and-eigenvectors](concepts/eigenvalues-and-eigenvectors.md) | Linear algebra | austin2022understandinglinearalgebra | — |
| [inner-product](concepts/inner-product.md) | Linear algebra | boyd2018appliedlinearalgebra | — |
| [least-squares](concepts/least-squares.md) | Linear algebra | boyd2018appliedlinearalgebra, chan2021probabilitydatascience | — |
| [least-squares-data-fitting](concepts/least-squares-data-fitting.md) | Linear algebra | boyd2018appliedlinearalgebra, chan2021probabilitydatascience | — |
| [linear-functions](concepts/linear-functions.md) | Linear algebra | boyd2018appliedlinearalgebra | — |
| [linear-independence](concepts/linear-independence.md) | Linear algebra | austin2022understandinglinearalgebra | — |
| [norm-and-distance](concepts/norm-and-distance.md) | Linear algebra | boyd2018appliedlinearalgebra | — |
| [orthogonal-projection](concepts/orthogonal-projection.md) | Linear algebra | austin2022understandinglinearalgebra | — |
| [orthogonality-and-inner-products](concepts/orthogonality-and-inner-products.md) | Linear algebra | austin2022understandinglinearalgebra | — |
| [principal-component-analysis](concepts/principal-component-analysis.md) | Linear algebra | austin2022understandinglinearalgebra, chan2021probabilitydatascience, james2021introductionstatisticallearning | — |
| [quadratic-forms](concepts/quadratic-forms.md) | Linear algebra | austin2022understandinglinearalgebra | — |
| [singular-value-decomposition](concepts/singular-value-decomposition.md) | Linear algebra | austin2022understandinglinearalgebra | — |
| [span-of-vectors](concepts/span-of-vectors.md) | Linear algebra | austin2022understandinglinearalgebra | — |
| [spectral-theorem-and-symmetric-matrices](concepts/spectral-theorem-and-symmetric-matrices.md) | Linear algebra | austin2022understandinglinearalgebra | — |
| [vectors-and-operations](concepts/vectors-and-operations.md) | Linear algebra | boyd2018appliedlinearalgebra | — |
| [conditional-probability](concepts/conditional-probability.md) | Probability | chan2021probabilitydatascience | — |
| [continuous-named-distributions](concepts/continuous-named-distributions.md) | Probability | chan2021probabilitydatascience | — |
| [covariance-and-correlation](concepts/covariance-and-correlation.md) | Probability | chan2021probabilitydatascience | — |
| [discrete-named-distributions](concepts/discrete-named-distributions.md) | Probability | chan2021probabilitydatascience | — |
| [expectation-and-moments](concepts/expectation-and-moments.md) | Probability | chan2021probabilitydatascience | — |
| [joint-distributions](concepts/joint-distributions.md) | Probability | chan2021probabilitydatascience | — |
| [probability-and-odds](concepts/probability-and-odds.md) | Probability | chan2021probabilitydatascience | — |
| [random-variables-and-distributions](concepts/random-variables-and-distributions.md) | Probability | chan2021probabilitydatascience | — |
| [sample-statistics-and-convergence](concepts/sample-statistics-and-convergence.md) | Probability | chan2021probabilitydatascience | — |
| [confidence-intervals-and-hypothesis-testing](concepts/confidence-intervals-and-hypothesis-testing.md) | Statistical inference | chan2021probabilitydatascience | — |
| [false-discovery-rate](concepts/false-discovery-rate.md) | Statistical inference | james2021introductionstatisticallearning | — |
| [likelihood-and-log-likelihood](concepts/likelihood-and-log-likelihood.md) | Statistical inference | chan2021probabilitydatascience | — |
| [maximum-a-posteriori-estimation](concepts/maximum-a-posteriori-estimation.md) | Statistical inference | chan2021probabilitydatascience | — |
| [resampling-bootstrap-and-permutation](concepts/resampling-bootstrap-and-permutation.md) | Statistical inference | chan2021probabilitydatascience, james2021introductionstatisticallearning | — |
| [bias-variance-trade-off](concepts/bias-variance-trade-off.md) | Regression & models | chan2021probabilitydatascience, james2021introductionstatisticallearning | — |
| [classification-evaluation](concepts/classification-evaluation.md) | Regression & models | chan2021probabilitydatascience, james2021introductionstatisticallearning | — |
| [k-nearest-neighbors](concepts/k-nearest-neighbors.md) | Regression & models | james2021introductionstatisticallearning | — |
| [model-selection-and-information-criteria](concepts/model-selection-and-information-criteria.md) | Regression & models | james2021introductionstatisticallearning | — |
| [ridge-regularization](concepts/ridge-regularization.md) | Regression & models | chan2021probabilitydatascience, james2021introductionstatisticallearning | — |
<!-- <<< generated: knowledge concepts table -->

## Sources

| Source | Bib key | License | Extraction state |
|---|---|---|---|
<!-- >>> generated: knowledge sources table (scripts/gen-kb-index.R) — do not edit by hand -->
| [Boyd & Vandenberghe (2018) — Introduction to Applied Linear Algebra](sources/2018-boyd-applied-linear-algebra.md) | boyd2018appliedlinearalgebra | © Cambridge University Press, all rights reserved; free web copy permitted by publisher (web.stanford.edu/~boyd/vmls/) — flagged, confirmed by human 2026-07-11 | 6 done · 17 skipped |
| [Chan (2021) — Introduction to Probability for Data Science](sources/2021-chan-probability-data-science.md) | chan2021probabilitydatascience | © 2021 Stanley H. Chan, Michigan Publishing; free electronic distribution for students and instructors (probability4datascience.com) — flagged, confirmed by human 2026-07-11 | 8 done · 2 skipped |
| [James et al. (2021) — An Introduction to Statistical Learning](sources/2021-james-introduction-statistical-learning.md) | james2021introductionstatisticallearning | © Springer, all rights reserved; free PDF officially distributed by the authors at statlearning.com — flagged, confirmed by human 2026-07-11 | 6 done · 7 skipped |
| [Austin (2023) — Understanding Linear Algebra](sources/2022-austin-understanding-linear-algebra.md) | austin2022understandinglinearalgebra | CC-BY-4.0 (Creative Commons Attribution 4.0 International) — OK; attribute David Austin, Grand Valley State University | 5 done · 3 skipped |
<!-- <<< generated: knowledge sources table -->
