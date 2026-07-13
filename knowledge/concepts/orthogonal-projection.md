---
title: "Orthogonal projection"
topic: linear-algebra
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

The orthogonal projection of a vector $\mathbf{b}$ onto a subspace $W$ is the vector $\widehat{\mathbf{b}}$ in $W$ that is closest to $\mathbf{b}$, characterized by the property that $\mathbf{b} - \widehat{\mathbf{b}}$ is orthogonal to $W$. Orthogonal projection is the geometric idea that makes least-squares regression work: when $A\mathbf{x} = \mathbf{b}$ has no solution, the best approximate solution comes from projecting $\mathbf{b}$ onto $\text{Col}(A)$. [@austin2022understandinglinearalgebra, pp. 372, 397]

**Also known as:** projection onto a subspace; closest vector in $W$

## Definition(s)

Given a vector $\mathbf{b}$ in $\mathbb{R}^m$ and a subspace $W$ of $\mathbb{R}^m$, the **orthogonal projection** of $\mathbf{b}$ onto $W$ is the vector $\widehat{\mathbf{b}}$ in $W$ that is closest to $\mathbf{b}$. It is characterized by the property that $\mathbf{b} - \widehat{\mathbf{b}}$ is orthogonal to $W$. [@austin2022understandinglinearalgebra, p. 372]

The **least-squares approximate solution** $\widehat{\mathbf{x}}$ to an inconsistent system $A\mathbf{x} = \mathbf{b}$ is the vector that minimizes $\lvert\mathbf{b} - A\mathbf{x}\rvert^2$. It satisfies $A\widehat{\mathbf{x}} = \widehat{\mathbf{b}}$, where $\widehat{\mathbf{b}}$ is the orthogonal projection of $\mathbf{b}$ onto $\text{Col}(A)$. [@austin2022understandinglinearalgebra, pp. 397--398]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $\widehat{\mathbf{b}}$ | "b hat" | The orthogonal projection of $\mathbf{b}$ onto a subspace $W$; the vector in $W$ closest to $\mathbf{b}$. [@austin2022understandinglinearalgebra, p. 372] |
| $\mathbf{b}^\perp$ | "b perp" | The component $\mathbf{b} - \widehat{\mathbf{b}}$, which lies in $W^\perp$. Together, $\mathbf{b} = \widehat{\mathbf{b}} + \mathbf{b}^\perp$. [@austin2022understandinglinearalgebra, p. 377] |
| $A^TA\widehat{\mathbf{x}} = A^T\mathbf{b}$ | "the normal equation" | The equation whose solution gives the least-squares approximate solution. [@austin2022understandinglinearalgebra, p. 398] |
| $R^2$ | "R squared" | The coefficient of determination: $R^2 = 1 - \lvert\mathbf{b} - A\widehat{\mathbf{x}}\rvert^2 / \lvert\widetilde{\mathbf{b}}\rvert^2$, where $\widetilde{\mathbf{b}}$ is demeaned $\mathbf{b}$. [@austin2022understandinglinearalgebra, p. 400] |

## Key results & derivations

