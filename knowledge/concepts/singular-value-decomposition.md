---
title: "Singular value decomposition"
topic: linear-algebra
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

The singular value decomposition (SVD) writes any $m \times n$ matrix as $A = U\Sigma V^T$, where $U$ and $V$ are orthogonal matrices and $\Sigma$ is diagonal with nonnegative entries (the singular values). Unlike eigendecomposition, SVD works for every matrix -- square or not, symmetric or not. [@austin2022understandinglinearalgebra, p. 464]

**Also known as:** SVD

## Definition(s)

An $m \times n$ matrix $A$ may be written as $A = U\Sigma V^T$ where $U$ is an orthogonal $m \times m$ matrix, $V$ is an orthogonal $n \times n$ matrix, and $\Sigma$ is an $m \times n$ matrix whose only nonzero entries are on the diagonal: $\sigma_1 \ge \sigma_2 \ge \cdots \ge 0$. The diagonal entries $\sigma_i$ are the **singular values** of $A$. The columns of $U$ are the **left singular vectors**; the columns of $V$ are the **right singular vectors**. [@austin2022understandinglinearalgebra, p. 464]

The **reduced singular value decomposition** of a rank-$r$ matrix is $A = U_r \Sigma_r V_r^T$, where $U_r$ is $m \times r$, $\Sigma_r$ is $r \times r$ diagonal and invertible, and $V_r$ is $n \times r$. [@austin2022understandinglinearalgebra, p. 469]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $A = U\Sigma V^T$ | "A equals U Sigma V transpose" | The full singular value decomposition. [@austin2022understandinglinearalgebra, p. 464] |
| $\sigma_i$ | "sigma i" | The $i$th singular value: $\sigma_i = \sqrt{\lambda_i}$ where $\lambda_i$ is the $i$th eigenvalue of $G = A^TA$. [@austin2022understandinglinearalgebra, p. 462] |
| $G = A^TA$ | "the Gram matrix" | A symmetric positive semidefinite matrix whose eigenvalues are the squares of the singular values. [@austin2022understandinglinearalgebra, p. 459] |
| $A^+ = V_r\Sigma_r^{-1}U_r^T$ | "A plus" or "the pseudoinverse of A" | The Moore-Penrose pseudoinverse; equals $A^{-1}$ when $A$ is invertible. [@austin2022understandinglinearalgebra, p. 489] |

## Key results & derivations

- **Construction procedure.** (1) Form the Gram matrix $G = A^TA$, which is symmetric. (2) Find its eigenvalues $\lambda_i$ and orthonormal eigenvectors $\mathbf{v}_i$ (right singular vectors). (3) Singular values are $\sigma_i = \sqrt{\lambda_i}$. (4) Left singular vectors are $\mathbf{u}_i = A\mathbf{v}_i / \sigma_i$ for each nonzero $\sigma_i$. [@austin2022understandinglinearalgebra, pp. 461--462]
- **Universality.** Every matrix has a singular value decomposition, whether square or rectangular, symmetric or not. [@austin2022understandinglinearalgebra, p. 464]
- **Singular values as max/min of $|A\mathbf{x}|$.** The singular values are the maximum and minimum values of $|A\mathbf{u}|$ over unit vectors $\mathbf{u}$: $\sigma_1$ is the maximum, $\sigma_n$ (or $\sigma_r$) is the minimum nonzero value. [@austin2022understandinglinearalgebra, pp. 459--460]
- **Rank equals number of nonzero singular values.** $\text{rank}(A) = r$ where $r$ is the number of positive singular values. Also, $\text{rank}(A) = \text{rank}(A^T)$. [@austin2022understandinglinearalgebra, pp. 466--467]
- **Four fundamental subspaces.** The SVD provides orthonormal bases for all four subspaces: $\mathbf{u}_1, \ldots, \mathbf{u}_r$ for $\text{Col}(A)$; $\mathbf{u}_{r+1}, \ldots, \mathbf{u}_m$ for $\text{Nul}(A^T)$; $\mathbf{v}_1, \ldots, \mathbf{v}_r$ for $\text{Col}(A^T)$; $\mathbf{v}_{r+1}, \ldots, \mathbf{v}_n$ for $\text{Nul}(A)$. [@austin2022understandinglinearalgebra, p. 468]
- **$A$ and $A^T$ share singular values.** The left singular vectors of $A$ are the right singular vectors of $A^T$, and vice versa. [@austin2022understandinglinearalgebra, p. 464]
- **Left singular vectors are orthonormal.** The proof uses $\sigma_i\sigma_j(\mathbf{u}_i \cdot \mathbf{u}_j) = (A\mathbf{v}_i) \cdot (A\mathbf{v}_j) = \mathbf{v}_i \cdot (G\mathbf{v}_j) = \lambda_j(\mathbf{v}_i \cdot \mathbf{v}_j) = 0$ for $i \neq j$. [@austin2022understandinglinearalgebra, p. 462]
- **Outer product decomposition.** $A = \sigma_1\mathbf{u}_1\mathbf{v}_1^T + \sigma_2\mathbf{u}_2\mathbf{v}_2^T + \cdots + \sigma_r\mathbf{u}_r\mathbf{v}_r^T$. Each term $\sigma_i\mathbf{u}_i\mathbf{v}_i^T$ is a rank-1 matrix. [@austin2022understandinglinearalgebra, p. 478]
- **Rank-$k$ approximation.** $A_k = \sum_{i=1}^{k} \sigma_i\mathbf{u}_i\mathbf{v}_i^T$ is the closest rank-$k$ matrix to $A$ (in the Frobenius norm). This is the basis for image compression and denoising. [@austin2022understandinglinearalgebra, pp. 476--477]
- **Least squares via SVD.** The least-squares approximate solution is $\widehat{\mathbf{x}} = V_r\Sigma_r^{-1}U_r^T\mathbf{b}$. The matrix $A^+ = V_r\Sigma_r^{-1}U_r^T$ is the Moore-Penrose pseudoinverse. [@austin2022understandinglinearalgebra, pp. 476, 489]
- **Condition number.** For an invertible matrix, $\kappa(A) = \sigma_1/\sigma_n$, the ratio of the largest to smallest singular value. Large condition numbers indicate ill-conditioning: small perturbations in input produce large changes in output. [@austin2022understandinglinearalgebra, p. 489]

