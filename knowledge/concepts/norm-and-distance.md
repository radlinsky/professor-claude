---
title: "Norm, distance, and angle"
topic: linear-algebra
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

The Euclidean norm $\lVert x \rVert = \sqrt{x_1^2 + \cdots + x_n^2}$ measures the magnitude of a vector; the Euclidean distance $\mathrm{dist}(a, b) = \lVert a - b \rVert$ measures how far apart two vectors are; and the angle $\theta = \arccos(a^\top b / (\lVert a \rVert \, \lVert b \rVert))$ measures the direction between them. Together these three quantities turn the abstract space $\mathbf{R}^n$ into a geometric space where similarity, deviation, and correlation can be computed. [@boyd2018appliedlinearalgebra, ch. 3]

**Also known as:** Euclidean norm ($\ell_2$ norm, 2-norm, magnitude, length); Euclidean distance (straight-line distance); cosine of the angle (cosine similarity, when used as a similarity measure)

## Definition(s)

The *Euclidean norm* of an $n$-vector $x$ is the nonneg. scalar $\lVert x \rVert = \sqrt{x_1^2 + x_2^2 + \cdots + x_n^2} = \sqrt{x^\top x}$. When $x$ is a scalar (1-vector), the norm equals the absolute value $|x|$. [@boyd2018appliedlinearalgebra, p. 45]

The *Euclidean distance* between two $n$-vectors $a$ and $b$ is $\mathrm{dist}(a, b) = \lVert a - b \rVert$. This generalises the familiar distance in 2-D and 3-D to vectors of any dimension. The *RMS deviation* is $\lVert a - b \rVert / \sqrt{n}$, a size-normalized version of the distance. [@boyd2018appliedlinearalgebra, p. 48]

The *angle* between two nonzero $n$-vectors $a$ and $b$ is defined as $\theta = \arccos\!\bigl(a^\top b / (\lVert a \rVert \, \lVert b \rVert)\bigr)$, where $\theta \in [0, \pi]$. This is well-defined because the Cauchy--Schwarz inequality guarantees $|a^\top b| \le \lVert a \rVert \, \lVert b \rVert$, so the argument of arccos lies in $[-1, 1]$. [@boyd2018appliedlinearalgebra, p. 57]

The *standard deviation* of an $n$-vector $x$ is the RMS value of the de-meaned vector $\tilde{x} = x - \mathrm{avg}(x)\mathbf{1}$: $\mathrm{std}(x) = \sqrt{((x_1 - \mathrm{avg}(x))^2 + \cdots + (x_n - \mathrm{avg}(x))^2) / n}$. It quantifies how much the entries deviate from their mean. [@boyd2018appliedlinearalgebra, pp. 52--53]

The *correlation coefficient* of two $n$-vectors $a$ and $b$ (with non-constant entries) is $\rho = \tilde{a}^\top \tilde{b} / (\lVert \tilde{a} \rVert \, \lVert \tilde{b} \rVert)$, where $\tilde{a}$ and $\tilde{b}$ are the de-meaned versions. Equivalently, $\rho = \cos\theta$ where $\theta$ is the angle between the de-meaned vectors. The Cauchy--Schwarz inequality ensures $-1 \le \rho \le 1$. [@boyd2018appliedlinearalgebra, p. 60]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $\lVert x \rVert$ | "norm of x" | Euclidean norm (also written $\lVert x \rVert_2$). The double bars suggest a generalisation of the absolute value. [@boyd2018appliedlinearalgebra, p. 45] |
| $\mathrm{dist}(a, b)$ | "distance from a to b" | $\lVert a - b \rVert$, the Euclidean distance. [@boyd2018appliedlinearalgebra, p. 48] |
| $\mathrm{rms}(x)$ | "R-M-S of x" | Root-mean-square value: $\lVert x \rVert / \sqrt{n}$. Gives the "typical" magnitude of entries. [@boyd2018appliedlinearalgebra, p. 46] |
| $\mathrm{std}(x)$ | "standard deviation of x" | RMS of the de-meaned vector. [@boyd2018appliedlinearalgebra, p. 52] |
| $\angle(a, b)$ | "angle between a and b" | $\arccos(a^\top b / (\lVert a \rVert \, \lVert b \rVert))$, measured in radians (default) or degrees. [@boyd2018appliedlinearalgebra, p. 57] |
| $a \perp b$ | "a is orthogonal to b" | $a^\top b = 0$; the angle is $\pi/2 = 90°$. [@boyd2018appliedlinearalgebra, p. 58] |
| $\rho$ | "rho" | Correlation coefficient between two vectors. [@boyd2018appliedlinearalgebra, p. 60] |
| $\mu$, $\sigma$ | "mu", "sigma" | Traditional symbols for mean and standard deviation, used in statistics; Boyd & Vandenberghe prefer $\mathrm{avg}(x)$ and $\mathrm{std}(x)$. [@boyd2018appliedlinearalgebra, p. 53] |