- **Projection formula (orthogonal basis).** If $W$ has orthogonal basis $\mathbf{w}_1, \ldots, \mathbf{w}_n$, then $\widehat{\mathbf{b}} = \frac{\mathbf{b} \cdot \mathbf{w}_1}{\mathbf{w}_1 \cdot \mathbf{w}_1}\,\mathbf{w}_1 + \cdots + \frac{\mathbf{b} \cdot \mathbf{w}_n}{\mathbf{w}_n \cdot \mathbf{w}_n}\,\mathbf{w}_n$. [@austin2022understandinglinearalgebra, p. 374]
- **Projection matrix (orthonormal basis).** If $Q = [\mathbf{u}_1 \; \cdots \; \mathbf{u}_n]$ has orthonormal columns forming a basis for $W$, then the matrix $P = QQ^T$ projects vectors orthogonally onto $W$: $\widehat{\mathbf{b}} = QQ^T\mathbf{b}$. [@austin2022understandinglinearalgebra, pp. 375--376]
- **Orthogonal decomposition.** Every vector $\mathbf{b}$ in $\mathbb{R}^m$ can be uniquely written as $\mathbf{b} = \widehat{\mathbf{b}} + \mathbf{b}^\perp$, where $\widehat{\mathbf{b}}$ is in $W$ and $\mathbf{b}^\perp$ is in $W^\perp$. [@austin2022understandinglinearalgebra, p. 377]
- **Pythagorean theorem.** Since $\widehat{\mathbf{b}}$ and $\mathbf{b}^\perp$ are orthogonal, $\lvert\mathbf{b}\rvert^2 = \lvert\widehat{\mathbf{b}}\rvert^2 + \lvert\mathbf{b}^\perp\rvert^2$, confirming that $\widehat{\mathbf{b}}$ is the closest vector in $W$ to $\mathbf{b}$. [@austin2022understandinglinearalgebra, pp. 371--372]
- **Normal equation.** If the columns of $A$ are linearly independent, the unique least-squares approximate solution $\widehat{\mathbf{x}}$ satisfies $A^TA\widehat{\mathbf{x}} = A^T\mathbf{b}$. This follows from $\widehat{\mathbf{b}} - \mathbf{b}$ being in $\text{Nul}(A^T) = \text{Col}(A)^\perp$, so $A^T(A\widehat{\mathbf{x}} - \mathbf{b}) = \mathbf{0}$. [@austin2022understandinglinearalgebra, pp. 397--398]
- **Gram-Schmidt orthogonalization.** Given any basis $\mathbf{v}_1, \ldots, \mathbf{v}_n$ for $W$, the Gram-Schmidt algorithm constructs an orthogonal basis $\mathbf{w}_1, \ldots, \mathbf{w}_n$ by iteratively subtracting the projection onto the previously constructed vectors: $\mathbf{w}_k = \mathbf{v}_k - \sum_{j=1}^{k-1} \frac{\mathbf{v}_k \cdot \mathbf{w}_j}{\mathbf{w}_j \cdot \mathbf{w}_j}\,\mathbf{w}_j$. [@austin2022understandinglinearalgebra, pp. 386--387]
- **QR factorization.** If $A$ is $m \times n$ with linearly independent columns, then $A = QR$ where $Q$ is $m \times n$ with orthonormal columns forming a basis for $\text{Col}(A)$ and $R$ is $n \times n$ upper triangular. This comes directly from expressing the Gram-Schmidt process in matrix form. [@austin2022understandinglinearalgebra, p. 389]
- **Least squares via QR.** Given $A = QR$, the least-squares solution is $\widehat{\mathbf{x}} = R^{-1}Q^T\mathbf{b}$. This is numerically more stable than solving the normal equations directly. [@austin2022understandinglinearalgebra, p. 403]
- **$R^2$ as fraction of variance explained.** The coefficient of determination satisfies $R^2 = \text{Var}(\widehat{\mathbf{b}})/\text{Var}(\mathbf{b}) = \text{Var}(A\widehat{\mathbf{x}})/\text{Var}(\mathbf{b})$, where variance is computed over the components of the vector. [@austin2022understandinglinearalgebra, pp. 412--413]
- **$A^TA$ is invertible when columns are independent.** If $A$ has linearly independent columns, then $A^TA\mathbf{x} = \mathbf{0}$ implies $\lvert A\mathbf{x}\rvert^2 = \mathbf{x} \cdot A^TA\mathbf{x} = 0$, so $A\mathbf{x} = \mathbf{0}$, so $\mathbf{x} = \mathbf{0}$ by independence. Therefore $A^TA$ is invertible and the normal equation has a unique solution. [@austin2022understandinglinearalgebra, pp. 411--412]

## Prerequisites

- [orthogonality-and-inner-products](orthogonality-and-inner-products.md) -- the projection formula uses dot products, orthogonality, and the transpose.
- [linear-independence](linear-independence.md) -- the normal equation has a unique solution only when the columns of $A$ are linearly independent.

