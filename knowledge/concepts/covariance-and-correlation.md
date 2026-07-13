---
title: "Covariance and correlation"
topic: probability
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

Covariance measures the linear co-movement of two random variables:
$\text{Cov}(X, Y) = \mathbb{E}[(X - \mu_X)(Y - \mu_Y)]$. The correlation
coefficient $\rho$ normalizes covariance to lie in $[-1, 1]$, giving a
scale-free measure of linear association that equals the cosine of the angle
between the state vectors weighted by the joint PMF.
[@chan2021probabilitydatascience, pp. 262--263]

**Also known as:** linear association (informal); Pearson correlation (for $\rho$)

## Definition(s)

**Joint expectation (correlation):** For two random variables $X$ and $Y$,
the joint expectation is: [@chan2021probabilitydatascience, p. 257]

$$\mathbb{E}[XY] = \sum_{y \in \Omega_Y} \sum_{x \in \Omega_X} xy\, p_{X,Y}(x,y) \quad \text{or} \quad \int_{\Omega_Y}\int_{\Omega_X} xy\, f_{X,Y}(x,y)\, dx\, dy.$$

Joint expectation is also called **correlation** because $\mathbb{E}[XY]$ can
be interpreted as a weighted inner product $\boldsymbol{x}^T
\boldsymbol{P}\boldsymbol{y}$, where $\boldsymbol{P}$ is the joint PMF matrix.
This is the cosine-angle perspective: $\mathbb{E}[XY]$ measures the alignment
between the state vectors of $X$ and $Y$.
[@chan2021probabilitydatascience, pp. 258--261]

**Covariance:** The covariance of $X$ and $Y$ is:
[@chan2021probabilitydatascience, p. 262]

$$\text{Cov}(X, Y) = \mathbb{E}[(X - \mu_X)(Y - \mu_Y)],$$

where $\mu_X = \mathbb{E}[X]$ and $\mu_Y = \mathbb{E}[Y]$. When $X = Y$,
$\text{Cov}(X, X) = \text{Var}[X]$, so covariance generalizes variance to pairs.
[@chan2021probabilitydatascience, p. 262]

**Correlation coefficient:** The correlation coefficient is:
[@chan2021probabilitydatascience, p. 263]

$$\rho = \frac{\text{Cov}(X, Y)}{\sqrt{\text{Var}[X]\,\text{Var}[Y]}}.$$

It is the cosine of the angle between the centered state vectors, bounded by
$-1 \le \rho \le 1$. $\rho = +1$ means $X = Y$ (up to positive scaling),
$\rho = -1$ means $X = -Y$, and $\rho = 0$ means $X$ and $Y$ are
uncorrelated. [@chan2021probabilitydatascience, p. 263]

**Conditional expectation:** The expectation of $X$ given $Y = y$ is:
[@chan2021probabilitydatascience, p. 275]

$$\mathbb{E}[X \mid Y = y] = \sum_x x\, p_{X|Y}(x|y) \quad \text{or} \quad \int_{-\infty}^{\infty} x\, f_{X|Y}(x|y)\, dx.$$

The result is a function of $y$ (not of $x$), because conditioning on $Y = y$
eliminates all randomness in $Y$.
[@chan2021probabilitydatascience, p. 275]

**Covariance matrix:** For a random vector $\boldsymbol{X} = [X_1, \ldots,
X_N]^T$, the covariance matrix is:
[@chan2021probabilitydatascience, p. 289]

$$\boldsymbol{\Sigma} \stackrel{\text{def}}{=} \text{Cov}(\boldsymbol{X}) = \mathbb{E}[(\boldsymbol{X} - \boldsymbol{\mu})(\boldsymbol{X} - \boldsymbol{\mu})^T],$$

with diagonal entries $\text{Var}[X_i]$ and off-diagonal entries
$\text{Cov}(X_i, X_j)$. If the coordinates are independent, the covariance
matrix is diagonal. [@chan2021probabilitydatascience, pp. 289--290]

