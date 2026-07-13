---
title: "Vectors and operations"
topic: linear-algebra
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

A vector is an ordered finite list of numbers, used throughout applied mathematics and data science to represent data (time series, images, word counts, feature vectors, portfolios) and geometric quantities (positions, displacements, velocities). [@boyd2018appliedlinearalgebra, §1.1]

**Also known as:** array, tuple (in informal usage); $n$-vector (when the size is $n$)

## Definition(s)

A *vector* is an ordered finite list of numbers. The individual numbers are called the *elements* (also *entries*, *coefficients*, or *components*). The *size* (also *dimension* or *length*) of a vector is the number of elements it contains. A vector of size $n$ is called an $n$-vector. The set of all real $n$-vectors is denoted $\mathbf{R}^n$. [@boyd2018appliedlinearalgebra, pp. 3--4]

Two vectors $a$ and $b$ are *equal* ($a = b$) if they have the same size and each corresponding entry is the same. [@boyd2018appliedlinearalgebra, p. 3]

A 1-vector is considered the same as a scalar (number). [@boyd2018appliedlinearalgebra, p. 3]

**Vector addition.** Two vectors of the same size can be added element-wise to produce another vector of the same size, called the *sum*. Vector subtraction is defined similarly; the result is called the *difference*. [@boyd2018appliedlinearalgebra, p. 11]

**Scalar-vector multiplication.** A vector multiplied by a scalar (number) produces a new vector whose every element is the original element multiplied by that scalar. [@boyd2018appliedlinearalgebra, p. 15]

**Linear combination.** If $a_1, \ldots, a_m$ are $n$-vectors and $\beta_1, \ldots, \beta_m$ are scalars, the $n$-vector $\beta_1 a_1 + \cdots + \beta_m a_m$ is a *linear combination* of the vectors; the scalars are the *coefficients*. Any $n$-vector $b$ can be written as a linear combination of the standard unit vectors: $b = b_1 e_1 + \cdots + b_n e_n$. [@boyd2018appliedlinearalgebra, p. 17]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $a$ | "a" | A vector (lowercase italic letter). Boyd & Vandenberghe use plain lowercase; other authors use boldface **a** or $\vec{a}$. [@boyd2018appliedlinearalgebra, p. 4] |
| $a_i$ | "a sub i" | The $i$th element of vector $a$ (1-indexed in mathematical convention, 0-indexed in many programming languages). [@boyd2018appliedlinearalgebra, p. 5] |
| $\mathbf{R}^n$ | "R n" | The set of all real $n$-vectors. [@boyd2018appliedlinearalgebra, p. 4] |
| $0$ or $0_n$ | "zero vector" | The vector of size $n$ with all entries equal to zero. The symbol $0$ is *overloaded*: context determines whether it means the scalar zero or a zero vector (and of what size). [@boyd2018appliedlinearalgebra, p. 5] |
| $e_i$ | "e sub i" | The $i$th standard unit vector: all zeros except a 1 in position $i$. [@boyd2018appliedlinearalgebra, p. 5] |
| $\mathbf{1}$ or $\mathbf{1}_n$ | "ones vector" | The $n$-vector with all entries equal to one. [@boyd2018appliedlinearalgebra, p. 6] |
| $a_{r:s}$ | "a r to s" | Subvector (slice) notation: entries $a_r, \ldots, a_s$. [@boyd2018appliedlinearalgebra, p. 4] |
| $\mathrm{nnz}(x)$ | "number of nonzeros of x" | The count of nonzero entries in vector $x$; measures *sparsity*. [@boyd2018appliedlinearalgebra, p. 6] |

## Key results & derivations

- **Properties of vector addition** -- Commutative ($a + b = b + a$), associative ($(a + b) + c = a + (b + c)$), additive identity ($a + 0 = a$), additive inverse ($a - a = 0$). All follow from the element-wise definition and the corresponding properties of real numbers. [@boyd2018appliedlinearalgebra, p. 11]
- **Properties of scalar-vector multiplication** -- Commutative ($\alpha a = a \alpha$), associative ($(\beta\gamma)a = \beta(\gamma a)$), left-distributive over scalar addition ($(\beta + \gamma)a = \beta a + \gamma a$), right-distributive over vector addition ($\beta(a + b) = \beta a + \beta b$). [@boyd2018appliedlinearalgebra, pp. 15--16]
- **Any vector is a linear combination of unit vectors** -- $b = b_1 e_1 + \cdots + b_n e_n$ (equation 1.1). The coefficients are the entries of $b$ itself. [@boyd2018appliedlinearalgebra, p. 17]

## Prerequisites

(This is a foundational concept with no KB prerequisites.)

## Misconceptions & learner traps

- **Indexing starts at 1 in math, 0 in code** -- Standard mathematical notation indexes $n$-vectors from $i = 1$ to $i = n$. Many programming languages index from 0 to $n - 1$. Confusing the two is a common source of off-by-one errors. [@boyd2018appliedlinearalgebra, p. 5]
- **Overloaded symbols** -- The symbol $0$ can mean the scalar zero or a zero vector of any size; the symbol $+$ can mean scalar addition or vector addition. Context resolves the ambiguity, but beginners may not notice the switch. [@boyd2018appliedlinearalgebra, pp. 5, 11]
- **$a_i$ is ambiguous** -- It can mean the $i$th element of vector $a$ or the $i$th vector in a collection $a_1, \ldots, a_k$. When both usages coexist, use $(a_i)_j$ for the $j$th element of the $i$th vector. [@boyd2018appliedlinearalgebra, p. 5]
- **Vector addition in programming vs. math** -- Some languages define vector + scalar as adding the scalar to each element; others use + for concatenation. Neither is standard mathematical vector addition. [@boyd2018appliedlinearalgebra, p. 14]

## Teaching insights & analogies

- **Vectors as data containers** -- Boyd & Vandenberghe introduce vectors through concrete examples before any formalism: location/displacement in 2-D or 3-D, RGB color values, time series, portfolios, word count vectors, images flattened to pixel vectors, feature vectors for patients. This grounds the abstract definition. [@boyd2018appliedlinearalgebra, pp. 6--10]
- **Displacement analogy for addition** -- When two vectors represent displacements, $a + b$ is the net displacement from applying $a$ then $b$; commutativity means the order does not matter. [@boyd2018appliedlinearalgebra, p. 12]
- **Scalar multiplication as scaling** -- When a vector represents a displacement, $\beta a$ with $\beta > 0$ is the same direction with scaled magnitude; $\beta < 0$ reverses direction. [@boyd2018appliedlinearalgebra, p. 16]
- **Special linear combinations have names** -- Sum (all coefficients 1), average (all coefficients $1/m$), affine combination (coefficients sum to 1), convex combination (affine with nonneg. coefficients, i.e. a weighted average). Knowing these names helps when reading papers. [@boyd2018appliedlinearalgebra, p. 17]

## How the field talks about it

The term "vector" in applied linear algebra always means an ordered list of real numbers (unless specified otherwise as complex). Vectors are written as column arrays by convention; the parenthesized comma notation $(a_1, a_2, \ldots)$ is informal shorthand. When dimension matters, one says "$n$-vector" or "a vector in $\mathbf{R}^n$". Notational conventions vary across authors: plain lowercase ($a$), boldface ($\mathbf{a}$), or arrow notation ($\vec{a}$); readers must infer from context. [@boyd2018appliedlinearalgebra, p. 4]
