---
title: "Expectation and moments"
topic: probability
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

The expectation (mean) of a random variable is the probability-weighted average
of its states: $\mathbb{E}[X] = \sum_{x \in X(\Omega)} x\, p_X(x)$. It is the
center of mass of the PMF and equals the true average that the sample mean
converges to as the number of observations grows.
[@chan2021probabilitydatascience, pp. 125--126]

**Also known as:** mean, expected value, first moment, population mean

## Definition(s)

**Expectation:** The expectation of a discrete random variable $X$ is:
[@chan2021probabilitydatascience, p. 125]

$$\mathbb{E}[X] = \sum_{x \in X(\Omega)} x\, p_X(x).$$

Intuitively, $p_X(x)$ is the fraction of time $X$ takes the value $x$;
multiplying by $x$ gives each value's contribution; summing over all states
gives the mean. This is exactly the same computation as the sample average
$\frac{1}{N}\sum_{n=1}^{N} x^{(n)}$ in the limit as $N \to \infty$.
[@chan2021probabilitydatascience, pp. 125--126]

**$k$th moment:** The $k$th moment of $X$ is:
[@chan2021probabilitydatascience, p. 133]

$$\mathbb{E}[X^k] = \sum_x x^k\, p_X(x).$$

The expectation $\mathbb{E}[X]$ is the first moment; $\mathbb{E}[X^2]$ is the
second moment. Higher-order moments can be defined but are less commonly used.
[@chan2021probabilitydatascience, p. 133]

**Variance:** The variance of a random variable $X$ is:
[@chan2021probabilitydatascience, p. 134]

$$\text{Var}[X] = \mathbb{E}[(X - \mu)^2],$$

where $\mu = \mathbb{E}[X]$. The square root $\sigma = \sqrt{\text{Var}[X]}$
is the **standard deviation**. The variance measures how spread out the
random variable's values are around its mean, quantified by the expected
squared deviation. Like the expectation, the variance is computed from the
ideal PMF (not from data); the sample variance is its empirical
approximation. [@chan2021probabilitydatascience, pp. 134--135]

**Absolute summability:** A discrete random variable $X$ is absolutely summable
if $\mathbb{E}[|X|] = \sum_{x \in X(\Omega)} |x|\, p_X(x) < \infty$. Not all
random variables have a finite expectation; absolute summability guarantees
that the expectation exists. [@chan2021probabilitydatascience, p. 130]

**Continuous expectation:** For a continuous random variable $X$ with PDF
$f_X(x)$, the expectation is the integral analog of the discrete sum:
[@chan2021probabilitydatascience, p. 180]

$$\mathbb{E}[X] = \int_\Omega x\, f_X(x)\, dx.$$

**Continuous $k$th moment and variance:** The $k$th moment of a continuous
random variable is $\mathbb{E}[X^k] = \int_\Omega x^k\, f_X(x)\, dx$, and the
variance is $\text{Var}[X] = \int_\Omega (x - \mu)^2 f_X(x)\, dx$. The
shortcut $\text{Var}[X] = \mathbb{E}[X^2] - \mu^2$ carries over identically.
[@chan2021probabilitydatascience, p. 184]

**Absolute integrability:** A continuous random variable $X$ has a
well-defined expectation if $\mathbb{E}[|X|] = \int_\Omega |x|\,f_X(x)\,dx
< \infty$. The Cauchy distribution $f_X(x) = 1/(\pi(1+x^2))$ is the canonical
example of a valid PDF whose expectation does not exist because $\mathbb{E}[|X|]
= \infty$. [@chan2021probabilitydatascience, pp. 183--184]

**Median:** The median of a continuous random variable is the point $c$ such
that $F_X(c) = 1/2$ (equivalently, $\int_{-\infty}^c f_X(x)\,dx =
\int_c^{\infty} f_X(x)\,dx$). It splits the area under the PDF into two equal
halves. [@chan2021probabilitydatascience, pp. 196--197]

**Mode:** The mode is the point $c = \arg\max_x f_X(x)$ where the PDF attains
its maximum (equivalently, where the CDF has steepest slope). The mode is not
necessarily unique. [@chan2021probabilitydatascience, p. 198]