**Autocorrelation matrix:** The autocorrelation matrix is
$\boldsymbol{R} = \mathbb{E}[\boldsymbol{X}\boldsymbol{X}^T]$, related to the
covariance matrix by $\boldsymbol{\Sigma} = \boldsymbol{R} -
\boldsymbol{\mu}\boldsymbol{\mu}^T$ (the multivariate analog of
$\sigma^2 = \mathbb{E}[X^2] - \mu^2$).
[@chan2021probabilitydatascience, p. 290]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $\mathbb{E}[XY]$ | "E of X Y" or "the joint expectation" | The probability-weighted product of the states of $X$ and $Y$; also called correlation. [@chan2021probabilitydatascience, p. 257] |
| $\text{Cov}(X, Y)$ | "the covariance of X and Y" | $\mathbb{E}[(X - \mu_X)(Y - \mu_Y)] = \mathbb{E}[XY] - \mu_X \mu_Y$. [@chan2021probabilitydatascience, p. 262] |
| $\rho$ | "rho" or "the correlation coefficient" | $\text{Cov}(X,Y) / (\sigma_X \sigma_Y)$; bounded between $-1$ and $1$. [@chan2021probabilitydatascience, p. 263] |
| $\boldsymbol{\Sigma}$ | "Sigma" or "the covariance matrix" | The $N \times N$ matrix with $[\boldsymbol{\Sigma}]_{ij} = \text{Cov}(X_i, X_j)$. [@chan2021probabilitydatascience, p. 289] |
| $\boldsymbol{R}$ | "the autocorrelation matrix" | $\mathbb{E}[\boldsymbol{X}\boldsymbol{X}^T]$; $\boldsymbol{\Sigma} = \boldsymbol{R} - \boldsymbol{\mu}\boldsymbol{\mu}^T$. [@chan2021probabilitydatascience, p. 290] |
| $\mathbb{E}[X \mid Y = y]$ | "E of X given Y equals y" | The conditional expectation: the expected value of $X$ using the conditional distribution $p_{X|Y}(\cdot|y)$ or $f_{X|Y}(\cdot|y)$. [@chan2021probabilitydatascience, p. 275] |

## Key results & derivations

- **Covariance shortcut (Theorem 5.3)** -- $\text{Cov}(X, Y) = \mathbb{E}[XY]
  - \mathbb{E}[X]\mathbb{E}[Y]$. The proof expands
  $\mathbb{E}[(X - \mu_X)(Y - \mu_Y)]$ and uses linearity of expectation.
  [@chan2021probabilitydatascience, p. 262]

- **Variance of a sum (Theorem 5.4)** -- for any $X$ and $Y$:
  $\mathbb{E}[X + Y] = \mathbb{E}[X] + \mathbb{E}[Y]$ (always), and
  $\text{Var}[X + Y] = \text{Var}[X] + 2\,\text{Cov}(X, Y) + \text{Var}[Y]$.
  When $X$ and $Y$ are uncorrelated ($\text{Cov}(X,Y) = 0$), the variance of
  the sum is the sum of the variances.
  [@chan2021probabilitydatascience, p. 262]

- **Independence implies uncorrelated (Theorem 5.5 and 5.6)** -- if $X$ and
  $Y$ are independent, then $\mathbb{E}[XY] = \mathbb{E}[X]\mathbb{E}[Y]$,
  so $\text{Cov}(X,Y) = 0$ and $\rho = 0$. The converse is FALSE:
  uncorrelated does NOT imply independent. Chan's counterexample uses
  $Z \sim \text{Uniform}\{0, 1, 2, 3\}$ with $X = \cos(\pi Z/2)$ and
  $Y = \sin(\pi Z/2)$: $\text{Cov}(X,Y) = 0$ but $p_{X,Y}(x,y) \ne
  p_X(x) p_Y(y)$. [@chan2021probabilitydatascience, pp. 264--265]

- **Cauchy-Schwarz inequality (Theorem 5.2)** --
  $(\mathbb{E}[XY])^2 \le \mathbb{E}[X^2]\,\mathbb{E}[Y^2]$. This
  guarantees $-1 \le \rho \le 1$. The proof uses the fact that
  $\mathbb{E}[(X + tY)^2] \ge 0$ for all $t$, which gives a quadratic in
  $t$ with non-positive discriminant.
  [@chan2021probabilitydatascience, pp. 261--262]

- **Law of total expectation (Theorem 5.9)** --
  $\mathbb{E}[X] = \sum_y \mathbb{E}[X \mid Y = y]\, p_Y(y)$ (discrete) or
  $\mathbb{E}[X] = \int_{-\infty}^{\infty} \mathbb{E}[X \mid Y = y]\,
  f_Y(y)\, dy$ (continuous). In compact notation:
  $\mathbb{E}[X] = \mathbb{E}_Y[\mathbb{E}_{X|Y}[X|Y]]$. This decomposes
  the overall expectation into subexpectations.
  [@chan2021probabilitydatascience, p. 276]

- **Empirical correlation** -- given data $(x_n, y_n)_{n=1}^{N}$, the
  empirical correlation is
  $\hat{\rho} = \frac{\frac{1}{N}\sum x_n y_n - \bar{x}\bar{y}}
  {\sqrt{\frac{1}{N}\sum(x_n - \bar{x})^2}\sqrt{\frac{1}{N}\sum(y_n -
  \bar{y})^2}}$. As $N \to \infty$, $\hat{\rho} \to \rho$.
  [@chan2021probabilitydatascience, pp. 265--266]

