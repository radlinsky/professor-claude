---
title: "Least squares"
topic: linear-algebra
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

The least squares problem is to find the $n$-vector $\hat{x}$ that minimizes $\lVert Ax - b \rVert^2$, the sum of squared residuals, where $A$ is a tall $m \times n$ matrix ($m > n$) with linearly independent columns and $b$ is an $m$-vector. The unique solution is $\hat{x} = (A^\top A)^{-1} A^\top b$, obtained by setting the gradient of the objective to zero. Least squares was discovered independently by Gauss and Legendre around the beginning of the 19th century and is the foundation of regression, data fitting, and many signal processing methods. [@boyd2018appliedlinearalgebra, ch. 12]

**Also known as:** linear least squares (to distinguish from the nonlinear variant); ordinary least squares (OLS) in statistics; regression (when applied to data fitting)

## Definition(s)

Given a tall $m \times n$ matrix $A$ and an $m$-vector $b$, the *least squares problem* is

$$\text{minimize} \quad \lVert Ax - b \rVert^2,$$

where the variable is the $n$-vector $x$. The quantity $r = Ax - b$ is the *residual*; the objective $\lVert Ax - b \rVert^2 = r_1^2 + \cdots + r_m^2$ is the sum of squared residuals. The matrix $A$ and vector $b$ are the *data* of the problem. [@boyd2018appliedlinearalgebra, pp. 225--226]

A vector $\hat{x}$ satisfying $\lVert A\hat{x} - b \rVert^2 \le \lVert Ax - b \rVert^2$ for all $x$ is a *solution* of the least squares problem. The vector $\hat{x}$ is called a *least squares approximate solution* of $Ax = b$: it does not in general satisfy $A\hat{x} = b$, but it makes the residual norm as small as possible. [@boyd2018appliedlinearalgebra, p. 226]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $\lVert Ax - b \rVert^2$ | "norm of A x minus b, squared" | The least squares objective: the sum of squared residuals. [@boyd2018appliedlinearalgebra, p. 225] |
| $r = Ax - b$ | "the residual" | The vector of errors in the equations $Ax = b$. Some authors define it as $b - Ax$; the norm is the same. [@boyd2018appliedlinearalgebra, p. 225] |
| $A^\top A \hat{x} = A^\top b$ | "the normal equations" | The system of $n$ equations in $n$ unknowns whose solution gives $\hat{x}$. The matrix $A^\top A$ is the Gram matrix of $A$. [@boyd2018appliedlinearalgebra, p. 229] |
| $\hat{x} = (A^\top A)^{-1} A^\top b$ | "x-hat equals A-transpose-A inverse A-transpose b" | The closed-form least squares solution. Requires the columns of $A$ to be linearly independent. [@boyd2018appliedlinearalgebra, p. 229] |
| $A^\dagger$ | "A pseudo-inverse" or "A dagger" | The matrix $(A^\top A)^{-1} A^\top$, which is also the left inverse of $A$. The least squares solution is $\hat{x} = A^\dagger b$. [@boyd2018appliedlinearalgebra, p. 229] |
| $\hat{r} = A\hat{x} - b$ | "the optimal residual" | The residual at the least squares solution. Its norm $\lVert \hat{r} \rVert$ is the *optimal residual norm*. [@boyd2018appliedlinearalgebra, p. 226] |

## Key results & derivations

