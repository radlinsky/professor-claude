---
title: "Joint distributions"
topic: probability
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

A joint distribution characterizes the probability structure of two or more
random variables considered simultaneously. It is a high-dimensional extension
of the single-variable PMF or PDF: the joint PMF/PDF assigns probability to
every combination of states, and all marginal, conditional, and independence
properties can be derived from it.
[@chan2021probabilitydatascience, pp. 241--243]

**Also known as:** multivariate distribution, joint probability distribution

## Definition(s)

**Joint PMF:** For two discrete random variables $X$ and $Y$, the joint PMF is:
[@chan2021probabilitydatascience, p. 246]

$$p_{X,Y}(x, y) = \mathbb{P}[X = x \text{ and } Y = y].$$

The joint PMF is a 2D array of impulses; the probability of any event
$\mathcal{A}$ is $\mathbb{P}[\mathcal{A}] = \sum_{(x,y) \in \mathcal{A}} p_{X,Y}(x,y)$.
[@chan2021probabilitydatascience, p. 246]

**Joint PDF:** For two continuous random variables $X$ and $Y$, the joint PDF
$f_{X,Y}(x,y)$ is a function such that integrating it over any region
$\mathcal{A} \subseteq \Omega_X \times \Omega_Y$ yields the probability:
[@chan2021probabilitydatascience, p. 247]

$$\mathbb{P}[\mathcal{A}] = \int_{\mathcal{A}} f_{X,Y}(x, y)\, dx\, dy.$$

**Marginal PMF and PDF:** The marginal distributions are obtained by
summing (discrete) or integrating (continuous) over the other variable:
[@chan2021probabilitydatascience, p. 250]

$$p_X(x) = \sum_{y \in \Omega_Y} p_{X,Y}(x, y), \qquad f_X(x) = \int_{\Omega_Y} f_{X,Y}(x, y)\, dy.$$

The marginal PDF is the "projection" of the joint PDF onto the $x$-axis
(or $y$-axis): integrating out $y$ collapses the 2D surface into a 1D curve.
[@chan2021probabilitydatascience, p. 250]

**Joint CDF:** For two random variables $X$ and $Y$, the joint CDF is:
[@chan2021probabilitydatascience, p. 255]

$$F_{X,Y}(x, y) = \mathbb{P}[X \le x \cap Y \le y].$$

For continuous variables, $F_{X,Y}(x,y) = \int_{-\infty}^{y}\int_{-\infty}^{x}
f_{X,Y}(x', y')\, dx'\, dy'$, and the joint PDF is the mixed second partial
derivative: $f_{X,Y}(x,y) = \frac{\partial^2}{\partial y\,\partial x}
F_{X,Y}(x,y)$. [@chan2021probabilitydatascience, pp. 255--256]

**Conditional PMF:** For discrete random variables $X$ and $Y$:
[@chan2021probabilitydatascience, p. 267]

$$p_{X|Y}(x|y) = \frac{p_{X,Y}(x, y)}{p_Y(y)}.$$

This is the PMF of $X$ when $Y$ is fixed at $Y = y$ -- it is a legitimate
PMF in $x$ (sums to 1 over $x$), but it is NOT a PMF in $y$.
[@chan2021probabilitydatascience, pp. 267--268]

**Conditional PDF:** For continuous random variables:
[@chan2021probabilitydatascience, p. 272]

$$f_{X|Y}(x|y) = \frac{f_{X,Y}(x, y)}{f_Y(y)}.$$

