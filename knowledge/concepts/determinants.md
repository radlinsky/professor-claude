---
title: "Determinants"
topic: linear-algebra
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

The determinant is a numerical quantity associated with a square matrix that tells whether the matrix is invertible: a matrix is invertible if and only if its determinant is nonzero. [@austin2022understandinglinearalgebra, §3.4]

**Also known as:** det($A$)

## Definition(s)

For a $2 \times 2$ matrix $A = [\mathbf{v}_1 \; \mathbf{v}_2]$: if the ordered pair of column vectors is positively oriented (counterclockwise angle from $\mathbf{v}_1$ to $\mathbf{v}_2$ is less than 180 degrees), then $\det(A)$ equals the area of the parallelogram formed by $\mathbf{v}_1$ and $\mathbf{v}_2$. If the pair is negatively oriented, $\det(A)$ is minus the area. [@austin2022understandinglinearalgebra, p. 203]

For an $n \times n$ matrix, the determinant generalizes to the signed volume of the parallelepiped (higher-dimensional parallelogram) defined by the columns of the matrix. [@austin2022understandinglinearalgebra, p. 205]

The $2 \times 2$ determinant has an algebraic formula: $\det\begin{bmatrix} a & b \\ c & d \end{bmatrix} = ad - bc$. [@austin2022understandinglinearalgebra, p. 209]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $\det(A)$ | "the determinant of A" | The signed volume scaling factor of the matrix $A$. [@austin2022understandinglinearalgebra, p. 203] |

## Key results & derivations

- **Invertibility criterion.** A matrix $A$ is invertible if and only if $\det(A) \neq 0$. When the columns are linearly dependent, the parallelogram collapses to a lower-dimensional object with zero area/volume, so $\det(A) = 0$. [@austin2022understandinglinearalgebra, pp. 206--207]
- **Multiplicative property.** $\det(AB) = \det(A)\det(B)$. Geometrically, the matrix transformation defined by $B$ scales area by $\det(B)$, and composing with $A$ scales by an additional factor of $\det(A)$. [@austin2022understandinglinearalgebra, p. 206]
- **Triangular matrix rule.** The determinant of a triangular matrix equals the product of its diagonal entries. [@austin2022understandinglinearalgebra, p. 205]
- **Determinant of the inverse.** If $A$ is invertible, then $\det(A^{-1}) = 1/\det(A)$. This follows from $\det(A^{-1}A) = \det(A^{-1})\det(A) = \det(I) = 1$. [@austin2022understandinglinearalgebra, p. 209]
- **Effect of row operations on the determinant.** Scaling a row by $k$ multiplies the determinant by $k$. Interchanging two rows negates the determinant. A row replacement (adding a multiple of one row to another) does not change the determinant. [@austin2022understandinglinearalgebra, pp. 207--208]
- **Computing via row reduction.** Reduce $A$ to an upper triangular matrix $U$ using Gaussian elimination, tracking the row operations. The determinant of $U$ is the product of its diagonal entries, and the original determinant is recovered by accounting for the effect of each row operation. This is how most computer programs compute determinants. [@austin2022understandinglinearalgebra, pp. 209, 213]
- **Cofactor expansion.** An alternative method for computing determinants: choose any row or column, then form a sum of terms, one per entry. Each term is $(-1)^{i+j}$ times the entry times the determinant of the submatrix obtained by deleting row $i$ and column $j$. This method is important for finding eigenvalues (Ch 4) but is computationally expensive: an $n \times n$ cofactor expansion involves $n!$ terms, whereas Gaussian elimination requires $O(n^3)$ operations. [@austin2022understandinglinearalgebra, pp. 209--213]

## Prerequisites

- [linear-independence](linear-independence.md) -- the determinant is zero precisely when the columns are linearly dependent; understanding dependence is needed to interpret what det = 0 means.
- [matrices-and-linear-transforms](../../foundations/matrices-and-linear-transforms/lesson.qmd) -- computing determinants via row operations requires understanding Gaussian elimination and row reduction.

## Misconceptions & learner traps

- **"The determinant is always positive."** The determinant is a signed quantity: it is negative when the column vectors are negatively oriented (the ordering flips the orientation). For instance, $\det\begin{bmatrix} 0 & 1 \\ 1 & 0 \end{bmatrix} = -1$. [@austin2022understandinglinearalgebra, p. 206]
- **Confusing cofactor expansion cost with row-reduction cost.** Cofactor expansion for an $n \times n$ matrix involves $n!$ terms (over 3.6 million for $n = 10$), while Gaussian elimination involves $O(n^3)$ operations (1000 for $n = 10$). Row reduction is far more practical for computation. [@austin2022understandinglinearalgebra, pp. 212--213]

## Teaching insights & analogies

- **Geometric definition first.** The textbook introduces determinants as the signed area of the parallelogram formed by the columns (for $2 \times 2$) before giving the algebraic formula. This geometric grounding makes it natural that linearly dependent columns produce zero determinant (the parallelogram collapses) and that $\det(AB) = \det(A)\det(B)$ (composing area-scaling factors). [@austin2022understandinglinearalgebra, pp. 201--206]
- **Area scaling interpretation.** Rather than thinking of the determinant as just an area, it can be understood as a factor by which the matrix transformation scales all areas. Applying the transformation defined by $B$ scales area by $\det(B)$; composing with $A$ gives a total scaling of $\det(A)\det(B)$, which explains the multiplicative property. [@austin2022understandinglinearalgebra, p. 206]
- **Three computation methods, different strengths.** The geometric definition builds intuition (area/volume). Row operations provide an efficient computation method and explain the invertibility connection. Cofactor expansion, though expensive, is the tool needed for the characteristic equation that finds eigenvalues. [@austin2022understandinglinearalgebra, p. 212]

## How the field talks about it

When a paper writes $|A| \neq 0$ or "$A$ is nonsingular" without further explanation, it means $A$ is invertible -- the determinant test is the standard characterization. The determinant appears in the multivariate normal density (as $|\Sigma|^{-1/2}$) and in change-of-variables formulas for integration (as the absolute value of the Jacobian determinant). [@austin2022understandinglinearalgebra, pp. 207, 209]
