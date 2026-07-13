---
title: "Orthogonality and inner products"
topic: linear-algebra
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

The dot product (inner product) of two vectors is a scalar that encodes geometric information: the length of a vector and the angle between two vectors. Two vectors are orthogonal when their dot product is zero. [@austin2022understandinglinearalgebra, p. 339]

**Also known as:** inner product, scalar product; perpendicular (synonym for orthogonal in geometric contexts)

## Definition(s)

The **dot product** of two $m$-dimensional vectors $\mathbf{v}$ and $\mathbf{w}$ is the scalar $\mathbf{v} \cdot \mathbf{w} = v_1 w_1 + v_2 w_2 + \cdots + v_m w_m$. [@austin2022understandinglinearalgebra, p. 337]

Two vectors $\mathbf{v}$ and $\mathbf{w}$ are **orthogonal** if $\mathbf{v} \cdot \mathbf{w} = 0$. [@austin2022understandinglinearalgebra, p. 341]

The **orthogonal complement** of a subspace $W$ of $\mathbb{R}^m$ is the set $W^\perp$ of all vectors in $\mathbb{R}^m$ that are orthogonal to every vector in $W$. [@austin2022understandinglinearalgebra, p. 356]

An **orthogonal set** of vectors is a set of nonzero vectors each of which is orthogonal to the others. [@austin2022understandinglinearalgebra, p. 368]

An **orthonormal set** is an orthogonal set in which every vector has unit length. [@austin2022understandinglinearalgebra, p. 370]

An **orthogonal matrix** $Q$ is a square matrix whose columns form an orthonormal basis; it satisfies $Q^{-1} = Q^T$. [@austin2022understandinglinearalgebra, p. 378]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $\mathbf{v} \cdot \mathbf{w}$ | "v dot w" | The dot product (scalar): $v_1 w_1 + \cdots + v_m w_m$. [@austin2022understandinglinearalgebra, p. 337] |
| $\|\mathbf{v}\|$ or $\lvert\mathbf{v}\rvert$ | "the length of v" or "the norm of v" | $\sqrt{\mathbf{v} \cdot \mathbf{v}}$, the Euclidean length. [@austin2022understandinglinearalgebra, p. 338] |
| $W^\perp$ | "W perp" | The orthogonal complement of $W$. [@austin2022understandinglinearalgebra, p. 356] |
| $Q^T Q = I$ | "Q transpose Q equals I" | Defining property of a matrix with orthonormal columns. [@austin2022understandinglinearalgebra, p. 370] |

## Key results & derivations

- **Length from the dot product.** $\mathbf{v} \cdot \mathbf{v} = \lvert\mathbf{v}\rvert^2$, so the length is $\lvert\mathbf{v}\rvert = \sqrt{\mathbf{v} \cdot \mathbf{v}}$. This is the Pythagorean theorem generalized to $m$ dimensions. [@austin2022understandinglinearalgebra, p. 338]
- **Angle formula.** $\mathbf{v} \cdot \mathbf{w} = \lvert\mathbf{v}\rvert\,\lvert\mathbf{w}\rvert \cos\theta$, where $\theta$ is the angle between the vectors. Derived by applying the Law of Cosines to the triangle formed by $\mathbf{v}$, $\mathbf{w}$, and $\mathbf{w} - \mathbf{v}$. [@austin2022understandinglinearalgebra, p. 339]
- **Algebraic properties.** The dot product is commutative ($\mathbf{v} \cdot \mathbf{w} = \mathbf{w} \cdot \mathbf{v}$), distributes over addition, and respects scalar multiplication ($(s\mathbf{v}) \cdot \mathbf{w} = s(\mathbf{v} \cdot \mathbf{w})$). [@austin2022understandinglinearalgebra, p. 337]
- **Transpose encodes dot products.** If $A$ has columns $\mathbf{v}_1, \ldots, \mathbf{v}_n$, then $A^T\mathbf{x}$ is the vector whose $i$th component is $\mathbf{v}_i \cdot \mathbf{x}$. [@austin2022understandinglinearalgebra, p. 359]
- **Orthogonal complement via null space.** For any matrix $A$, $\text{Col}(A)^\perp = \text{Nul}(A^T)$. [@austin2022understandinglinearalgebra, p. 360]
- **Dimension complement.** If $W$ is a subspace of $\mathbb{R}^m$, then $\dim W + \dim W^\perp = m$. [@austin2022understandinglinearalgebra, p. 362]
- **Orthogonal sets are linearly independent.** [@austin2022understandinglinearalgebra, p. 369]
- **Weight formula for orthogonal bases.** If $\mathbf{b} = c_1\mathbf{w}_1 + \cdots + c_n\mathbf{w}_n$ and the $\mathbf{w}_i$ are orthogonal, then $c_i = \mathbf{b} \cdot \mathbf{w}_i / (\mathbf{w}_i \cdot \mathbf{w}_i)$. [@austin2022understandinglinearalgebra, p. 369]
- **Orthonormal columns give $Q^TQ = I$.** If $Q = [\mathbf{u}_1 \; \cdots \; \mathbf{u}_n]$ has orthonormal columns, then $Q^TQ = I_n$. If additionally $Q$ is square ($m = n$), then $QQ^T = I$ as well and $Q^{-1} = Q^T$. [@austin2022understandinglinearalgebra, pp. 370, 378]
- **Orthogonal matrices preserve lengths.** If $Q$ is orthogonal, then $\lvert Q\mathbf{x}\rvert = \lvert\mathbf{x}\rvert$ for all $\mathbf{x}$. [@austin2022understandinglinearalgebra, p. 381]
- **Transpose properties.** $(A + B)^T = A^T + B^T$; $(AB)^T = B^T A^T$; $(A^T)^T = A$; $\det(C) = \det(C^T)$; $\text{rank}(A) = \text{rank}(A^T)$. [@austin2022understandinglinearalgebra, p. 362]
- **Correlation as cosine.** The correlation between two time series equals the cosine of the angle between their demeaned vectors, so correlation lies in $[-1, 1]$. [@austin2022understandinglinearalgebra, p. 343]

