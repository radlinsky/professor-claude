---
title: "Continuous named distributions"
topic: probability
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

Three fundamental continuous distributions -- uniform, exponential, and Gaussian
-- form the core toolkit for modeling continuous outcomes. Each arises from a
specific physical setting: the uniform from maximal ignorance over an interval,
the exponential from the interarrival time between Poisson events, and the
Gaussian from the sum of many independent random variables (the Central Limit
Theorem). [@chan2021probabilitydatascience, pp. 201--223]

**Also known as:** standard distributions, parametric families

## Definition(s)

**Uniform random variable:** A continuous random variable $X$ with constant
density over an interval $[a, b]$. The PDF is:
[@chan2021probabilitydatascience, p. 202]

$$f_X(x) = \begin{cases} \frac{1}{b-a}, & a \le x \le b, \\ 0, & \text{otherwise.}\end{cases}$$

We write $X \sim \text{Uniform}(a, b)$. The CDF is $F_X(x) = (x-a)/(b-a)$
for $a \le x \le b$, rising linearly from 0 to 1. Every sub-interval of equal
length has the same probability: the uniform distribution encodes "no
preference" over the interval. [@chan2021probabilitydatascience, pp. 202--203]

**Exponential random variable:** A continuous random variable $X$ with PDF:
[@chan2021probabilitydatascience, p. 205]

$$f_X(x) = \begin{cases} \lambda e^{-\lambda x}, & x \ge 0, \\ 0, & \text{otherwise,}\end{cases}$$

where $\lambda > 0$ is the rate parameter. We write
$X \sim \text{Exponential}(\lambda)$. The CDF is
$F_X(x) = 1 - e^{-\lambda x}$ for $x \ge 0$. A larger $\lambda$ means
faster exponential decay (shorter expected wait time).
[@chan2021probabilitydatascience, p. 205]

**Gaussian (normal) random variable:** A continuous random variable $X$ with
PDF: [@chan2021probabilitydatascience, p. 211]

$$f_X(x) = \frac{1}{\sqrt{2\pi\sigma^2}} \exp\left\{-\frac{(x-\mu)^2}{2\sigma^2}\right\},$$

where $\mu$ is the mean and $\sigma^2$ is the variance. We write
$X \sim \text{Gaussian}(\mu, \sigma^2)$ or $X \sim \mathcal{N}(\mu, \sigma^2)$.
The Gaussian is symmetric about $\mu$, bell-shaped, and positive on all of
$\mathbb{R}$. Its two parameters are exactly the first moment and the second
central moment -- most other distributions do not have this property.
[@chan2021probabilitydatascience, pp. 211--212]

**Standard Gaussian:** A Gaussian with $\mu = 0$ and $\sigma^2 = 1$, denoted
$X \sim \mathcal{N}(0, 1)$. Its PDF is
$f_X(x) = \frac{1}{\sqrt{2\pi}} e^{-x^2/2}$ and its CDF is the
$\Phi$ function: $\Phi(x) = \frac{1}{\sqrt{2\pi}}\int_{-\infty}^{x}
e^{-t^2/2}\,dt$. There is no closed-form expression for $\Phi$; it must be
evaluated numerically (via tables, `pnorm` in R, or `stats.norm.cdf` in
Python). [@chan2021probabilitydatascience, pp. 213--214]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $X \sim \text{Uniform}(a, b)$ | "X follows a uniform on a to b" | $X$ has constant density $1/(b-a)$ on $[a,b]$. [@chan2021probabilitydatascience, p. 202] |
| $X \sim \text{Exponential}(\lambda)$ | "X follows an exponential with rate lambda" | $X$ has PDF $\lambda e^{-\lambda x}$ for $x \ge 0$. [@chan2021probabilitydatascience, p. 205] |
| $X \sim \mathcal{N}(\mu, \sigma^2)$ | "X follows a normal with mean mu and variance sigma squared" | $X$ is Gaussian with the specified parameters. [@chan2021probabilitydatascience, p. 211] |
| $\Phi(x)$ | "Phi of x" | The CDF of the standard Gaussian $\mathcal{N}(0,1)$. [@chan2021probabilitydatascience, p. 214] |
| $\text{erf}(x)$ | "the error function at x" | $\text{erf}(x) = \frac{2}{\sqrt{\pi}}\int_0^x e^{-t^2}\,dt$; related to $\Phi$ by $\Phi(x) = \frac{1}{2}[1 + \text{erf}(x/\sqrt{2})]$. [@chan2021probabilitydatascience, p. 214] |

