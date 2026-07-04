# Foundations library

Shared, **reusable** building-block modules. Courses link here instead of re-teaching
the same prerequisite.

**Genericity rule:** a module belongs here if it would appear essentially unchanged in
a course about a *different* paper or method (e.g., summation notation, variance,
matrix multiplication, the chain rule). Method-specific material stays in its course.

**Source license:** foundation modules are paper-agnostic and have no `syllabus.md`, so
they carry no source-license verdict — `n/a` by construction (see
`.claude/course-authoring/source-licensing.md`).

Claude: **check this table before writing any prerequisite module.** If a module
already covers the concept, link to it from the new course and add that course to its
*Used by* column. The *Status* column belongs to the learner (`not started` /
`in progress` / `done`) — never overwrite it.

The **Builds on** column records the foundation-to-foundation prerequisite edges (a
kebab-slug link to each module this one leans on; `—` for a root). It must always agree
with the **Builds on:** line inside the module's own `lesson.qmd` — see
`.claude/course-authoring/course-structure.md` §Index tables.

| Module | Concepts covered | Builds on | Used by | Status |
|---|---|---|---|---|
<!-- >>> generated: foundation table (scripts/gen-indexes.R) — do not edit by hand -->
| [derivative-as-slope](derivative-as-slope/lesson.qmd) | The derivative as the slope of a curve; measuring it numerically (central difference); rate of change; reading a slope's sign and steepness | — | [gradient-descent](../courses/gradient-descent/syllabus.md), [logistic-regression](../courses/logistic-regression/syllabus.md) | not started |
| [distance-similarity-and-geometry](distance-similarity-and-geometry/lesson.qmd) | Euclidean distance via Pythagoras (`dist()`), Manhattan & correlation distance in one breath, a vector's length/norm ($\lVert v\rVert$) as distance from zero, "closer = more similar" and why column scale matters, projection as a shadow ($(\mathbf{a}\cdot\mathbf{b})/\lVert\mathbf{b}\rVert$), orthogonal (dot product 0) = separate information, and seeing high-dimensional points via 2-column slices and summary directions | [vectors-and-summation](vectors-and-summation/lesson.qmd), [matrices-and-linear-transforms](matrices-and-linear-transforms/lesson.qmd) | — | not started |
| [exponentials-and-logs](exponentials-and-logs/lesson.qmd) | The constant $e$ and $e^x$, the natural log ($\log$), the undo pair ($\log(e^x)=x$, $e^{\log y}=y$), and the log rules (product→sum, quotient→difference, power→multiplier) | — | [logistic-regression](../courses/logistic-regression/syllabus.md) | not started |
| [linear-combinations-and-data-matrices](linear-combinations-and-data-matrices/lesson.qmd) | A weighted sum of inputs as one number from many (linear combination = dot product), a data table as a matrix (rows = observations, columns = variables), the all-1s column (a base/intercept riding along), $k-1$ indicator (0/1) columns for a $k$-level category (reference absorbed), an interaction column as the product of two columns, reading a weight as "change per unit, others held fixed," and `model.matrix()` as the R bridge | [matrices-and-linear-transforms](matrices-and-linear-transforms/lesson.qmd), [vectors-and-summation](vectors-and-summation/lesson.qmd), [mean-variance-covariance](mean-variance-covariance/lesson.qmd) | — | not started |
| [matrices-and-linear-transforms](matrices-and-linear-transforms/lesson.qmd) | A matrix as a grid/stack of rows (`matrix()`, `dim()`, `A[i,j]`), matrix × vector as one dot product per row (`%*%`), matrix × matrix and conformability, the transpose (`t()`) and why $X^\top X$ appears, the identity, and the inverse as "undo" (`solve()`) and when it fails (singular) | [vectors-and-summation](vectors-and-summation/lesson.qmd), [reading-math-notation](reading-math-notation/lesson.qmd) (soft — for the symbols) | — | not started |
| [mean-variance-covariance](mean-variance-covariance/lesson.qmd) | The mean ($\bar{x}$), deviations from the mean, variance ($s^2$), standard deviation, covariance, correlation | [vectors-and-summation](vectors-and-summation/lesson.qmd) | [simple-linear-regression](../courses/simple-linear-regression/syllabus.md) | not started |
| [probability-and-odds](probability-and-odds/lesson.qmd) | Probability as a number in $[0,1]$, odds ($p/(1-p)$), log-odds (the logit), and converting between all three | [exponentials-and-logs](exponentials-and-logs/lesson.qmd) | [logistic-regression](../courses/logistic-regression/syllabus.md) | not started |
| [reading-math-notation](reading-math-notation/lesson.qmd) | The unwritten reading conventions: accents as operators ($\bar{x}$, $\hat{\beta}$, $\tilde{x}$), Greek-vs-Latin (parameter vs statistic), subscript-vs-superscript roles, implied multiplication, the relation zoo ($=$, $:=$, $\approx$, $\propto$, $\in$), operators ($\mathbb{E}$, $\mathrm{Var}$, $P(\cdot\mid\cdot)$, $\arg\min$), and overloaded $\lvert\cdot\rvert$ | — | all courses (standing first prerequisite — see course-structure.md §Syllabus) | not started |
| [variance-structure-and-standardization](variance-structure-and-standardization/lesson.qmd) | Standardizing / z-scores (center then scale, `scale()`, comparing different-unit columns), the covariance matrix (`cov(df)`: diagonal = variances, off-diagonal = covariances, symmetry, the correlation matrix), splitting spread into within-group vs between-group variation, collinearity (near-duplicate columns as "two knobs, one wheel"), and pooling / shrinkage / borrowing strength in words | [mean-variance-covariance](mean-variance-covariance/lesson.qmd), [matrices-and-linear-transforms](matrices-and-linear-transforms/lesson.qmd) | — | not started |
| [vectors-and-summation](vectors-and-summation/lesson.qmd) | What a vector is (an R vector!), subscript/index notation ($x_i$), summation notation ($\Sigma$), rules for manipulating sums | [reading-math-notation](reading-math-notation/lesson.qmd) (soft — for the symbols) | [simple-linear-regression](../courses/simple-linear-regression/syllabus.md), [gradient-descent](../courses/gradient-descent/syllabus.md), [logistic-regression](../courses/logistic-regression/syllabus.md) | not started |
<!-- <<< generated: foundation table -->