**Skewness and kurtosis:** The skewness $\gamma = \mathbb{E}[((X-\mu)/\sigma)^3]$
measures asymmetry of the distribution (positive = right-skewed, negative =
left-skewed, zero = symmetric). The kurtosis $\kappa = \mathbb{E}[((X-\mu)/
\sigma)^4]$ measures how heavy-tailed the distribution is relative to a
Gaussian ($\kappa = 3$ for a Gaussian; excess kurtosis $\kappa - 3$ is often
used so a Gaussian has excess kurtosis 0).
[@chan2021probabilitydatascience, pp. 216--217]

**Moment-generating function (MGF):** The MGF of a random variable $X$ is
$M_X(s) = \mathbb{E}[e^{sX}]$. For discrete $X$,
$M_X(s) = \sum_{x \in \Omega} e^{sx}\, p_X(x)$; for continuous $X$,
$M_X(s) = \int_{-\infty}^{\infty} e^{sx}\, f_X(x)\, dx$. The MGF is the
Laplace transform of the PDF. It is called "moment-generating" because
differentiating $k$ times and evaluating at $s = 0$ yields the $k$th moment:
$\frac{d^k}{ds^k} M_X(s)\big|_{s=0} = \mathbb{E}[X^k]$. Not all random
variables have a well-defined MGF (e.g., the Cauchy), but every random variable
has a well-defined characteristic function $\Phi_X(j\omega) = \mathbb{E}[e^{-j\omega X}]$
(the Fourier transform of the PDF).
[@chan2021probabilitydatascience, pp. 324--331]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $\mathbb{E}[X]$ | "E of X" or "the expectation of X" | The probability-weighted average of $X$'s states. [@chan2021probabilitydatascience, p. 125] |
| $\mathbb{E}[g(X)]$ | "E of g of X" | The expectation of a function of $X$: $\sum_{x} g(x)\, p_X(x)$. [@chan2021probabilitydatascience, p. 131] |
| $\mathbb{E}[X^k]$ | "the k-th moment of X" | The $k$th moment: $\sum_x x^k\, p_X(x)$. [@chan2021probabilitydatascience, p. 133] |
| $\text{Var}[X]$ | "the variance of X" | $\mathbb{E}[(X - \mu)^2]$: the expected squared deviation from the mean. [@chan2021probabilitydatascience, p. 134] |
| $\sigma^2$ | "sigma squared" | Alternative notation for $\text{Var}[X]$. *(synthesis)* |
| $\sigma$ | "sigma" | Standard deviation: $\sqrt{\text{Var}[X]}$. [@chan2021probabilitydatascience, p. 134] |
| $\gamma$ | "gamma" or "the skewness" | Third central moment $\mathbb{E}[((X-\mu)/\sigma)^3]$: measures asymmetry. [@chan2021probabilitydatascience, p. 216] |
| $\kappa$ | "kappa" or "the kurtosis" | Fourth central moment $\mathbb{E}[((X-\mu)/\sigma)^4]$: measures tail heaviness. [@chan2021probabilitydatascience, p. 216] |
| $M_X(s)$ | "the MGF of X" or "M sub X of s" | $\mathbb{E}[e^{sX}]$: the moment-generating function (Laplace transform of the PDF). [@chan2021probabilitydatascience, p. 324] |
| $\Phi_X(j\omega)$ | "the characteristic function of X" | $\mathbb{E}[e^{-j\omega X}]$: the Fourier transform of the PDF; always exists, unlike the MGF. [@chan2021probabilitydatascience, p. 329] |

## Key results & derivations

- **Properties of expectation (Theorem 3.4)** -- four key properties:
  (i) **Function:** $\mathbb{E}[g(X)] = \sum_{x} g(x)\, p_X(x)$ (change of
  variable -- the key idea is that probabilities are attached to states, not to
  function values); (ii) **Linearity:**
  $\mathbb{E}[g(X) + h(X)] = \mathbb{E}[g(X)] + \mathbb{E}[h(X)]$;
  (iii) **Scale:** $\mathbb{E}[cX] = c\mathbb{E}[X]$;
  (iv) **DC shift:** $\mathbb{E}[X + c] = \mathbb{E}[X] + c$.
  [@chan2021probabilitydatascience, p. 131]

- **Variance via moments (Theorem 3.5(i))** -- the variance can be computed as
  $\text{Var}[X] = \mathbb{E}[X^2] - \mathbb{E}[X]^2$ (the second moment minus
  the square of the first moment). This is often the easiest route for
  computation. [@chan2021probabilitydatascience, p. 135]