- **Gradient of the objective** -- The gradient of $f(x) = \lVert Ax - b \rVert^2$ is $\nabla f(x) = 2A^\top(Ax - b)$. Setting this to zero gives the normal equations $A^\top A \hat{x} = A^\top b$. The derivation proceeds component-wise: $\nabla f(x)_k = 2 \sum_{i=1}^{m} (\sum_{j=1}^{n} A_{ij} x_j - b_i) A_{ik} = (2A^\top(Ax - b))_k$. [@boyd2018appliedlinearalgebra, pp. 228--229]
- **Uniqueness of solution** -- When the columns of $A$ are linearly independent, $A^\top A$ is invertible, so the normal equations have the unique solution $\hat{x} = (A^\top A)^{-1} A^\top b$. [@boyd2018appliedlinearalgebra, p. 229]
- **Direct verification (calculus-free)** -- For any $x \neq \hat{x}$, decompose $\lVert Ax - b \rVert^2 = \lVert A(x - \hat{x}) \rVert^2 + \lVert A\hat{x} - b \rVert^2 + 2(Ax - A\hat{x})^\top(A\hat{x} - b)$. The cross term vanishes because $(Ax - A\hat{x})^\top(A\hat{x} - b) = (x - \hat{x})^\top A^\top(A\hat{x} - b) = (x - \hat{x})^\top 0 = 0$ (using the normal equations). Therefore $\lVert Ax - b \rVert^2 = \lVert A(x - \hat{x}) \rVert^2 + \lVert A\hat{x} - b \rVert^2 > \lVert A\hat{x} - b \rVert^2$ (since $A$ has linearly independent columns, $A(x - \hat{x}) \neq 0$). [@boyd2018appliedlinearalgebra, p. 230]
- **Orthogonality principle** -- The optimal residual $\hat{r} = A\hat{x} - b$ is orthogonal to every column of $A$, and therefore to every linear combination $Az$: $(Az)^\top \hat{r} = 0$ for all $z$. Geometrically, $A\hat{x}$ is the point in the column space of $A$ that is closest to $b$, and $\hat{r}$ is the perpendicular from $b$ to that column space. [@boyd2018appliedlinearalgebra, p. 231]
- **Solution via QR factorization** -- Algorithm 12.1: (1) Compute $A = QR$; (2) Compute $Q^\top b$; (3) Solve $R\hat{x} = Q^\top b$ by back substitution. This is numerically more stable than forming $A^\top A$ directly. Complexity: $2mn^2$ flops (dominated by the QR step). [@boyd2018appliedlinearalgebra, pp. 231--232]
- **Row form of solution** -- If the rows of $A$ are $\tilde{a}_1^\top, \ldots, \tilde{a}_m^\top$, the solution can be written as $\hat{x} = \bigl(\sum_{i=1}^{m} \tilde{a}_i \tilde{a}_i^\top\bigr)^{-1} \bigl(\sum_{i=1}^{m} b_i \tilde{a}_i\bigr)$. This expresses the Gram matrix as a sum of outer products and $A^\top b$ as a weighted sum of the row vectors. [@boyd2018appliedlinearalgebra, p. 230]
- **Column interpretation** -- $\lVert Ax - b \rVert^2 = \lVert x_1 a_1 + \cdots + x_n a_n - b \rVert^2$: the problem is to find the linear combination of the columns of $A$ closest to $b$. [@boyd2018appliedlinearalgebra, p. 226]
- **Row interpretation** -- $\lVert Ax - b \rVert^2 = (\tilde{a}_1^\top x - b_1)^2 + \cdots + (\tilde{a}_m^\top x - b_m)^2$: the problem is to minimize the sum of squares of the errors in $m$ scalar linear equations. [@boyd2018appliedlinearalgebra, p. 226]
- **Matrix least squares** -- The extension $\min \lVert AX - B \rVert^2$ (with $X$ an $n \times k$ matrix) decomposes into $k$ independent vector least squares problems, one per column. The solution is $\hat{X} = A^\dagger B$. [@boyd2018appliedlinearalgebra, p. 233]
- **Linearity in the data** -- The solution $\hat{x} = A^\dagger b$ is a linear function of $b$. This generalizes the fact that the solution of a square invertible system $x = A^{-1}b$ is linear in $b$. [@boyd2018appliedlinearalgebra, p. 229]
- **Overdetermined system: full rank** -- When $\boldsymbol{X} \in \mathbb{R}^{N \times d}$ with $N > d$ and $\text{rank}(\boldsymbol{X}) = d$ (full column rank), $\boldsymbol{X}^\top\!\boldsymbol{X}$ is invertible, and the least squares problem and the system $\boldsymbol{y} = \boldsymbol{X}\boldsymbol{\theta}$ share the same unique solution $\hat{\boldsymbol{\theta}} = (\boldsymbol{X}^\top\!\boldsymbol{X})^{-1}\boldsymbol{X}^\top\!\boldsymbol{y}$. [@chan2021probabilitydatascience, pp. 409--410, Thm 7.1]
- **Overdetermined system: rank-deficient** -- When $\text{rank}(\boldsymbol{X}) < d$, $\boldsymbol{X}^\top\!\boldsymbol{X}$ is not invertible. If $\boldsymbol{y}$ lies in the range space of $\boldsymbol{X}$, the system $\boldsymbol{y} = \boldsymbol{X}\boldsymbol{\theta}$ has infinitely many solutions (all are global minimizers with objective value 0); if $\boldsymbol{y} \notin \text{range}(\boldsymbol{X})$, the system has no solution but the minimization problem still has a (non-unique) global minimizer. [@chan2021probabilitydatascience, p. 410]
- **Underdetermined system: minimum-norm solution** -- When $\boldsymbol{X} \in \mathbb{R}^{N \times d}$ with $N < d$ (fat and short), the system $\boldsymbol{y} = \boldsymbol{X}\boldsymbol{\theta}$ has infinitely many solutions. Among all solutions, the minimum-norm solution $\hat{\boldsymbol{\theta}} = \boldsymbol{X}^\top(\boldsymbol{X}\boldsymbol{X}^\top)^{-1}\boldsymbol{y}$ minimizes $\lVert\boldsymbol{\theta}\rVert^2$ subject to $\boldsymbol{y} = \boldsymbol{X}\boldsymbol{\theta}$, provided $\text{rank}(\boldsymbol{X}) = N$. The proof uses a Lagrangian with multiplier $\boldsymbol{\lambda}$. [@chan2021probabilitydatascience, pp. 411--412, Thm 7.2]

