---
title: "Quadratic forms"
topic: linear-algebra
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

A quadratic form is a function $q_A(\mathbf{x}) = \mathbf{x} \cdot (A\mathbf{x})$ defined by a symmetric matrix $A$. Quadratic forms connect eigenvalues to optimization: the maximum and minimum values of $q_A(\mathbf{u})$ over unit vectors $\mathbf{u}$ are the largest and smallest eigenvalues of $A$. [@austin2022understandinglinearalgebra, pp. 433, 437]

**Also known as:** quadratic function (informal, but technically distinct since quadratic forms are homogeneous)

## Definition(s)

If $A$ is a symmetric $m \times m$ matrix, the **quadratic form** defined by $A$ is the function $q_A : \mathbb{R}^m \to \mathbb{R}$ given by $q_A(\mathbf{x}) = \mathbf{x} \cdot (A\mathbf{x})$. [@austin2022understandinglinearalgebra, p. 433]

A symmetric matrix $A$ is **positive definite** if $q_A(\mathbf{x}) > 0$ for all nonzero $\mathbf{x}$; **positive semidefinite** if $q_A(\mathbf{x}) \ge 0$ for all nonzero $\mathbf{x}$; **negative definite** if $q_A(\mathbf{x}) < 0$ for all nonzero $\mathbf{x}$; **indefinite** if $q_A(\mathbf{x})$ takes both positive and negative values. [@austin2022understandinglinearalgebra, p. 440]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $q_A(\mathbf{x}) = \mathbf{x} \cdot (A\mathbf{x})$ | "the quadratic form of A evaluated at x" | A scalar-valued function that is quadratic (not linear) in the components of $\mathbf{x}$. [@austin2022understandinglinearalgebra, p. 433] |

## Key results & derivations

- **Explicit formula ($2 \times 2$).** For a symmetric $A = \begin{bmatrix} a & b \\ b & c \end{bmatrix}$, the quadratic form is $q_A(\mathbf{x}) = ax_1^2 + 2bx_1x_2 + cx_2^2$. [@austin2022understandinglinearalgebra, p. 434]
- **Eigenvalue on eigenvector.** If $\mathbf{x}$ is an eigenvector of $A$ with eigenvalue $\lambda$, then $q_A(\mathbf{x}) = \lambda|\mathbf{x}|^2$. [@austin2022understandinglinearalgebra, p. 434]
- **Scaling.** $q_A(s\mathbf{x}) = s^2 q_A(\mathbf{x})$, so quadratic forms scale with the square of the scalar. [@austin2022understandinglinearalgebra, p. 434]
- **Principal Axes Theorem.** If $A$ is symmetric with eigenvalues $\lambda_1, \ldots, \lambda_m$ and $A = QDQ^T$, then after the orthogonal change of coordinates $\mathbf{y} = Q^T\mathbf{x}$, the quadratic form becomes $q_A(\mathbf{x}) = \lambda_1 y_1^2 + \lambda_2 y_2^2 + \cdots + \lambda_m y_m^2$, with no cross terms. [@austin2022understandinglinearalgebra, p. 439]
- **Max/min on the unit sphere.** If $\lambda_1 \ge \lambda_2 \ge \cdots \ge \lambda_m$ are the eigenvalues of $A$ with corresponding unit eigenvectors $\mathbf{u}_1, \ldots, \mathbf{u}_m$, then the maximum of $q_A(\mathbf{u})$ over all unit vectors is $\lambda_1$ (attained in direction $\mathbf{u}_1$) and the minimum is $\lambda_m$ (attained in direction $\mathbf{u}_m$). [@austin2022understandinglinearalgebra, p. 437]
- **Eigenvalue criterion for definiteness.** A symmetric matrix is positive definite iff all eigenvalues are positive; positive semidefinite iff all eigenvalues are nonneg; indefinite iff some eigenvalues are positive and some negative. [@austin2022understandinglinearalgebra, p. 441]
- **Variance as a quadratic form.** The variance of a demeaned dataset in the direction of a unit vector $\mathbf{u}$ is $V_\mathbf{u} = \mathbf{u} \cdot (C\mathbf{u}) = q_C(\mathbf{u})$, where $C$ is the covariance matrix. [@austin2022understandinglinearalgebra, p. 433]
- **Hessian matrix and the second derivative test.** Near a critical point of a multivariable function $f$, the behavior is governed by the quadratic form of the Hessian $H = \begin{bmatrix} f_{xx} & f_{xy} \\ f_{yx} & f_{yy} \end{bmatrix}$. If $H$ is positive definite, the critical point is a local minimum; if negative definite, a local maximum; if indefinite, a saddle point. [@austin2022understandinglinearalgebra, p. 442]