- **Variance under scaling (Theorem 3.5(ii))** --
  $\text{Var}[cX] = c^2\,\text{Var}[X]$. Scaling a random variable by $c$
  scales the variance by $c^2$ (because of the square in the definition).
  [@chan2021probabilitydatascience, p. 135]

- **Variance under shift (Theorem 3.5(iii))** --
  $\text{Var}[X + c] = \text{Var}[X]$. Shifting a random variable by a constant
  does not change its spread. [@chan2021probabilitydatascience, p. 135]

- **Expectation as center of mass** -- the expectation is a deterministic number
  on the real line, not necessarily a state the random variable can take. It is
  the balance point (center of mass) where the "forces" of probability-weighted
  states balance. [@chan2021probabilitydatascience, pp. 127--128]

- **Expectation may not exist** -- a random variable with PMF
  $p_X(k) = 6/(\pi^2 k^2)$ for $k = 1, 2, \ldots$ has a valid PMF (sums to 1)
  but its expectation diverges because $\sum k/k = \sum 1/k = \infty$ (the
  harmonic series). [@chan2021probabilitydatascience, p. 130]

- **Expectation of function (Theorem 4.1)** -- for a continuous random variable
  $X$ and function $g$, $\mathbb{E}[g(X)] = \int_\Omega g(x)\, f_X(x)\, dx$.
  This is the continuous analog of Theorem 3.4.
  [@chan2021probabilitydatascience, p. 181]

- **Expectation bound (Theorem 4.2)** -- $|\mathbb{E}[X]| \le \mathbb{E}[|X|]$.
  Absolute integrability gives an upper bound on the expectation.
  [@chan2021probabilitydatascience, p. 183]

- **Expectation from CDF (Theorem 4.7)** -- the mean of any random variable
  can be computed from its CDF: $\mathbb{E}[X] = \int_0^{\infty}(1 - F_X(t))\,
  dt - \int_{-\infty}^{0} F_X(t)\,dt$. The proof uses change of integration
  order. [@chan2021probabilitydatascience, p. 200]

- **$\mathbb{E}[1/X] \ne 1/\mathbb{E}[X]$ in general** -- the expectation
  operator is linear but does not commute with nonlinear functions. Linearity
  means $\mathbb{E}[aX + b] = a\mathbb{E}[X] + b$, but
  $\mathbb{E}[g(X)] \ne g(\mathbb{E}[X])$ for nonlinear $g$.
  [@chan2021probabilitydatascience, p. 182]

- **MGF extracts moments (Theorem 6.1)** -- $M_X(0) = 1$,
  $\frac{d}{ds}M_X(s)\big|_{s=0} = \mathbb{E}[X]$, and
  $\frac{d^k}{ds^k}M_X(s)\big|_{s=0} = \mathbb{E}[X^k]$ for any positive
  integer $k$. The exponential $e^{sx}$ acts as a moment marker: each
  derivative brings down an $x$, and setting $s=0$ removes the exponential.
  [@chan2021probabilitydatascience, p. 325]

- **MGF of a sum of independent RVs (Theorem 6.2)** -- if $X$ and $Y$ are
  independent, $M_{X+Y}(s) = M_X(s) M_Y(s)$. For $N$ i.i.d. copies,
  $M_Z(s) = (M_{X_1}(s))^N$. This turns convolution of PDFs into
  multiplication of MGFs, which is the main reason MGFs are useful.
  [@chan2021probabilitydatascience, p. 327]

- **Moments summary table** -- Chan provides a table of mean, variance,
  skewness, and excess kurtosis for seven distributions: Bernoulli ($p$,
  $p(1-p)$), Binomial ($np$, $np(1-p)$), Geometric ($1/p$, $(1-p)/p^2$),
  Poisson ($\lambda$, $\lambda$), Uniform ($(a+b)/2$, $(b-a)^2/12$),
  Exponential ($1/\lambda$, $1/\lambda^2$), Gaussian ($\mu$, $\sigma^2$).
  The Gaussian has skewness 0 and excess kurtosis 0 -- it is the baseline.
  [@chan2021probabilitydatascience, p. 218]

## Prerequisites