## Misconceptions & learner traps

- **"The projection formula works with any basis."** The formula $\widehat{\mathbf{b}} = \sum (\mathbf{b} \cdot \mathbf{w}_i / \mathbf{w}_i \cdot \mathbf{w}_i)\,\mathbf{w}_i$ requires the basis to be orthogonal. With a non-orthogonal basis, you must either orthogonalize first (Gram-Schmidt) or solve the normal equations. [@austin2022understandinglinearalgebra, p. 374]
- **Confusing "approximate solution" with "approximate answer."** The least-squares $\widehat{\mathbf{x}}$ is the exact solution to the normal equations $A^TA\widehat{\mathbf{x}} = A^T\mathbf{b}$ -- there is nothing approximate about the computation. It is called "approximate" because $A\widehat{\mathbf{x}} \neq \mathbf{b}$ in general; rather, $A\widehat{\mathbf{x}} = \widehat{\mathbf{b}}$ is the closest vector in $\text{Col}(A)$ to $\mathbf{b}$. [@austin2022understandinglinearalgebra, pp. 397--398]
- **Overfitting with polynomial regression.** Fitting a degree-$k$ polynomial always increases $R^2$, but when $k$ is too large, the polynomial captures noise rather than signal. A perfect fit ($R^2 = 1$) is possible with enough terms but produces unreliable predictions. [@austin2022understandinglinearalgebra, pp. 405--406]

## Teaching insights & analogies

- **Projection as "drop the perpendicular."** The orthogonal projection onto a line in $\mathbb{R}^2$ is the foot of the perpendicular from $\mathbf{b}$ to the line. The textbook builds from this concrete 2D picture to the general subspace formula, always using the same geometric idea: the closest point is found by going straight "down" (perpendicular to $W$). [@austin2022understandinglinearalgebra, pp. 371--372]
- **Least squares = inconsistent system + projection.** The textbook frames least squares entirely through the projection lens: if $A\mathbf{x} = \mathbf{b}$ is inconsistent, replace $\mathbf{b}$ by its projection $\widehat{\mathbf{b}}$ onto $\text{Col}(A)$, then solve the consistent system $A\widehat{\mathbf{x}} = \widehat{\mathbf{b}}$. This makes the normal equations a consequence of geometry rather than a formula to memorize. [@austin2022understandinglinearalgebra, pp. 397--398]
- **Residuals as vertical distances.** In the line-fitting context, the residual $y_i - (b + mx_i)$ is the vertical distance from data point $(x_i, y_i)$ to the fitted line. The sum of squared residuals $\lvert\mathbf{b} - A\mathbf{x}\rvert^2$ ties the geometric (projection) and statistical (regression) views together. [@austin2022understandinglinearalgebra, p. 397]
- **QR is the computational workhorse.** The normal equations $A^TA\widehat{\mathbf{x}} = A^T\mathbf{b}$ are conceptually clean but numerically fragile (forming $A^TA$ can amplify rounding errors). The QR approach $\widehat{\mathbf{x}} = R^{-1}Q^T\mathbf{b}$ avoids this problem and is what software actually uses. [@austin2022understandinglinearalgebra, pp. 401, 403]

## How the field talks about it

When a statistics paper writes "OLS" (ordinary least squares) or "the least-squares estimate $\hat{\beta}$," it means the solution to the normal equations $X^TX\hat{\beta} = X^T\mathbf{y}$ with design matrix $X$ and response $\mathbf{y}$. The projection matrix $H = X(X^TX)^{-1}X^T$ is called the "hat matrix" because it puts the hat on $\mathbf{y}$: $\hat{\mathbf{y}} = H\mathbf{y}$. The residual vector $\mathbf{e} = \mathbf{y} - \hat{\mathbf{y}}$ lies in $\text{Col}(X)^\perp$ by construction. [@austin2022understandinglinearalgebra, pp. 398, 403]
