---
title: "Span of a set of vectors"
topic: linear-algebra
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

The span of a set of vectors is the set of all linear combinations that can be formed from those vectors. [@austin2022understandinglinearalgebra, §2.3]

## Definition(s)

The **span** of a set of vectors $\mathbf{v}_1, \mathbf{v}_2, \ldots, \mathbf{v}_n$ is the set of all linear combinations of those vectors -- that is, every vector $\mathbf{b}$ that can be written as $c_1\mathbf{v}_1 + c_2\mathbf{v}_2 + \cdots + c_n\mathbf{v}_n$ for some choice of scalar weights $c_1, c_2, \ldots, c_n$. [@austin2022understandinglinearalgebra, p. 81]

Equivalently, if $A = [\mathbf{v}_1 \; \mathbf{v}_2 \; \cdots \; \mathbf{v}_n]$, then the span consists of all vectors $\mathbf{b}$ for which the equation $A\mathbf{x} = \mathbf{b}$ is consistent. [@austin2022understandinglinearalgebra, p. 81]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $\text{Span}\{\mathbf{v}_1, \mathbf{v}_2, \ldots, \mathbf{v}_n\}$ | "the span of v-one through v-n" | The set of all linear combinations of the listed vectors. [@austin2022understandinglinearalgebra, p. 86] |

Terminology note: span is a property of a *set of vectors*, not of a matrix. Saying "the span of the matrix $A$" is informal shorthand for "the span of the columns of $A$." [@austin2022understandinglinearalgebra, p. 91]

## Key results & derivations

- **Span and pivot positions.** The span of a set of vectors equals all of $\mathbb{R}^m$ if and only if the matrix $[\mathbf{v}_1 \; \mathbf{v}_2 \; \cdots \; \mathbf{v}_n]$ has a pivot position in every row. [@austin2022understandinglinearalgebra, p. 90]
- **Minimum number of vectors to span $\mathbb{R}^m$.** Any set of vectors whose span is $\mathbb{R}^m$ must contain at least $m$ vectors. [@austin2022understandinglinearalgebra, p. 91]
- **Geometric classification in $\mathbb{R}^3$.** The span of a set of vectors in $\mathbb{R}^3$ is one of: (1) a line through the origin (one pivot position), (2) a plane through the origin (two pivot positions), or (3) all of $\mathbb{R}^3$ (three pivot positions). [@austin2022understandinglinearalgebra, pp. 89--90]
- **Redundant vectors do not enlarge the span.** If one vector in a set is a linear combination of the others, removing it does not change the span. For example, if $\mathbf{w} = -2\mathbf{v}$, then $\text{Span}\{\mathbf{v}, \mathbf{w}\}$ is the line defined by $\mathbf{v}$, not a plane. [@austin2022understandinglinearalgebra, pp. 85--86]

## Prerequisites

- [linear-combinations-and-data-matrices](../../foundations/linear-combinations-and-data-matrices/lesson.qmd) -- span is defined as the set of all linear combinations.
- [matrices-and-linear-transforms](../../foundations/matrices-and-linear-transforms/lesson.qmd) -- the pivot-position characterization requires row reduction of the matrix whose columns are the vectors.

## Misconceptions & learner traps

- **Confusing span with "the vectors themselves."** The span is not the set of vectors $\{\mathbf{v}_1, \ldots, \mathbf{v}_n\}$; it is the (typically infinite) set of all their linear combinations. Two vectors in $\mathbb{R}^2$ that are not collinear span the entire plane, not just two points. [@austin2022understandinglinearalgebra, pp. 84--85]
- **Assuming more vectors always means a bigger span.** Adding a vector that is already a linear combination of the others does not enlarge the span. [@austin2022understandinglinearalgebra, pp. 85--86]

## Teaching insights & analogies

- **Walking analogy.** A linear combination of two vectors is like a recipe for walking: move a prescribed distance in the direction of $\mathbf{v}$, then a prescribed distance in the direction of $\mathbf{w}$. The span is the set of all places you can reach. If $\mathbf{v}$ and $\mathbf{w}$ point in independent directions, you can reach any point in the plane; if they point along the same line, you are stuck on that line. [@austin2022understandinglinearalgebra, p. 84]
- **Pivot positions as a span diagnostic.** Rather than checking individual vectors $\mathbf{b}$ for membership, form the matrix of the vectors and count pivot positions in rows: pivots in every row means the span is all of $\mathbb{R}^m$. [@austin2022understandinglinearalgebra, p. 90]