## Key results & derivations

- **Uniform moments (Theorem 4.8)** -- if $X \sim \text{Uniform}(a, b)$, then
  $\mathbb{E}[X] = (a+b)/2$ and $\text{Var}[X] = (b-a)^2/12$. The mean is the
  midpoint; the variance depends only on the interval width.
  [@chan2021probabilitydatascience, p. 204]

- **Exponential moments (Theorem 4.9)** -- if $X \sim \text{Exponential}(\lambda)$,
  then $\mathbb{E}[X] = 1/\lambda$ and $\text{Var}[X] = 1/\lambda^2$. The mean
  waiting time is the reciprocal of the rate. The proofs use integration by
  parts. [@chan2021probabilitydatascience, p. 207]

- **Exponential origin from Poisson process** -- if arrivals follow a Poisson
  process with rate $\lambda$, the interarrival time $T$ between consecutive
  events is $\text{Exponential}(\lambda)$. The derivation uses
  $\mathbb{P}[T > t] = \mathbb{P}[\text{no arrival in } t] = e^{-\lambda t}$
  (the Poisson PMF at $k=0$), giving $F_T(t) = 1 - e^{-\lambda t}$ and
  $f_T(t) = \lambda e^{-\lambda t}$.
  [@chan2021probabilitydatascience, pp. 207--208]

- **Gaussian moments (Theorem 4.10)** -- if $X \sim \mathcal{N}(\mu, \sigma^2)$,
  then $\mathbb{E}[X] = \mu$ and $\text{Var}[X] = \sigma^2$. The proof uses the
  substitution $y = (x - \mu)/\sigma$ and the fact that
  $ye^{-y^2/2}$ is odd (integrates to 0) and
  $\frac{1}{\sqrt{2\pi}}\int_{-\infty}^{\infty} e^{-y^2/2}\,dy = 1$.
  [@chan2021probabilitydatascience, p. 213]

- **CDF of arbitrary Gaussian (Theorem 4.11)** -- if
  $X \sim \mathcal{N}(\mu, \sigma^2)$, then
  $F_X(x) = \Phi\left(\frac{x - \mu}{\sigma}\right)$. This reduces any
  Gaussian probability to a standard-Gaussian table lookup. Consequently,
  $\mathbb{P}[a < X \le b] = \Phi\left(\frac{b-\mu}{\sigma}\right) -
  \Phi\left(\frac{a-\mu}{\sigma}\right)$.
  [@chan2021probabilitydatascience, p. 215]

- **Symmetry of $\Phi$ (Corollary 4.1)** -- $\Phi(y) = 1 - \Phi(-y)$. This
  follows from the symmetry of the standard Gaussian PDF about 0.
  [@chan2021probabilitydatascience, p. 216]

- **Origin of the Gaussian: convolution and CLT** -- the PDF of a sum
  $Z = X_1 + \cdots + X_N$ of independent random variables is the convolution
  of their individual PDFs. As $N$ grows, repeated convolution produces a
  bell shape provided the individual distributions have finite nonzero
  variance -- this is the Central Limit Theorem. The Gaussian's Fourier transform is itself a Gaussian, so the
  product of Fourier transforms (convolution in frequency domain) remains
  Gaussian. [@chan2021probabilitydatascience, pp. 220--222]

- **Gaussian skewness and kurtosis** -- the Gaussian has skewness 0 (perfectly
  symmetric) and excess kurtosis 0 (the baseline for tail heaviness). Positive
  excess kurtosis indicates heavier tails than a Gaussian; negative indicates
  lighter tails. [@chan2021probabilitydatascience, pp. 217--218]

## Prerequisites

- [random-variables-and-distributions](random-variables-and-distributions.md) --
  the PDF, CDF, and integration-based probability definitions are needed.
- [expectation-and-moments](expectation-and-moments.md) -- expectation, variance,
  and the moment shortcut $\text{Var}[X] = \mathbb{E}[X^2] - \mu^2$ are used
  to derive each distribution's moments.
- [discrete-named-distributions](discrete-named-distributions.md) -- the Poisson
  distribution is needed to derive the exponential's origin.

## Misconceptions & learner traps