## Key results & derivations

- **Properties of the norm** -- Nonneg. homogeneity: $\lVert \beta x \rVert = |\beta| \, \lVert x \rVert$. Triangle inequality: $\lVert x + y \rVert \le \lVert x \rVert + \lVert y \rVert$. Nonnegativity: $\lVert x \rVert \ge 0$. Definiteness: $\lVert x \rVert = 0$ iff $x = 0$. The last two together are called *positive definiteness*. [@boyd2018appliedlinearalgebra, p. 46]
- **Norm of a sum** -- $\lVert x + y \rVert = \sqrt{\lVert x \rVert^2 + 2x^\top y + \lVert y \rVert^2}$, derived by expanding $(x + y)^\top(x + y)$. [@boyd2018appliedlinearalgebra, pp. 46--47]
- **RMS-avg-std identity** -- $\mathrm{rms}(x)^2 = \mathrm{avg}(x)^2 + \mathrm{std}(x)^2$. The derivation uses the expansion of $\lVert x - (\mathbf{1}^\top x / n)\mathbf{1} \rVert^2$ and the identity $\mathbf{1}^\top \mathbf{1} = n$. [@boyd2018appliedlinearalgebra, p. 53]
- **Chebyshev inequality** -- At most $k \le \lVert x \rVert^2 / a^2$ entries of $x$ can satisfy $|x_i| \ge a$. In RMS form: the fraction of entries with $|x_i| \ge a$ is at most $(\mathrm{rms}(x) / a)^2$. In std form: the fraction of entries deviating from the mean by $\ge a$ is at most $(\mathrm{std}(x) / a)^2$. [@boyd2018appliedlinearalgebra, pp. 47--48, 54]
- **Cauchy--Schwarz inequality** -- $|a^\top b| \le \lVert a \rVert \, \lVert b \rVert$ for any $n$-vectors $a, b$. Equality holds iff one vector is a scalar multiple of the other (or one is zero). The proof proceeds by observing that $0 \le \lVert \beta a - \alpha b \rVert^2$ with $\alpha = \lVert a \rVert$, $\beta = \lVert b \rVert$, expanding, and rearranging. [@boyd2018appliedlinearalgebra, pp. 56--57]
- **Triangle inequality from Cauchy--Schwarz** -- $\lVert a + b \rVert^2 = \lVert a \rVert^2 + 2a^\top b + \lVert b \rVert^2 \le \lVert a \rVert^2 + 2\lVert a \rVert \lVert b \rVert + \lVert b \rVert^2 = (\lVert a \rVert + \lVert b \rVert)^2$. Taking the square root gives the triangle inequality. [@boyd2018appliedlinearalgebra, p. 57]
- **Pythagorean theorem** -- When $a \perp b$, $\lVert a + b \rVert = \sqrt{\lVert a \rVert^2 + \lVert b \rVert^2}$ (the cross-term $2a^\top b$ vanishes). [@boyd2018appliedlinearalgebra, p. 60]
- **Standard deviation of a sum** -- $\mathrm{std}(a + b) = \sqrt{\mathrm{std}(a)^2 + 2\rho \, \mathrm{std}(a) \, \mathrm{std}(b) + \mathrm{std}(b)^2}$, where $\rho$ is the correlation coefficient between $a$ and $b$. When $\rho = 0$ (uncorrelated), $\mathrm{std}(a + b) = \sqrt{\mathrm{std}(a)^2 + \mathrm{std}(b)^2}$. When $\rho = 1$, $\mathrm{std}(a + b) = \mathrm{std}(a) + \mathrm{std}(b)$. [@boyd2018appliedlinearalgebra, p. 62]
- **Properties of standard deviation** -- Adding a constant: $\mathrm{std}(x + a\mathbf{1}) = \mathrm{std}(x)$ (shift-invariant). Scaling: $\mathrm{std}(ax) = |a| \, \mathrm{std}(x)$. [@boyd2018appliedlinearalgebra, p. 54]
- **Standardization** -- The *standardized* version of $x$ is $z = (x - \mathrm{avg}(x)\mathbf{1}) / \mathrm{std}(x)$, which has mean zero and standard deviation one. Its entries are called *z-scores*. [@boyd2018appliedlinearalgebra, p. 56]

## Prerequisites

- [Vectors and operations](vectors-and-operations.md) -- the norm is defined via the entries of a vector; distance and angle use vector subtraction.
- [Inner product](inner-product.md) -- the norm is $\sqrt{x^\top x}$; the angle definition uses $a^\top b$; the Cauchy--Schwarz inequality relates inner products to norms.

## Misconceptions & learner traps