## Prerequisites

- [linear-independence](linear-independence.md) -- orthogonal sets are automatically linearly independent; the concept of basis requires independence.
- [matrices-and-linear-transforms](../../foundations/matrices-and-linear-transforms/lesson.qmd) -- the transpose, null space, column space, and rank require understanding matrix operations and row reduction.

## Misconceptions & learner traps

- **"Orthogonal means perpendicular."** For two nonzero vectors in 2D or 3D this is true, but orthogonality is defined more generally: $\mathbf{v} \cdot \mathbf{w} = 0$, and this allows one or both vectors to be the zero vector. The zero vector is orthogonal to everything. [@austin2022understandinglinearalgebra, p. 341]
- **Confusing "orthogonal set" with "orthogonal matrix."** An orthogonal set means pairwise-orthogonal nonzero vectors. An orthogonal matrix means a square matrix whose columns are orthonormal (orthogonal AND unit length). The terminology is unfortunately inconsistent. [@austin2022understandinglinearalgebra, p. 378]
- **Assuming $Q^TQ = I$ implies $QQ^T = I$.** This is true only when $Q$ is square. A non-square $Q$ with orthonormal columns satisfies $Q^TQ = I_n$ but $QQ^T \neq I_m$ unless $m = n$. [@austin2022understandinglinearalgebra, p. 377]

## Teaching insights & analogies

- **Dot product as similarity measure.** The textbook motivates the dot product through vector similarity: vectors pointing in similar directions have a large positive dot product, perpendicular vectors have dot product zero, and opposite-pointing vectors have a large negative dot product. This leads naturally to correlation as the cosine of the angle between demeaned vectors. [@austin2022understandinglinearalgebra, pp. 341, 343]
- **k-means clustering from dot products.** The distance $\lvert\mathbf{v} - \mathbf{w}\rvert$ between data points (computed from dot products) leads directly to the k-means clustering algorithm: repeatedly assign points to their nearest centroid and recompute centroids. [@austin2022understandinglinearalgebra, pp. 344--350]
- **$2 \times 2$ orthogonal matrices are rotations or reflections.** Every $2 \times 2$ orthogonal matrix is either a rotation $\begin{bmatrix} \cos\theta & -\sin\theta \\ \sin\theta & \cos\theta \end{bmatrix}$ or a reflection $\begin{bmatrix} \cos\theta & \sin\theta \\ \sin\theta & -\cos\theta \end{bmatrix}$. This gives a concrete geometric interpretation of orthogonal transformations. [@austin2022understandinglinearalgebra, pp. 381--382]

## How the field talks about it

When a paper writes "$X^TX$" without elaboration, it is computing the matrix of pairwise dot products of the columns of $X$ (the Gram matrix). The notation $\lVert\mathbf{v}\rVert$ for the Euclidean norm and $\langle \mathbf{v}, \mathbf{w} \rangle$ for the inner product are standard alternatives to $\lvert\mathbf{v}\rvert$ and $\mathbf{v} \cdot \mathbf{w}$; this textbook uses the latter. [@austin2022understandinglinearalgebra, pp. 338, 393]