## Prerequisites

- [spectral-theorem-and-symmetric-matrices](spectral-theorem-and-symmetric-matrices.md) -- the Principal Axes Theorem and the max/min results depend on orthogonal diagonalization of symmetric matrices.
- [eigenvalues-and-eigenvectors](eigenvalues-and-eigenvectors.md) -- eigenvalues determine the extreme values and definiteness of the quadratic form.

## Misconceptions & learner traps

- **"Quadratic forms are linear."** Despite being defined using a matrix (a linear operator), $q_A(\mathbf{x}) = \mathbf{x} \cdot (A\mathbf{x})$ is quadratic in the components of $\mathbf{x}$: it involves squared terms and cross terms. The scaling property $q_A(s\mathbf{x}) = s^2 q_A(\mathbf{x})$ (not $s \cdot q_A(\mathbf{x})$) confirms this. [@austin2022understandinglinearalgebra, p. 434]
- **"Positive definite means all entries are positive."** Positive definiteness is about eigenvalues (all positive), not about matrix entries. A matrix with all positive entries can be indefinite, and a positive definite matrix can have negative off-diagonal entries. [@austin2022understandinglinearalgebra, p. 441]
- **Confusing quadratic form evaluated at an eigenvector with the eigenvalue.** $q_A(\mathbf{x}) = \lambda|\mathbf{x}|^2$, which equals $\lambda$ only when $\mathbf{x}$ is a unit vector. For non-unit eigenvectors, the scaling matters. [@austin2022understandinglinearalgebra, p. 434]

## Teaching insights & analogies

- **Diagonal case builds intuition.** For a diagonal matrix $D = \text{diag}(a, c)$, the quadratic form is just $ax_1^2 + cx_2^2$ -- no cross terms. The general case is the same thing after a rotation to the eigenvector coordinate system (Principal Axes Theorem). [@austin2022understandinglinearalgebra, pp. 434, 439]
- **Graphing the quadratic form on the unit circle.** The textbook uses interactive plots showing how $q_A(\mathbf{u})$ varies as $\mathbf{u}$ moves around the unit circle, making the max/min eigenvalue result visually obvious. The ellipse traced by $A\mathbf{u}$ has semi-axes equal to the singular values. [@austin2022understandinglinearalgebra, p. 435]
- **Variance as the statistical face of quadratic forms.** The connection $V_\mathbf{u} = q_C(\mathbf{u})$ means that finding the direction of maximum variance is literally finding the maximum of a quadratic form on the unit sphere -- which the Spectral Theorem tells us is the largest eigenvalue. This is the mathematical heart of PCA. [@austin2022understandinglinearalgebra, pp. 433, 438]

## How the field talks about it

In statistics, the expression $(\mathbf{x} - \boldsymbol{\mu})^T \Sigma^{-1} (\mathbf{x} - \boldsymbol{\mu})$ in the multivariate normal density is a quadratic form in $\mathbf{x} - \boldsymbol{\mu}$ defined by the precision matrix $\Sigma^{-1}$. The chi-squared statistic $Q = \sum (O_i - E_i)^2/E_i$ can be expressed as a quadratic form. "Positive definite covariance matrix" is shorthand for "all eigenvalues strictly positive," i.e., the data genuinely varies in every direction. [@austin2022understandinglinearalgebra, pp. 440--441, 445]