- **"Length" is ambiguous** -- In mathematics, the "length" of a vector can mean either its norm (magnitude) or its dimension (number of entries). Boyd & Vandenberghe recommend avoiding "length" for the norm to prevent confusion. [@boyd2018appliedlinearalgebra, p. 45]
- **Std uses $n$, not $n-1$** -- Boyd & Vandenberghe define the standard deviation with denominator $\sqrt{n}$ (population formula), while many statistics texts and software use $\sqrt{n - 1}$ (sample formula, Bessel's correction). When comparing formulas across sources, check the denominator. [@boyd2018appliedlinearalgebra, p. 53]
- **Units matter for distance** -- When feature vector entries have different units or scales (e.g., house area in sq ft vs. number of bedrooms), one feature can dominate the Euclidean distance, making the other features effectively invisible. Choosing units so that all features have similar numerical ranges is essential for meaningful distance comparisons. [@boyd2018appliedlinearalgebra, pp. 51--52]
- **Angle vs. distance** -- Two vectors can be close in angle (nearly aligned) but far apart in distance (very different magnitudes), or vice versa. Angle-based similarity is insensitive to scaling, while distance is not. [@boyd2018appliedlinearalgebra, p. 58]
- **Correlation is not causation (or even monotonic relationship)** -- Correlation $\rho = 0$ means the de-meaned vectors are orthogonal, not that there is no relationship. The correlation coefficient measures only linear association. [@boyd2018appliedlinearalgebra, p. 60]

## Teaching insights & analogies

- **Norm generalises absolute value** -- For a scalar, $\lVert x \rVert = |x|$. The double-bar notation is meant to suggest this generalisation. Just as $|x|$ measures a number's size, $\lVert x \rVert$ measures a vector's size. [@boyd2018appliedlinearalgebra, p. 45]
- **RMS as "typical value"** -- The RMS value $\lVert x \rVert / \sqrt{n}$ gives a single number summarizing how large entries of a vector typically are, comparable across vectors of different sizes. The Chebyshev inequality makes this precise: not too many entries can be much larger than the RMS value. [@boyd2018appliedlinearalgebra, pp. 46--48]
- **Standard deviation as RMS of de-meaned vector** -- Boyd & Vandenberghe define standard deviation as the RMS value of $\tilde{x} = x - \mathrm{avg}(x)\mathbf{1}$, making the connection to norms and inner products explicit. This unifies standard deviation with the rest of the linear algebra machinery rather than treating it as a standalone statistics formula. [@boyd2018appliedlinearalgebra, p. 52]
- **Risk-return plot** -- In finance, the mean (return) and standard deviation (risk) of a time series of returns are plotted on a two-axis "risk-return" diagram. High return with low risk is desirable. This makes standard deviation tangible: it measures how volatile the returns are. [@boyd2018appliedlinearalgebra, pp. 54--55]
- **Hedging reduces risk** -- Blending two investments with uncorrelated returns into a 50/50 portfolio reduces risk by a factor of $1/\sqrt{2} \approx 0.707$ without changing the expected return. This is a concrete application of the std-of-a-sum formula with $\rho = 0$. [@boyd2018appliedlinearalgebra, p. 62]
- **Document similarity via angles** -- The angle between word-count histogram vectors measures document dissimilarity: related documents (Veterans Day and Memorial Day) have small angles, unrelated ones (Veterans Day and Super Bowl) have angles near 90 degrees. [@boyd2018appliedlinearalgebra, pp. 58--59]
- **Nearest neighbor** -- Given a collection of vectors $z_1, \ldots, z_m$ and a query $x$, the nearest neighbor is the $z_j$ minimising $\lVert x - z_j \rVert$. This generalisation to $k$-nearest neighbors underlies many classification and recommendation algorithms. [@boyd2018appliedlinearalgebra, p. 50]

## How the field talks about it

"Norm" without qualification means the Euclidean ($\ell_2$) norm in most applied linear algebra and optimization texts. The subscript notation $\lVert x \rVert_2$ is used when other norms (the 1-norm $\lVert x \rVert_1 = |x_1| + \cdots + |x_n|$, the $\infty$-norm $\lVert x \rVert_\infty = \max_i |x_i|$) are also in play. [@boyd2018appliedlinearalgebra, p. 45] "Distance" without qualification means Euclidean distance. The correlation coefficient $\rho$ is sometimes expressed as a percentage (e.g., $\rho = 0.3$ is "30% correlation"). When $\rho = 0$, the vectors are called *uncorrelated*; when $|\rho|$ is close to 1, they are *highly correlated*. [@boyd2018appliedlinearalgebra, p. 60] Orthogonality ($a \perp b$, i.e., $a^\top b = 0$) is the high-dimensional generalisation of perpendicularity. [@boyd2018appliedlinearalgebra, p. 58]