## Prerequisites

- [expectation-and-moments](expectation-and-moments.md) -- expectation and
  variance of single variables are needed before defining covariance.
- [joint-distributions](joint-distributions.md) -- the joint PMF/PDF is
  needed to define $\mathbb{E}[XY]$ and conditional distributions.
- [random-variables-and-distributions](random-variables-and-distributions.md) --
  the PMF/PDF/CDF framework underlies all definitions.

## Misconceptions & learner traps

- **"Uncorrelated means independent"** -- WRONG. Zero covariance (or
  $\rho = 0$) means no LINEAR relationship, but the variables can have a
  nonlinear relationship. Independence is strictly stronger than
  uncorrelatedness. [@chan2021probabilitydatascience, pp. 264--265]

- **Confusing $\mathbb{E}[XY]$ with $\text{Cov}(X,Y)$** -- joint expectation
  $\mathbb{E}[XY]$ includes the means; covariance subtracts them out:
  $\text{Cov}(X,Y) = \mathbb{E}[XY] - \mu_X \mu_Y$. Correlation coefficient
  $\rho$ further normalizes by the standard deviations.
  [@chan2021probabilitydatascience, p. 262]

- **Forgetting the $2\,\text{Cov}$ term in $\text{Var}[X + Y]$** -- the
  variance of a sum is NOT the sum of the variances unless $X$ and $Y$ are
  uncorrelated. The cross-term $2\,\text{Cov}(X,Y)$ can make the variance of
  the sum larger (positive covariance) or smaller (negative covariance) than
  the sum of the individual variances.
  [@chan2021probabilitydatascience, p. 262]

- **Interpreting $\rho = 0$ as "no relationship"** -- $\rho$ measures only
  linear association. Variables with a perfect nonlinear relationship (e.g.,
  $Y = X^2$, $X$ symmetric about 0) can have $\rho = 0$.
  [@chan2021probabilitydatascience, pp. 264--265]

## Teaching insights & analogies

- **Correlation = cosine angle between state vectors** -- the states of $X$
  form a vector $\boldsymbol{x}$, the states of $Y$ form a vector
  $\boldsymbol{y}$, and the joint PMF provides the weighting matrix
  $\boldsymbol{P}$. The joint expectation $\mathbb{E}[XY] =
  \boldsymbol{x}^T \boldsymbol{P}\boldsymbol{y}$ is a weighted inner product.
  Normalizing gives the cosine angle, which is the correlation coefficient.
  [@chan2021probabilitydatascience, pp. 258--261]

- **Scatter plot intuition for $\rho$** -- $\hat{\rho} \approx 0$ means the
  scatter plot is a formless cloud; $\hat{\rho} \approx 1$ means points line
  up along a positively-sloped line; $\hat{\rho} \approx -1$ means a
  negatively-sloped line. The tighter the cloud around the line, the closer
  $|\hat{\rho}|$ is to 1. [@chan2021probabilitydatascience, p. 266]

- **Law of total expectation as decomposition** -- the overall expectation
  $\mathbb{E}[X]$ is a weighted average of conditional expectations
  $\mathbb{E}[X \mid Y = y]$, with weights $p_Y(y)$. This is a powerful
  problem-solving tool: decompose a hard expectation into easier conditional
  pieces, then average. [@chan2021probabilitydatascience, p. 276]

- **Two-class car speed example** -- if fast cars ($C = 1$) have mean speed
  $\mu_1$ with probability $p$ and slow cars ($C = 2$) have mean speed
  $\mu_2$ with probability $1 - p$, then the overall average speed is
  $\mathbb{E}[X] = p\mu_1 + (1-p)\mu_2$. This is a direct application of
  the law of total expectation.
  [@chan2021probabilitydatascience, p. 277]

## How the field talks about it

In statistics, $\text{Cov}(X,Y)$ and $\rho$ are standard notation. The
correlation matrix (normalized covariance matrix with 1s on the diagonal)
is denoted $\boldsymbol{R}$ in some fields, which can cause confusion with
Chan's autocorrelation matrix $\boldsymbol{R} = \mathbb{E}[\boldsymbol{X}
\boldsymbol{X}^T]$. In R, `cor(x, y)` computes the sample correlation;
in Python, `np.corrcoef(x, y)` or `stats.pearsonr(x, y)`. The sample
covariance matrix is `cov(X)` in R and `np.cov(X)` in Python; caution is
needed with the axis argument (R treats columns as variables by default;
NumPy treats rows as variables by default).
[@chan2021probabilitydatascience, pp. 265--266, 289--290]