- **Confusing the Gaussian parameters $(\mu, \sigma^2)$ with sample statistics**
  -- the parameters $\mu$ and $\sigma^2$ are the true (population) mean and
  variance of the distribution. The sample mean $\bar{x}$ and sample variance
  $s^2$ are estimates computed from data; they approximate $\mu$ and $\sigma^2$.
  [@chan2021probabilitydatascience, pp. 211--212]

- **"The PDF can't exceed 1"** -- wrong for continuous distributions. A
  $\text{Uniform}(0.2, 0.6)$ has PDF $f_X(x) = 2.5$ on $[0.2, 0.6]$. The PDF
  is probability per unit length, not a probability; only its integral over an
  interval is a probability. [@chan2021probabilitydatascience, p. 202]

- **The exponential is not the continuous version of the geometric** -- although
  both involve "time until first success," the geometric counts discrete trials
  while the exponential measures continuous time. The connection is through the
  Poisson process: exponential interarrival times produce Poisson counts.
  [@chan2021probabilitydatascience, pp. 207--208]

- **Thinking every bell-shaped distribution is Gaussian** -- many distributions
  (e.g., $t$-distribution, logistic) are bell-shaped but differ in tail
  behavior (kurtosis). The Gaussian is specific: its shape is fully determined
  by two parameters, and it has excess kurtosis 0.
  [@chan2021probabilitydatascience, p. 217]

- **Assuming normality without checking** -- the Gaussian arises from sums of
  many independent variables (CLT), but individual measurements, counts, or
  bounded quantities are often not Gaussian. The origin story (CLT via
  convolution) is the guide for when the model is appropriate.
  [@chan2021probabilitydatascience, pp. 222--223]

## Teaching insights & analogies

- **Uniform = "I don't know, so every value is equally likely"** -- the uniform
  distribution represents maximal ignorance over a finite interval. It is the
  starting point for random number generation: generate
  $U \sim \text{Uniform}(0,1)$, then transform via the inverse CDF to obtain
  any other distribution. [@chan2021probabilitydatascience, pp. 201, 228--229]

- **Exponential = "time between events"** -- the exponential is the continuous
  sibling of the Poisson: Poisson counts events in a fixed interval, exponential
  measures the time between consecutive events. If buses arrive at rate
  $\lambda$ per hour, the waiting time is
  $\text{Exponential}(\lambda)$ with mean $1/\lambda$ hours.
  [@chan2021probabilitydatascience, pp. 207--208]

- **Why Gaussians are everywhere** -- the CLT explains that any sum (or
  average) of many independent random variables converges to a Gaussian. Since
  most measured quantities are aggregates of many small effects (sensor noise =
  sum of thermal fluctuations, test score = sum of many item responses), the
  Gaussian naturally appears. [@chan2021probabilitydatascience, pp. 220--222]

- **Dice-rolling demonstration** -- throwing one die gives a uniform distribution
  on $\{1,\ldots,6\}$. Summing two dice gives a triangle. Summing five dice
  approximates a bell curve. Summing 100 dice is visually indistinguishable from
  a Gaussian. This progression makes the CLT tangible.
  [@chan2021probabilitydatascience, pp. 220--221]

- **Standardization as a coordinate change** -- any Gaussian
  $\mathcal{N}(\mu, \sigma^2)$ can be converted to the standard Gaussian by
  $Z = (X - \mu)/\sigma$. This is not a new distribution -- it is the same
  distribution expressed in "standard deviation units" from the mean. All
  Gaussian probabilities reduce to $\Phi$ table lookups.
  [@chan2021probabilitydatascience, p. 215]

## How the field talks about it

"Gaussian" and "normal" are used interchangeably; "Gaussian" is more common in
engineering and machine learning, "normal" in statistics. The notation
$\mathcal{N}(\mu, \sigma^2)$ is universal; note the second parameter is the
variance $\sigma^2$, not the standard deviation (some software parameterizes
with $\sigma$, which causes errors). In R, `dunif/punif/qunif/runif` for
uniform, `dexp/pexp/qexp/rexp` for exponential, `dnorm/pnorm/qnorm/rnorm` for
Gaussian, following the `d/p/q/r` convention: `d` = density/PMF, `p` = CDF,
`q` = quantile (inverse CDF), `r` = random generation.
[@chan2021probabilitydatascience, pp. 202--214]
