---
title: "Linear independence"
topic: linear-algebra
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

A set of vectors is linearly independent if no vector in the set can be written as a linear combination of the others; equivalently, the only way to combine them to get the zero vector is with all weights equal to zero. [@austin2022understandinglinearalgebra, §2.4]

**Also known as:** linear dependence (the negation); linearly dependent set (when one vector IS a linear combination of the others)

## Definition(s)

A set of vectors $\mathbf{v}_1, \mathbf{v}_2, \ldots, \mathbf{v}_n$ is **linearly dependent** if one of the vectors is a linear combination of the others. The set is **linearly independent** if no vector in the set can be written as a linear combination of the remaining vectors. [@austin2022understandinglinearalgebra, p. 98]

Equivalently, the following statements are all equivalent for $A = [\mathbf{v}_1 \; \mathbf{v}_2 \; \cdots \; \mathbf{v}_n]$: [@austin2022understandinglinearalgebra, p. 103]

- The columns of $A$ are linearly dependent.
- One of the vectors is a linear combination of the others.
- The matrix $A$ has a column without a pivot position.
- The homogeneous equation $A\mathbf{x} = \mathbf{0}$ has infinitely many solutions (and hence a nonzero solution).
- There exist weights $c_1, c_2, \ldots, c_n$, not all zero, such that $c_1\mathbf{v}_1 + c_2\mathbf{v}_2 + \cdots + c_n\mathbf{v}_n = \mathbf{0}$.

## Key results & derivations

- **Pivot-position test.** The columns of a matrix are linearly independent if and only if every column contains a pivot position. [@austin2022understandinglinearalgebra, p. 100]
- **Maximum size of an independent set.** A linearly independent set of vectors in $\mathbb{R}^m$ contains at most $m$ vectors. Since each column needs its own pivot and there are only $m$ rows (hence at most $m$ pivots), the number of columns cannot exceed $m$. [@austin2022understandinglinearalgebra, p. 101]
- **Dimension count complementarity.** A set of vectors that spans $\mathbb{R}^m$ has at least $m$ vectors (from the span proposition); a linearly independent set in $\mathbb{R}^m$ has at most $m$ vectors. A set that is both spanning and independent has exactly $m$ vectors -- this is a basis (developed in Ch 3). [@austin2022understandinglinearalgebra, pp. 91, 101]
- **Homogeneous equation test.** The columns of $A$ are linearly independent if and only if $\mathbf{x} = \mathbf{0}$ is the unique solution to $A\mathbf{x} = \mathbf{0}$. A nonzero solution directly gives weights expressing one column as a combination of the others. [@austin2022understandinglinearalgebra, pp. 102--103]
- **Redundant vectors and span.** If a set is linearly dependent, removing the dependent vector(s) does not change the span: $\text{Span}\{\mathbf{v}_1, \mathbf{v}_2, \mathbf{v}_3\} = \text{Span}\{\mathbf{v}_1, \mathbf{v}_2\}$ when $\mathbf{v}_3$ is a linear combination of $\mathbf{v}_1$ and $\mathbf{v}_2$. [@austin2022understandinglinearalgebra, p. 97]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $A\mathbf{x} = \mathbf{0}$ | "A x equals zero" | The homogeneous system whose solution space reveals dependence. A unique solution ($\mathbf{x} = \mathbf{0}$) means independent; free variables mean dependent. [@austin2022understandinglinearalgebra, p. 101] |

## Prerequisites

- [span-of-vectors](span-of-vectors.md) -- linear independence answers the complementary question to span (uniqueness vs. existence of solutions).
- [matrices-and-linear-transforms](../../foundations/matrices-and-linear-transforms/lesson.qmd) -- the pivot-position characterization requires understanding row reduction.

## Misconceptions & learner traps

- **"Linearly dependent means one vector is a scalar multiple of another."** This is only true for sets of exactly two vectors. For three or more vectors, dependence means one is a linear combination of the others, which is a broader condition than being a multiple of any single one. [@austin2022understandinglinearalgebra, pp. 97--98]
- **Confusing "more vectors than dimensions" with always dependent.** While it is true that more than $m$ vectors in $\mathbb{R}^m$ are always dependent, fewer than $m$ vectors can also be dependent -- the key is whether any column lacks a pivot. [@austin2022understandinglinearalgebra, p. 101]
- **Assuming adding a vector always makes a set dependent.** Adding a vector that lies outside the current span creates an independent set with one more vector; only adding a vector already in the span introduces dependence. [@austin2022understandinglinearalgebra, p. 98]

## Teaching insights & analogies

- **Geometric perspective.** In $\mathbb{R}^3$, two vectors are independent when they define a plane (not a line); three vectors are independent when they span all of $\mathbb{R}^3$ (not confined to a plane). A dependent vector already lies in the span of the others, so it provides no new "direction" to move. [@austin2022understandinglinearalgebra, p. 98]
- **Parallel structure with span.** The textbook develops span and linear independence as two sides of the same coin -- existence and uniqueness of solutions to $A\mathbf{x} = \mathbf{b}$. A comparison table shows the duality: span concerns pivot positions in rows; independence concerns pivot positions in columns. [@austin2022understandinglinearalgebra, p. 104]

## How the field talks about it

When a paper says "the columns of $X$ are linearly independent" without elaboration, it means $X$ has full column rank -- every column has a pivot, no column is redundant, and the system $X\mathbf{b} = \mathbf{y}$ has at most one solution for each $\mathbf{y}$. [@austin2022understandinglinearalgebra, pp. 100--101]