The conditional CDF is defined via a limiting argument:
$F_{X|Y}(x|y) = \lim_{h \to 0} \mathbb{P}(X \le x \mid y \le Y \le y+h)$,
which yields $F_{X|Y}(x|y) = \int_{-\infty}^{x} f_{X,Y}(x', y)/f_Y(y)\, dx'$.
[@chan2021probabilitydatascience, pp. 272--273]

**Independence:** Random variables $X$ and $Y$ are independent if and only if
their joint PMF (or PDF) factors into the product of the marginals:
[@chan2021probabilitydatascience, p. 252]

$$p_{X,Y}(x,y) = p_X(x)\, p_Y(y), \quad \text{or} \quad f_{X,Y}(x,y) = f_X(x)\, f_Y(y).$$

**Independent and identically distributed (i.i.d.):** A collection
$X_1, \ldots, X_N$ is i.i.d. if all $X_i$ are independent AND have the same
distribution $f_{X_1}(x) = \cdots = f_{X_N}(x)$. Then the joint PDF factors
as $f_{X_1, \ldots, X_N}(x_1, \ldots, x_N) = \prod_{n=1}^{N} f_{X_1}(x_n)$.
[@chan2021probabilitydatascience, pp. 253--254]

**Multivariate Gaussian (joint Gaussian):** A $d$-dimensional joint Gaussian
has PDF: [@chan2021probabilitydatascience, p. 290]

$$f_{\boldsymbol{X}}(\boldsymbol{x}) = \frac{1}{\sqrt{(2\pi)^d |\boldsymbol{\Sigma}|}} \exp\left\{-\frac{1}{2}(\boldsymbol{x} - \boldsymbol{\mu})^T \boldsymbol{\Sigma}^{-1}(\boldsymbol{x} - \boldsymbol{\mu})\right\},$$

where $\boldsymbol{\mu} = \mathbb{E}[\boldsymbol{X}]$ is the mean vector and
$\boldsymbol{\Sigma} = \text{Cov}(\boldsymbol{X})$ is the covariance matrix.
When the coordinates are independent, $\boldsymbol{\Sigma}$ is diagonal and the
joint Gaussian factors into a product of 1D Gaussians. The geometry of the
contours (ellipses in 2D, ellipsoids in higher dimensions) is determined by
the eigendecomposition of $\boldsymbol{\Sigma}$: eigenvectors give the
axis directions, eigenvalues give the squared radii.
[@chan2021probabilitydatascience, pp. 290--291, 297]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $p_{X,Y}(x,y)$ | "the joint PMF at x, y" | The probability that $X = x$ and $Y = y$ simultaneously. [@chan2021probabilitydatascience, p. 246] |
| $f_{X,Y}(x,y)$ | "the joint PDF at x, y" | The joint probability density at $(x, y)$; integrate over a region to get probability. [@chan2021probabilitydatascience, p. 247] |
| $f_{\boldsymbol{X}}(\boldsymbol{x})$ | "the joint PDF of the random vector X" | The $N$-dimensional joint PDF; $\boldsymbol{X} = [X_1, \ldots, X_N]^T$. [@chan2021probabilitydatascience, p. 241] |
| $p_{X|Y}(x|y)$ | "the conditional PMF of X given Y equals y" | The PMF of $X$ when $Y$ is fixed at $y$. [@chan2021probabilitydatascience, p. 267] |
| $f_{X|Y}(x|y)$ | "the conditional PDF of X given Y equals y" | The PDF of $X$ when $Y$ is fixed at $y$. [@chan2021probabilitydatascience, p. 272] |
| $F_{X,Y}(x,y)$ | "the joint CDF at x, y" | $\mathbb{P}[X \le x \cap Y \le y]$. [@chan2021probabilitydatascience, p. 255] |
| $(f_X * f_Y)(z)$ | "the convolution of f-X and f-Y at z" | $\int_{-\infty}^{\infty} f_X(z-y) f_Y(y)\, dy$: the PDF of $Z = X + Y$ for independent $X, Y$. [@chan2021probabilitydatascience, p. 281] |

## Key results & derivations

- **Normalization (Theorem 5.1)** -- all joint PMFs and joint PDFs satisfy
  $\sum_{(x,y) \in \Omega} p_{X,Y}(x,y) = 1$ or $\int_\Omega f_{X,Y}(x,y)\,
  dx\, dy = 1$. [@chan2021probabilitydatascience, p. 249]

- **Marginal CDF from joint CDF (Proposition 5.1)** -- the marginal CDFs are
  $F_X(x) = F_{X,Y}(x, \infty)$ and $F_Y(y) = F_{X,Y}(\infty, y)$. The proof
  uses $\int_{-\infty}^{\infty} f_Y(y')\, dy' = 1$.
  [@chan2021probabilitydatascience, p. 256]

- **Conditional probability via conditional PMF (Theorem 5.7)** -- for any
  event $A$: $\mathbb{P}[X \in A \mid Y = y] = \sum_{x \in A} p_{X|Y}(x|y)$,
  and $\mathbb{P}[X \in A] = \sum_{x \in A} \sum_{y \in \Omega_Y}
  p_{X|Y}(x|y) p_Y(y)$. The second formula decomposes marginal probability
  into conditional slices. [@chan2021probabilitydatascience, p. 270]

- **Conditional probability via conditional PDF (Theorem 5.8)** -- for
  continuous variables: $\mathbb{P}[X \in A \mid Y = y] = \int_A
  f_{X|Y}(x|y)\, dx$, and $\mathbb{P}[X \in A] = \int_{\Omega_Y}
  \mathbb{P}[X \in A \mid Y = y] f_Y(y)\, dy$.
  [@chan2021probabilitydatascience, p. 273]

- **PDF of a sum: convolution (Theorem 5.10)** -- if $X$ and $Y$ are
  independent with PDFs $f_X$ and $f_Y$, then the PDF of $Z = X + Y$ is the
  convolution $f_Z(z) = (f_X * f_Y)(z) = \int_{-\infty}^{\infty}
  f_X(z-y) f_Y(y)\, dy$. The proof uses the CDF $F_Z(z) = \mathbb{P}[X+Y
  \le z]$, which integrates the joint PDF over the region $x + y \le z$, then
  differentiates with the Leibniz rule.
  [@chan2021probabilitydatascience, pp. 281--282]

- **Sum of two Poissons (Theorem 5.11)** -- if $X_1 \sim \text{Poisson}
  (\lambda_1)$ and $X_2 \sim \text{Poisson}(\lambda_2)$ are independent, then
  $X_1 + X_2 \sim \text{Poisson}(\lambda_1 + \lambda_2)$. The proof uses
  convolution and the binomial identity.
  [@chan2021probabilitydatascience, pp. 282--283]

- **Sum of two Gaussians (Theorem 5.12)** -- if $X_1 \sim
  \mathcal{N}(\mu_1, \sigma_1^2)$ and $X_2 \sim \mathcal{N}(\mu_2,
  \sigma_2^2)$ are independent, then $X_1 + X_2 \sim \mathcal{N}(\mu_1 +
  \mu_2, \sigma_1^2 + \sigma_2^2)$. The proof completes the square in the
  convolution integral. [@chan2021probabilitydatascience, pp. 283--284]

- **Linear transformation of mean and covariance (Theorem 5.14)** -- if
  $\boldsymbol{Y} = \boldsymbol{A}\boldsymbol{X}$, then $\boldsymbol{\mu}_Y =
  \boldsymbol{A}\boldsymbol{\mu}_X$ and $\boldsymbol{\Sigma}_Y =
  \boldsymbol{A}\boldsymbol{\Sigma}_X\boldsymbol{A}^T$.
  [@chan2021probabilitydatascience, p. 294]

- **Covariance matrix is always positive semi-definite (Theorem 5.18)** --
  $\boldsymbol{\Sigma}^T = \boldsymbol{\Sigma}$ and $\boldsymbol{v}^T
  \boldsymbol{\Sigma}\boldsymbol{v} \ge 0$ for all $\boldsymbol{v}$. The proof
  uses $\boldsymbol{v}^T \boldsymbol{\Sigma}\boldsymbol{v} =
  \mathbb{E}[\|\boldsymbol{b}\|^2] \ge 0$ where $\boldsymbol{b} =
  (\boldsymbol{X} - \boldsymbol{\mu})^T \boldsymbol{v}$.
  [@chan2021probabilitydatascience, p. 298]

- **Gaussian whitening (Theorem 5.19 and 5.20)** -- any
  $\text{Gaussian}(\boldsymbol{0}, \boldsymbol{I})$ can be transformed to
  $\text{Gaussian}(\boldsymbol{\mu}, \boldsymbol{\Sigma})$ via
  $\boldsymbol{Y} = \boldsymbol{\Sigma}^{1/2}\boldsymbol{X} +
  \boldsymbol{\mu}$, and conversely
  $\boldsymbol{X} = \boldsymbol{\Sigma}^{-1/2}(\boldsymbol{Y} -
  \boldsymbol{\mu})$ maps back to $\text{Gaussian}(\boldsymbol{0},
  \boldsymbol{I})$. [@chan2021probabilitydatascience, pp. 299--302]

## Prerequisites

- [random-variables-and-distributions](random-variables-and-distributions.md) --
  the single-variable PMF, PDF, and CDF definitions are generalized to two
  or more variables.
- [expectation-and-moments](expectation-and-moments.md) -- expectation and
  variance of individual variables are needed before defining joint expectation
  and covariance.
- [conditional-probability](conditional-probability.md) -- conditional
  probability of events ($\mathbb{P}[A|B]$) is the foundation for the
  conditional PMF/PDF definitions.
- [continuous-named-distributions](continuous-named-distributions.md) -- the
  1D Gaussian is needed for the multivariate Gaussian definition and the
  sum-of-Gaussians result.

## Misconceptions & learner traps

- **Confusing the joint PDF with the product of marginals** -- the joint PDF
  $f_{X,Y}(x,y)$ equals $f_X(x) f_Y(y)$ ONLY when $X$ and $Y$ are
  independent. In general, the joint carries information about the
  relationship between $X$ and $Y$ that the marginals lose.
  [@chan2021probabilitydatascience, p. 252]

- **Thinking conditional PMF $p_{X|Y}(x|y)$ is a PMF in $y$** -- it is a
  legitimate PMF in $x$ (sums to 1 over $x$), but summing over $y$ does NOT
  yield 1. The denominator $p_Y(y)$ changes with $y$, so the function is not
  normalized in $y$. [@chan2021probabilitydatascience, p. 268]

- **"P[X = x] = 0 means you can't condition on X = x"** -- for continuous
  variables, $\mathbb{P}[Y = y] = 0$, but the conditional PDF is still
  well-defined via the limiting argument $F_{X|Y}(x|y) = \lim_{h \to 0}
  \mathbb{P}(X \le x \mid y \le Y \le y+h)$. The $h$ cancels between
  numerator and denominator. [@chan2021probabilitydatascience, pp. 272--273]

- **Confusing PDF of $Z = X + Y$ with $f_X(z) + f_Y(z)$** -- the PDF of the
  sum is the CONVOLUTION of $f_X$ and $f_Y$, not their pointwise sum. Adding
  PDFs pointwise does not produce a valid PDF (the integral would be 2, not
  1). [@chan2021probabilitydatascience, p. 281]

- **Assuming any positive semi-definite matrix is a valid covariance** -- a
  valid covariance matrix must be symmetric AND positive semi-definite. An
  estimated matrix from data may fail to be positive semi-definite due to
  numerical issues, in which case $\boldsymbol{\Sigma}^{-1}$ does not exist
  and the Gaussian PDF is undefined.
  [@chan2021probabilitydatascience, pp. 297--298]

## Teaching insights & analogies

- **"Joint distributions are high-dimensional PDFs"** -- a single random
  variable has a 1D PDF $f_X(x)$; a pair has a 2D surface
  $f_{X,Y}(x,y)$; $N$ variables have an $N$-dimensional function. The
  progression $f_X \Rightarrow f_{X_1,X_2} \Rightarrow f_{X_1,\ldots,X_N}$
  is the organizing thread of the chapter.
  [@chan2021probabilitydatascience, p. 241]

- **Marginal = projection** -- integrating $f_{X,Y}(x,y)$ over $y$ is like
  shining a flashlight through a 2D surface and seeing the shadow on the
  $x$-axis. The shadow is $f_X(x)$.
  [@chan2021probabilitydatascience, p. 250]

- **Conditioning = slicing** -- the conditional PDF $f_{X|Y}(x|y_0)$ is the
  "slice" of the joint surface at $Y = y_0$, renormalized to integrate to 1.
  The denominator $f_Y(y_0)$ performs the renormalization.
  [@chan2021probabilitydatascience, pp. 267--268, 272]

- **i.i.d. = the simplest joint** -- if variables are i.i.d., the joint PDF is
  a product, and integrating a product is much easier than integrating an
  arbitrary joint PDF. This is why the i.i.d. assumption is so common in
  statistics. [@chan2021probabilitydatascience, p. 254]

- **Convolution as "slide and multiply"** -- the PDF of a sum $Z = X + Y$ is
  computed by flipping $f_Y$, sliding it past $f_X$, and integrating the
  product at each position. Convolving two uniform distributions gives a
  triangular distribution; repeated convolution approaches a Gaussian (the
  CLT). [@chan2021probabilitydatascience, pp. 280--282]

- **MVN contours are ellipses** -- the eigendecomposition
  $\boldsymbol{\Sigma} = \boldsymbol{U}\boldsymbol{\Lambda}
  \boldsymbol{U}^T$ determines the shape: eigenvectors $\boldsymbol{u}_i$
  set the axis directions, eigenvalues $\lambda_i$ set the squared radii.
  All constant-density contours of the MVN are ellipses (2D) or ellipsoids
  (higher dimensions). [@chan2021probabilitydatascience, p. 297]

## How the field talks about it

In statistics, "joint distribution" refers to the full multivariate probability
model. The marginals are the "individual" distributions; they do not determine
the joint unless independence is assumed. In machine learning, the notation
$p(x, y)$ (dropping subscripts) is common for the joint, with $p(x|y)$ for
the conditional and $p(x)$ for the marginal. The factorization
$p(x, y) = p(x|y)\, p(y)$ (product rule) is the workhorse of Bayesian
inference and generative modeling. The i.i.d. assumption is nearly universal in
introductory statistics and machine learning for characterizing datasets.
[@chan2021probabilitydatascience, pp. 246--254, 267--272]
