---
title: "Spectral theorem and symmetric matrices"
topic: linear-algebra
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

A symmetric matrix ($A = A^T$) is orthogonally diagonalizable: it can be written $A = QDQ^T$ where $Q$ is an orthogonal matrix of eigenvectors and $D$ is a diagonal matrix of eigenvalues. This is the Spectral Theorem, and it is the foundation for PCA, quadratic forms, and the SVD. [@austin2022understandinglinearalgebra, p. 420]

**Also known as:** spectral decomposition, eigendecomposition of a symmetric matrix

## Definition(s)

A **symmetric matrix** is a square matrix $A$ for which $A = A^T$. [@austin2022understandinglinearalgebra, p. 419]

A matrix $A$ is **orthogonally diagonalizable** if it can be written $A = QDQ^T$ where $Q$ is an orthogonal matrix ($Q^{-1} = Q^T$) and $D$ is diagonal. [@austin2022understandinglinearalgebra, p. 419]

**The Spectral Theorem:** A matrix $A$ is orthogonally diagonalizable if and only if $A$ is symmetric. [@austin2022understandinglinearalgebra, p. 420]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $A = QDQ^T$ | "A equals Q D Q transpose" | The orthogonal diagonalization of a symmetric matrix: $Q$'s columns are orthonormal eigenvectors, $D$'s diagonal entries are the corresponding eigenvalues. [@austin2022understandinglinearalgebra, p. 419] |
| $C = \frac{1}{N}AA^T$ | "C equals one over N times A A transpose" | The covariance matrix of a demeaned dataset whose columns are the data points. $C$ is symmetric and positive semidefinite. [@austin2022understandinglinearalgebra, p. 426] |

## Key results & derivations

- **All eigenvalues are real.** If $A$ is symmetric, all its eigenvalues are real numbers (not complex). [@austin2022understandinglinearalgebra, p. 421]
- **Eigenvectors for distinct eigenvalues are orthogonal.** If $A$ is symmetric and $\mathbf{v}_1, \mathbf{v}_2$ are eigenvectors for distinct eigenvalues $\lambda_1 \neq \lambda_2$, then $\mathbf{v}_1 \cdot \mathbf{v}_2 = 0$. The proof uses the key identity $\mathbf{v} \cdot (A\mathbf{w}) = (A\mathbf{v}) \cdot \mathbf{w}$ for symmetric $A$. [@austin2022understandinglinearalgebra, pp. 421--422]
- **Symmetric dot-product identity.** For any matrix $A$, $\mathbf{v} \cdot (A\mathbf{w}) = (A^T\mathbf{v}) \cdot \mathbf{w}$. If $A$ is symmetric, this simplifies to $\mathbf{v} \cdot (A\mathbf{w}) = (A\mathbf{v}) \cdot \mathbf{w}$. [@austin2022understandinglinearalgebra, p. 421]
- **Geometric interpretation.** The factorization $A = QDQ^T$ decomposes the transformation into three steps: rotate to the eigenvector coordinate system ($Q^T$), scale along the axes by the eigenvalues ($D$), then rotate back ($Q$). [@austin2022understandinglinearalgebra, p. 420]
- **Covariance matrix is symmetric.** $C = \frac{1}{N}AA^T$ satisfies $C^T = \frac{1}{N}(AA^T)^T = \frac{1}{N}AA^T = C$. Therefore $C$ is orthogonally diagonalizable by the Spectral Theorem. [@austin2022understandinglinearalgebra, p. 426]
- **Variance via the covariance matrix.** The variance of the demeaned data projected onto the line defined by a unit vector $\mathbf{u}$ is $V_\mathbf{u} = \mathbf{u} \cdot (C\mathbf{u})$. [@austin2022understandinglinearalgebra, p. 426]
- **Eigenvalues of $C$ are directional variances.** If $\mathbf{u}$ is a unit eigenvector of $C$ with eigenvalue $\lambda$, then $V_\mathbf{u} = \lambda$. The largest eigenvalue gives the direction of maximum variance; the smallest gives the direction of minimum variance. [@austin2022understandinglinearalgebra, pp. 430--431]
- **Additivity of variance.** If $W$ is a subspace with orthonormal basis $\mathbf{u}_1, \ldots, \mathbf{u}_n$, the variance of the data projected onto $W$ is $V_W = V_{\mathbf{u}_1} + \cdots + V_{\mathbf{u}_n}$. The total variance equals the sum of all eigenvalues of $C$ (the trace). [@austin2022understandinglinearalgebra, p. 425]
- **$B^TB$ is always symmetric positive semidefinite.** For any matrix $B$, $G = B^TB$ is symmetric and has nonneg eigenvalues because $\mathbf{x} \cdot (G\mathbf{x}) = |B\mathbf{x}|^2 \ge 0$. [@austin2022understandinglinearalgebra, p. 445]

## Prerequisites

- [eigenvalues-and-eigenvectors](eigenvalues-and-eigenvectors.md) -- the Spectral Theorem is about when eigendecomposition takes a particularly nice form (orthogonal diagonalization).
- [orthogonality-and-inner-products](orthogonality-and-inner-products.md) -- orthogonal matrices, orthonormal bases, and the transpose identity are the building blocks.

## Misconceptions & learner traps

- **"Every diagonalizable matrix is symmetric."** A non-symmetric matrix can be diagonalizable ($A = PDP^{-1}$) but its eigenvectors will not be orthogonal and $P$ will not be an orthogonal matrix. The Spectral Theorem says orthogonal diagonalization is the special property of symmetric matrices. [@austin2022understandinglinearalgebra, pp. 418--419]
- **"If a matrix has real eigenvalues, it must be symmetric."** Non-symmetric matrices (e.g., upper triangular) can have all real eigenvalues. Symmetry guarantees real eigenvalues, but real eigenvalues do not guarantee symmetry. [@austin2022understandinglinearalgebra, p. 421]

## Teaching insights & analogies

- **Rotate, stretch, rotate back.** The factorization $A = QDQ^T$ has a vivid geometric interpretation: $Q^T$ rotates to the eigenvector coordinate system where the transformation is just axis-aligned stretching ($D$), then $Q$ rotates back. This makes the effect of any symmetric matrix geometrically transparent. [@austin2022understandinglinearalgebra, p. 420]
- **Variance motivates the Spectral Theorem.** The textbook introduces variance and the covariance matrix before stating the Spectral Theorem, so that orthogonal diagonalization immediately has a concrete application: finding the directions of maximum and minimum variance. [@austin2022understandinglinearalgebra, pp. 422--428]
- **Covariance eigenvalues as variance budget.** The total variance is the sum of all eigenvalues of $C$ (the trace). This "variance budget" interpretation makes it clear why retaining only the largest eigenvalues captures most of the variance -- the connection to PCA. [@austin2022understandinglinearalgebra, pp. 425, 428]

## How the field talks about it

When a statistics paper writes "the spectral decomposition of $\Sigma$" it means $\Sigma = Q\Lambda Q^T$ where $\Lambda = \text{diag}(\lambda_1, \ldots, \lambda_m)$ and $Q$ is orthogonal. In the multivariate normal density (which requires $\Sigma$ to be positive definite, hence invertible), the covariance matrix appears in $|\Sigma|^{-1/2} \exp(-\frac{1}{2}(\mathbf{x} - \boldsymbol{\mu})^T \Sigma^{-1} (\mathbf{x} - \boldsymbol{\mu}))$; the Spectral Theorem guarantees that this quadratic form can always be diagonalized. [@austin2022understandinglinearalgebra, pp. 419--420, 426]