## Prerequisites

- [spectral-theorem-and-symmetric-matrices](spectral-theorem-and-symmetric-matrices.md) -- the SVD is constructed by orthogonally diagonalizing the symmetric Gram matrix $G = A^TA$.
- [orthogonal-projection](orthogonal-projection.md) -- the first $r$ left singular vectors form an orthonormal basis for $\text{Col}(A)$, enabling projection and least-squares computation.
- [eigenvalues-and-eigenvectors](eigenvalues-and-eigenvectors.md) -- singular values are square roots of eigenvalues of $A^TA$.

## Misconceptions & learner traps

- **"SVD is the same as eigendecomposition."** Eigendecomposition ($A = PDP^{-1}$) requires a square matrix and may not exist. SVD ($A = U\Sigma V^T$) works for any matrix and always uses orthogonal matrices. For a symmetric positive semidefinite matrix, the SVD reduces to the spectral decomposition. [@austin2022understandinglinearalgebra, pp. 458, 463]
- **"Singular values can be negative."** By convention, singular values are always nonneg ($\sigma_i \ge 0$). Any sign is absorbed into the left singular vectors $\mathbf{u}_i$. [@austin2022understandinglinearalgebra, p. 462]
- **Confusing singular values with eigenvalues.** For a symmetric matrix, $\sigma_i = |\lambda_i|$. For a general matrix, there is no simple relationship between eigenvalues and singular values. [@austin2022understandinglinearalgebra, p. 472]

## Teaching insights & analogies

- **SVD as X-ray vision.** The textbook quotes the analogy that "a singular value decomposition is like looking at a matrix with X-ray vision": it reveals the rank, the four fundamental subspaces, the condition number, and the best low-rank approximations. [@austin2022understandinglinearalgebra, p. 415]
- **Generalization of orthogonal diagonalization.** The Spectral Theorem says symmetric matrices have $A = QDQ^T$ (one orthogonal matrix). SVD generalizes this to non-symmetric/non-square matrices by using TWO orthogonal matrices: $A = U\Sigma V^T$. [@austin2022understandinglinearalgebra, p. 464]
- **Image compression as rank-$k$ approximation.** The textbook uses an image matrix to show how $A_k$ (retaining the first $k$ singular value terms) approximates the image with increasing fidelity. The compression ratio shows the storage tradeoff. [@austin2022understandinglinearalgebra, pp. 480--482]
- **Supreme Court voting analysis.** SVD of a 9x911 voting matrix reveals voting blocs and swing votes via the first few left singular vectors, making an abstract factorization concretely interpretable. [@austin2022understandinglinearalgebra, pp. 482--488]

## How the field talks about it

In data science, "compute the SVD" is the standard approach to PCA, least squares, pseudoinverse, and low-rank approximation. Software (R's `svd()`, Python's `numpy.linalg.svd()`) returns $U$, $\Sigma$, and $V^T$ directly. When a paper says "the first $k$ singular vectors," it typically means the first $k$ columns of $U$ or $V$ (depending on context). The "thin" or "economy" SVD is the reduced form $U_r\Sigma_r V_r^T$. [@austin2022understandinglinearalgebra, pp. 464, 469]