- [random-variables-and-distributions](random-variables-and-distributions.md) --
  the PMF $p_X(x)$ is needed to define expectation.
- [probability-and-odds](probability-and-odds.md) -- the axioms guarantee the
  PMF properties that make expectation well-defined.

## Misconceptions & learner traps

- **Confusing expectation (from the PMF) with the sample average (from data)**
  -- the expectation $\mathbb{E}[X]$ is computed from the theoretical PMF; the
  sample average $\bar{x}$ is computed from observed data. The sample average
  approximates the expectation and converges to it as $N \to \infty$.
  [@chan2021probabilitydatascience, p. 126]

- **Thinking the expectation must be a possible state** -- for an unfair coin
  with $p = 3/4$, $\mathbb{E}[X] = 3/4$, which is not a state the random
  variable can take (it takes only 0 or 1). The expectation lives on the real
  line, not in the sample space. [@chan2021probabilitydatascience, p. 127]

- **Forgetting the $c^2$ in variance scaling** -- $\text{Var}[cX] = c^2\,\text{Var}[X]$, not $c\,\text{Var}[X]$. The square comes from the squared
  deviation in the variance definition.
  [@chan2021probabilitydatascience, p. 135]

## Teaching insights & analogies

- **"Expectation = Mean = Average computed from a PMF"** -- Chan's Key
  Concept 3. The three words refer to the same quantity computed in different
  contexts: expectation from theory (PMF), mean as the parameter, average from
  data (histogram). [@chan2021probabilitydatascience, p. 104]

- **Center of mass visualization** -- a PMF with two states can be visualized as
  two weights on a beam; the expectation is the fulcrum point where the beam
  balances. A heavier (higher-probability) state pulls the center of mass toward
  it. [@chan2021probabilitydatascience, p. 128]

- **Scaling stretches, shifting slides** -- multiplying $X$ by $c$ spreads the
  states wider (or narrows them), changing both the mean and the variance.
  Adding $c$ slides the entire PMF left or right, changing the mean but not the
  variance (the spread is unchanged). Figures 3.19 and 3.20 illustrate this.
  [@chan2021probabilitydatascience, pp. 131--132]

- **Variance as "the expected squared deviation"** -- reading the formula
  $\mathbb{E}[(X - \mu)^2]$ right to left: take the deviation from the mean,
  square it, then take the expectation (probability-weighted average) of that
  squared deviation. [@chan2021probabilitydatascience, pp. 134--135]

- **Mean, median, mode: three summary statistics** -- the mean is the center
  of mass (balance point); the median is the 50th percentile ($F_X(c) = 1/2$);
  the mode is the peak of the PDF ($\arg\max f_X$). For a symmetric
  unimodal distribution, all three coincide (a symmetric bimodal
  distribution has two modes that differ from the mean/median). For a
  skewed distribution, they differ, and
  skewness and kurtosis provide additional shape information beyond mean and
  variance. [@chan2021probabilitydatascience, pp. 196--198, 216]

- **The Cauchy: a valid distribution with no mean** -- the Cauchy distribution
  $f_X(x) = 1/(\pi(1+x^2))$ is a valid PDF (integrates to 1, non-negative
  everywhere) but has no finite expectation because the tails are too heavy.
  This shows that "having a PDF" does not guarantee a finite mean.
  [@chan2021probabilitydatascience, pp. 183--184]

- **MGF as "frequency domain for probability"** -- convolutions in the time
  domain become multiplications in the transform domain. The MGF does for sums
  of random variables what the Fourier transform does for convolutions in
  signal processing: it converts a hard integral into easy multiplication.
  [@chan2021probabilitydatascience, pp. 324, 327]

## How the field talks about it

The notation $\mathbb{E}[X]$ for expectation is universal in probability and
statistics. In machine learning, $\mathbb{E}_{X \sim p}[f(X)]$ explicitly names
the distribution. The variance is $\text{Var}[X]$ or $\sigma^2$, and
$\sigma$ is the standard deviation. The formula
$\text{Var}[X] = \mathbb{E}[X^2] - (\mathbb{E}[X])^2$ is a workhorse in
derivations. For discrete random variables, expectation is a sum; for continuous
random variables, it is an integral (the same idea with $\int$ replacing
$\sum$). [@chan2021probabilitydatascience, pp. 125, 133--135]
