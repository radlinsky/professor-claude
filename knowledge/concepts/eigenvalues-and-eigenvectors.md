---
title: "Eigenvalues and eigenvectors"
topic: linear-algebra
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

An eigenvector of a square matrix $A$ is a nonzero vector $\mathbf{v}$ whose direction is unchanged by multiplication by $A$: the output $A\mathbf{v}$ is a scalar multiple $\lambda\mathbf{v}$, where the scalar $\lambda$ is called the eigenvalue. [@austin2022understandinglinearalgebra, p. 230]

**Also known as:** characteristic value/vector (older usage); proper value/vector (from German "Eigenwert")

## Definition(s)

An eigenvector of an $n \times n$ matrix $A$ is a nonzero vector $\mathbf{v}$ such that $A\mathbf{v} = \lambda\mathbf{v}$ for some scalar $\lambda$. The scalar $\lambda$ is the eigenvalue associated with $\mathbf{v}$. [@austin2022understandinglinearalgebra, p. 230]

The eigenspace $E_\lambda$ is the set of all vectors $\mathbf{v}$ satisfying $A\mathbf{v} = \lambda\mathbf{v}$, which equals $\text{Nul}(A - \lambda I)$ -- the null space of $A - \lambda I$. The eigenspace always includes the zero vector, but eigenvectors are by definition nonzero, so the eigenvectors for $\lambda$ are the nonzero vectors in $E_\lambda$. [@austin2022understandinglinearalgebra, p. 246]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $A\mathbf{v} = \lambda\mathbf{v}$ | "A v equals lambda v" | The defining eigenvector equation: $A$ stretches or flips $\mathbf{v}$ by the factor $\lambda$. [@austin2022understandinglinearalgebra, p. 230] |
| $E_\lambda$ | "E sub lambda" or "the eigenspace for lambda" | The null space $\text{Nul}(A - \lambda I)$: all vectors (including zero) that satisfy $A\mathbf{v} = \lambda\mathbf{v}$. [@austin2022understandinglinearalgebra, p. 246] |
| $\det(A - \lambda I) = 0$ | "the characteristic equation" | The polynomial equation whose roots are the eigenvalues of $A$. [@austin2022understandinglinearalgebra, p. 245] |

## Key results & derivations

- **Characteristic equation.** The eigenvalues of $A$ are exactly the values of $\lambda$ for which $\det(A - \lambda I) = 0$. Since $A\mathbf{v} = \lambda\mathbf{v}$ means $(A - \lambda I)\mathbf{v} = \mathbf{0}$ must have a nonzero solution, $A - \lambda I$ must be singular, so its determinant must be zero. For an $n \times n$ matrix, this determinant is a degree-$n$ polynomial in $\lambda$ (the characteristic polynomial). [@austin2022understandinglinearalgebra, p. 245]
- **Eigenspace dimension bounds.** The algebraic multiplicity of an eigenvalue $\lambda$ is its multiplicity as a root of the characteristic polynomial. The geometric multiplicity is $\dim(E_\lambda)$. These satisfy $1 \le \dim(E_\lambda) \le m$, where $m$ is the algebraic multiplicity. [@austin2022understandinglinearalgebra, p. 249]
- **Distinct eigenvalues give independent eigenvectors.** If an $n \times n$ matrix has $n$ distinct eigenvalues, the corresponding eigenvectors form a basis for $\mathbb{R}^n$. [@austin2022understandinglinearalgebra, p. 250]
- **Diagonalization.** A matrix $A$ is diagonalizable if it can be written $A = PDP^{-1}$, where $D$ is diagonal and the columns of $P$ are eigenvectors of $A$. The diagonal entries of $D$ are the corresponding eigenvalues. A matrix is diagonalizable if and only if there is a basis of $\mathbb{R}^n$ consisting of eigenvectors of $A$. [@austin2022understandinglinearalgebra, pp. 258--260]
- **Powers via diagonalization.** If $A = PDP^{-1}$, then $A^k = PD^kP^{-1}$, and $D^k$ is computed by raising each diagonal entry to the $k$th power. This makes computing high powers of $A$ efficient. [@austin2022understandinglinearalgebra, p. 262]
- **Similarity.** Two matrices $A$ and $B$ are similar if $B = PAP^{-1}$ for some invertible $P$. Similar matrices have the same eigenvalues. Diagonalizable matrices with the same eigenvalues (including multiplicities) are similar to each other. [@austin2022understandinglinearalgebra, p. 263]
- **Complex eigenvalues.** A $2 \times 2$ matrix with complex eigenvalues $a \pm bi$ performs a rotation by $\theta = \arctan(b/a)$ combined with a scaling by $r = \sqrt{a^2 + b^2}$. [@austin2022understandinglinearalgebra, p. 264]
- **Stochastic matrices have eigenvalue 1.** Every stochastic matrix (columns are probability vectors) has $\lambda = 1$ as an eigenvalue, and all other eigenvalues satisfy $|\lambda_j| \le 1$. The eigenvector for $\lambda = 1$ is the steady-state vector. [@austin2022understandinglinearalgebra, p. 296]
- **Perron-Frobenius theorem.** If $A$ is a positive stochastic matrix (either $A$ or some power $A^k$ has all positive entries), then $\lambda_1 = 1$ and $|\lambda_j| < 1$ for $j > 1$, guaranteeing a unique positive steady-state vector to which every Markov chain converges. [@austin2022understandinglinearalgebra, p. 296]