## Prerequisites

- [Vectors and operations](vectors-and-operations.md) -- vectors, addition, scalar multiplication, inner product.
- [Norm and distance](norm-and-distance.md) -- the objective is a squared Euclidean norm.
- [Linear functions](linear-functions.md) -- the residual $Ax - b$ is an affine function of $x$; the solution is linear in $b$.

## Misconceptions & learner traps

- **The solution does not solve $Ax = b$** -- The least squares approximate solution $\hat{x}$ generally does *not* satisfy $A\hat{x} = b$. It minimizes $\lVert Ax - b \rVert^2$, which is the best you can do when the system has more equations than unknowns. Only when $b$ happens to lie in the column space of $A$ does $\hat{x}$ exactly solve $Ax = b$. [@boyd2018appliedlinearalgebra, p. 226]
- **Pseudo-inverse vs. inverse** -- The formula $\hat{x} = A^\dagger b$ looks like $x = A^{-1}b$ for square systems, but $A^\dagger$ is the pseudo-inverse $(A^\top A)^{-1}A^\top$, which is a left inverse of $A$ (not a two-sided inverse). When $A$ is square and invertible, $A^\dagger = A^{-1}$ and the least squares solution equals the exact solution. [@boyd2018appliedlinearalgebra, p. 229]
- **Columns must be linearly independent** -- The standard least squares formula requires $A^\top A$ to be invertible, which happens iff the columns of $A$ are linearly independent. If they are not, the problem may have infinitely many solutions (or the formula simply does not apply). [@boyd2018appliedlinearalgebra, p. 227]

## Teaching insights & analogies

- **Orthogonality as geometry** -- The orthogonality principle gives a clean geometric picture: project $b$ onto the column space of $A$; the projection is $A\hat{x}$ and the residual $\hat{r}$ is the perpendicular error. This is the same idea as dropping a perpendicular from a point to a line in 2-D geometry. [@boyd2018appliedlinearalgebra, p. 231]
- **Two paths to the same answer** -- Boyd & Vandenberghe derive the normal equations via calculus (set $\nabla f = 0$) and then give a completely independent algebraic verification that the same $\hat{x}$ is optimal. The two derivations reinforce each other and give learners who are less comfortable with multivariable calculus a second route to the result. [@boyd2018appliedlinearalgebra, pp. 228--230]
- **Regression as least squares** -- The term "regression" (used in statistics) is just another name for the least squares problem applied to data fitting. Saying $\hat{x}$ "regresses $b$ onto the columns of $A$" means finding the best linear combination of the columns to approximate $b$. [@boyd2018appliedlinearalgebra, p. 226]

## How the field talks about it

"Least squares" without qualification means the linear (not nonlinear) version: minimize $\lVert Ax - b \rVert^2$ with $r = Ax - b$ affine in $x$. The solution $\hat{x} = (A^\top A)^{-1}A^\top b$ is universally written this way in applied math and engineering; statistics texts more often write the design matrix as $X$, the response as $y$, and the solution as $\hat{\beta} = (X^\top X)^{-1}X^\top y$. The QR factorization route (Algorithm 12.1) is preferred in numerical computation because forming $A^\top A$ explicitly can lose precision. [@boyd2018appliedlinearalgebra, pp. 225, 229, 231--232]
