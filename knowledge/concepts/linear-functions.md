---
title: "Linear and affine functions"
topic: linear-algebra
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

A scalar-valued function $f : \mathbf{R}^n \to \mathbf{R}$ is *linear* if it satisfies the superposition property $f(\alpha x + \beta y) = \alpha f(x) + \beta f(y)$ for all vectors $x, y$ and all scalars $\alpha, \beta$. Every linear function can be written as an inner product $f(x) = a^\top x$ for a unique vector $a$. An *affine* function is a linear function plus a constant: $f(x) = a^\top x + b$. [@boyd2018appliedlinearalgebra, §2.1]

**Also known as:** linear map (to $\mathbf{R}$), linear functional; affine map, affine transformation

## Definition(s)

A function $f : \mathbf{R}^n \to \mathbf{R}$ is *linear* if the superposition property holds: $f(\alpha x + \beta y) = \alpha f(x) + \beta f(y)$ for all $n$-vectors $x, y$ and all scalars $\alpha, \beta$. Superposition extends to any number of terms: $f(\alpha_1 x_1 + \cdots + \alpha_k x_k) = \alpha_1 f(x_1) + \cdots + \alpha_k f(x_k)$. [@boyd2018appliedlinearalgebra, pp. 30--31]

Superposition can equivalently be decomposed into two separate properties: *homogeneity* ($f(\alpha x) = \alpha f(x)$) and *additivity* ($f(x + y) = f(x) + f(y)$). Together they imply the full superposition property. [@boyd2018appliedlinearalgebra, p. 31]

A function $f : \mathbf{R}^n \to \mathbf{R}$ is *affine* if it can be expressed as $f(x) = a^\top x + b$ for some $n$-vector $a$ and scalar $b$ (the *offset*). Affine functions satisfy a restricted superposition: $f(\alpha x + \beta y) = \alpha f(x) + \beta f(y)$ whenever $\alpha + \beta = 1$ (i.e., the argument is an affine combination). [@boyd2018appliedlinearalgebra, p. 32]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $f : \mathbf{R}^n \to \mathbf{R}$ | "f maps R-n to R" | A scalar-valued function of $n$-vectors. [@boyd2018appliedlinearalgebra, p. 29] |
| $f(x) = a^\top x$ | "f of x equals a transpose x" | The inner product representation of a linear function; the vector $a$ is uniquely determined. [@boyd2018appliedlinearalgebra, p. 31] |
| $f(x) = a^\top x + b$ | "f of x equals a transpose x plus b" | An affine function with weight vector $a$ and offset $b$. [@boyd2018appliedlinearalgebra, p. 32] |
| $\hat{y} = x^\top \beta + v$ | "y-hat equals x transpose beta plus v" | The regression model: $x$ is a feature vector, $\beta$ is the weight (coefficient) vector, $v$ is the offset (intercept). [@boyd2018appliedlinearalgebra, p. 38] |

## Key results & derivations

- **Inner product representation theorem** -- If $f : \mathbf{R}^n \to \mathbf{R}$ is linear, then there exists a unique $n$-vector $a$ such that $f(x) = a^\top x$ for all $x$. The entries of $a$ are $a_i = f(e_i)$, i.e., the function's values on the standard unit vectors. This means a linear function is completely determined by $n$ numbers. [@boyd2018appliedlinearalgebra, pp. 31--32]
- **Affine representation from unit vectors** -- If $f$ is affine, then $f(x) = f(0) + x_1(f(e_1) - f(0)) + \cdots + x_n(f(e_n) - f(0))$, so $a_i = f(e_i) - f(0)$ and $b = f(0)$. The affine function is determined by $n + 1$ numbers. [@boyd2018appliedlinearalgebra, p. 33]
- **Average is linear; maximum is not** -- The mean $\mathrm{avg}(x) = \mathbf{1}^\top x / n$ is a linear function (inner product with $a = \mathbf{1}/n$). The maximum $\max\{x_1, \ldots, x_n\}$ is not linear (it violates superposition for $n > 1$). [@boyd2018appliedlinearalgebra, p. 32]
- **First-order Taylor approximation** -- For a differentiable function $f : \mathbf{R}^n \to \mathbf{R}$, the first-order Taylor approximation near a point $z$ is the affine function $\hat{f}(x) = f(z) + \frac{\partial f}{\partial x_1}(z)(x_1 - z_1) + \cdots + \frac{\partial f}{\partial x_n}(z)(x_n - z_n)$. This can be written as $\hat{f}(x) = f(z) + \nabla f(z)^\top (x - z)$, where $\nabla f(z)$ is the gradient. The approximation is good when $x$ is near $z$. [@boyd2018appliedlinearalgebra, pp. 35--36]
- **Regression model as affine function** -- A regression model $\hat{y} = x^\top \beta + v$ is an affine function of the feature vector $x$. The vector $\beta$ gives the weight (regression coefficient) for each feature, and $v$ is the offset (intercept). The model predicts the outcome $\hat{y}$ from the features $x$. [@boyd2018appliedlinearalgebra, pp. 38--39]

## Prerequisites

- [Vectors and operations](vectors-and-operations.md) -- vectors, addition, scalar multiplication, and linear combinations.
- [Inner product](inner-product.md) -- the inner product is how linear functions are represented.

## Misconceptions & learner traps

- **"Linear" in math vs. common usage** -- In everyday language, $f(x) = \alpha x + \beta$ with $\beta \neq 0$ is called "a linear function" (because its graph is a line). In the strict mathematical sense used in linear algebra, this is an *affine* function; a truly linear function must pass through the origin: $f(0) = 0$. [@boyd2018appliedlinearalgebra, p. 33]
- **Superposition looks trivial but says a lot** -- The equation $f(\alpha x + \beta y) = \alpha f(x) + \beta f(y)$ looks like rearranging parentheses. But the left side uses vector operations (scalar-vector multiplication, vector addition), while the right side uses scalar operations (scalar multiplication, scalar addition). The equality constrains $f$ to be an inner product. [@boyd2018appliedlinearalgebra, p. 30]

## Teaching insights & analogies

- **Superposition as a shortcut for prediction** -- If you know a linear function's value on each unit vector ($f(e_1), \ldots, f(e_n)$), you can predict $f(x)$ for any vector $x$ without calling $f$ again: just compute $a^\top x$ with $a = (f(e_1), \ldots, f(e_n))$. This is a powerful compression: $n$ experiments determine the function's value everywhere. [@boyd2018appliedlinearalgebra, p. 32]
- **Regression model framing** -- Boyd & Vandenberghe introduce the regression model as an application of affine functions: the feature vector $x$ describes an object, and $\hat{y} = x^\top \beta + v$ is the predicted outcome. This framing makes explicit that regression is an affine function of the features, not a mysterious statistical procedure. [@boyd2018appliedlinearalgebra, pp. 38--39]

## How the field talks about it

In applied linear algebra and optimization, "linear" and "affine" are carefully distinguished: $f(x) = a^\top x$ is linear, $f(x) = a^\top x + b$ is affine. The regression community often calls $\hat{y} = x^\top \beta + v$ a "linear model" even though it is technically affine (linear in the parameters $\beta$, affine in the features $x$). The field uses "superposition" for the defining property of linearity, and "restricted superposition" for affine functions. [@boyd2018appliedlinearalgebra, pp. 30, 32]
