---
title: "Inner product (dot product)"
topic: linear-algebra
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

The inner product (also called dot product) of two $n$-vectors $a$ and $b$ is the scalar $a^\top b = a_1 b_1 + a_2 b_2 + \cdots + a_n b_n$, the sum of the products of corresponding entries. [@boyd2018appliedlinearalgebra, §1.4]

**Also known as:** dot product, scalar product

## Definition(s)

The *inner product* (or *dot product*) of two $n$-vectors $a$ and $b$ is the scalar defined by $a^\top b = a_1 b_1 + a_2 b_2 + \cdots + a_n b_n$. The result is a single number (scalar), not a vector. The inner product is only defined when both vectors have the same size. [@boyd2018appliedlinearalgebra, p. 19]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $a^\top b$ | "a transpose b" | The inner product of vectors $a$ and $b$. This is the notation used by Boyd & Vandenberghe, emphasizing the connection to matrix transpose. [@boyd2018appliedlinearalgebra, p. 19] |
| $\langle a, b \rangle$ | "inner product of a and b" | Angle-bracket notation for the inner product, used by some authors (not Boyd & Vandenberghe). [@boyd2018appliedlinearalgebra, p. 19] |
| $a \cdot b$ | "a dot b" | Dot-product notation, common in physics and some math texts. [@boyd2018appliedlinearalgebra, p. 19] |
| $a' b$ | "a prime b" | An abbreviated transpose notation sometimes used in statistics. *(synthesis)* |

## Key results & derivations

- **Properties of the inner product** -- Commutative: $a^\top b = b^\top a$. Associativity with scalar multiplication: $(\gamma a)^\top b = \gamma(a^\top b)$. Distributive over vector addition: $(a + b)^\top c = a^\top c + b^\top c$. [@boyd2018appliedlinearalgebra, p. 19]
- **Inner product with unit vectors** -- $e_i^\top a = a_i$; the inner product extracts the $i$th entry of a vector. [@boyd2018appliedlinearalgebra, p. 20]
- **Sum and average via inner product** -- The sum of entries of a vector $a$ is $\mathbf{1}^\top a$. The average (mean) of the entries is $\mathbf{1}^\top a / n = (\mathbf{1}/n)^\top a$. [@boyd2018appliedlinearalgebra, p. 20]
- **Inner product of block vectors** -- If $a$ and $b$ are block (stacked) vectors with matching blocks, then $a^\top b$ is the sum of the inner products of the corresponding blocks. [@boyd2018appliedlinearalgebra, p. 20]
- **Flop count** -- Computing the inner product of two $n$-vectors requires $n$ multiplications and $n - 1$ additions, totaling $2n - 1$ flops (or approximately $2n$ for large $n$). [@boyd2018appliedlinearalgebra, p. 22]

## Prerequisites

- [Vectors and operations](vectors-and-operations.md) -- inner product builds on vector definition, addition, and scalar multiplication.

## Misconceptions & learner traps

- **The result is a scalar, not a vector** -- Beginners sometimes expect the inner product to produce another vector (element-wise product, or Hadamard product, is a different operation). The inner product always produces a single number. [@boyd2018appliedlinearalgebra, p. 19]

## Teaching insights & analogies

- **Inner product as weighted sum** -- The inner product $a^\top b$ can be interpreted as a weighted sum of the entries of $b$, with weights given by the entries of $a$ (or vice versa). This interpretation appears in return calculation, net present value, and price-quantity cost computation. [@boyd2018appliedlinearalgebra, pp. 20--21]
- **Portfolio return example** -- If $w$ is a weight vector (fractions of total investment in each asset) and $r$ is the vector of asset returns, then $w^\top r$ is the total portfolio return. [@boyd2018appliedlinearalgebra, p. 21]
- **Document similarity** -- The inner product of two word-count (or histogram) vectors gives a rough measure of document similarity: $a^\top b$ is large when the documents use many of the same words. This is less commonly used than the related cosine similarity (which normalizes by the norms). [@boyd2018appliedlinearalgebra, p. 21]

## How the field talks about it

The notation $a^\top b$ is standard in applied linear algebra and optimization; the transpose superscript $\top$ (or prime $'$) emphasizes that the inner product is a special case of matrix multiplication (a $1 \times n$ row vector times an $n \times 1$ column vector). The dot notation $a \cdot b$ is more common in physics. The angle-bracket notation $\langle a, b \rangle$ is used in functional analysis and abstract settings. All three mean the same operation for real vectors. [@boyd2018appliedlinearalgebra, p. 19]