## Prerequisites

- [determinants](determinants.md) -- the characteristic equation $\det(A - \lambda I) = 0$ requires computing determinants to find eigenvalues.
- [linear-independence](linear-independence.md) -- diagonalizability depends on whether eigenvectors form a basis (a linearly independent spanning set).
- [matrices-and-linear-transforms](../../foundations/matrices-and-linear-transforms/lesson.qmd) -- eigenvectors are defined in terms of matrix-vector multiplication and the geometric interpretation of linear transformations.

## Misconceptions & learner traps

- **"Every matrix is diagonalizable."** A matrix is diagonalizable only if there is a full basis of eigenvectors. A matrix can fail this: for example, a $2 \times 2$ matrix with a repeated eigenvalue whose eigenspace is only one-dimensional (geometric multiplicity < algebraic multiplicity). [@austin2022understandinglinearalgebra, p. 260]
- **"Eigenvectors are unique."** Any nonzero scalar multiple of an eigenvector is also an eigenvector for the same eigenvalue. The eigenspace is a subspace, not a single vector. What matters is the eigenspace (direction), not the specific vector chosen. [@austin2022understandinglinearalgebra, p. 246]
- **"Zero can be an eigenvector."** By definition, eigenvectors must be nonzero. The zero vector trivially satisfies $A\mathbf{0} = \lambda\mathbf{0}$ for every $\lambda$, so it carries no information about $A$. [@austin2022understandinglinearalgebra, p. 230]
- **Confusing eigenvalue zero with "no eigenvalue."** $\lambda = 0$ is a valid eigenvalue; it means $A\mathbf{v} = \mathbf{0}$, so the eigenvectors are the nonzero vectors in $\text{Nul}(A)$. Having eigenvalue zero means $A$ is singular. [@austin2022understandinglinearalgebra, p. 245]

## Teaching insights & analogies

- **Geometric intuition first.** The textbook begins with the geometric question: which vectors does $A$ simply stretch or flip, without changing direction? This makes the formal definition $A\mathbf{v} = \lambda\mathbf{v}$ feel natural -- it is asking for the "special directions" of the transformation. [@austin2022understandinglinearalgebra, pp. 229--232]
- **Eigenvalue magnitude as growth/decay.** In dynamical systems $\mathbf{x}_{k+1} = A\mathbf{x}_k$, the eigenvalue magnitude determines long-term behavior: $|\lambda| > 1$ means growth, $|\lambda| < 1$ means decay, $|\lambda| = 1$ means oscillation or steady state. Complex eigenvalues produce spiraling trajectories. This connects the abstract algebra to physically observable behavior. [@austin2022understandinglinearalgebra, pp. 278--281]
- **Diagonalization as "simplify, compute, translate back."** Writing $A = PDP^{-1}$ means: change to the eigenvector coordinate system ($P^{-1}$), do a simple diagonal scaling ($D$), then change back ($P$). Powers become trivial: $A^k = PD^kP^{-1}$, and $D^k$ just raises each diagonal entry to the $k$th power. [@austin2022understandinglinearalgebra, p. 262]
- **PageRank as a real-world eigenvalue application.** Google's PageRank algorithm finds the steady-state vector (eigenvector for $\lambda = 1$) of a modified stochastic matrix built from the web's link structure. This concrete, familiar application motivates why eigenvalues matter outside of pure mathematics. [@austin2022understandinglinearalgebra, pp. 298--303]
- **Classification of 2x2 dynamical systems.** The textbook provides a complete classification of $2 \times 2$ systems based on eigenvalue type: two positive (saddle or repeller/attractor), two negative (flip behavior), complex (spiral), repeated (special cases). This taxonomy gives learners a framework for predicting behavior from eigenvalues alone. [@austin2022understandinglinearalgebra, pp. 278--281]

## How the field talks about it

When a paper writes "let $\lambda_1 \ge \lambda_2 \ge \cdots \ge \lambda_n$ be the eigenvalues of $A$" it assumes the reader knows these come from the characteristic polynomial and are ordered by magnitude. The notation $A = PDP^{-1}$ (or $A = Q\Lambda Q^T$ for symmetric matrices) is standard shorthand for eigendecomposition. In PCA and covariance-matrix contexts, eigenvalues represent variance explained along each eigenvector direction -- the connection between the algebraic definition and the statistical interpretation is via the spectral theorem for symmetric matrices (Ch 7). [@austin2022understandinglinearalgebra, pp. 245, 259]
