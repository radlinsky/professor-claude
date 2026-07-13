---
title: "Discrete named distributions"
topic: probability
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

Four commonly used discrete random variables -- Bernoulli, binomial, geometric,
and Poisson -- form the standard toolbox for modeling countable outcomes. Each
arises from a specific physical or experimental setting, and understanding those
origins (not just the formulas) tells you when each model is appropriate and
when it will fail. [@chan2021probabilitydatascience, pp. 136--160]

## Definition(s)

**Bernoulli random variable:** A coin-flip random variable with two states (0
and 1). The PMF is: [@chan2021probabilitydatascience, p. 137]

$$p_X(0) = 1 - p, \qquad p_X(1) = p,$$

where $0 < p < 1$ is the Bernoulli parameter. We write $X \sim \text{Bernoulli}(p)$.

**Binomial random variable:** The number of successes in $n$ independent
Bernoulli trials, each with success probability $p$. The PMF is:
[@chan2021probabilitydatascience, p. 143]

$$p_X(k) = \binom{n}{k} p^k (1-p)^{n-k}, \qquad k = 0, 1, \ldots, n.$$

We write $X \sim \text{Binomial}(n, p)$. The three components of the PMF
are: $\binom{n}{k}$ (number of combinations), $p^k$ (probability of $k$
successes), and $(1-p)^{n-k}$ (probability of $n-k$ failures).
[@chan2021probabilitydatascience, p. 144]

**Geometric random variable:** The number of trials until the first success in
a sequence of independent Bernoulli trials. The PMF is:
[@chan2021probabilitydatascience, pp. 149--150]

$$p_X(k) = (1-p)^{k-1} p, \qquad k = 1, 2, \ldots,$$

where $p$ is the success probability. We write $X \sim \text{Geometric}(p)$.
The formula reads as: $k-1$ consecutive failures (each with probability
$1-p$) followed by one success (probability $p$). Unlike the binomial, there
is no $\binom{n}{k}$ factor because the ordering of failures and the final
success is fixed. [@chan2021probabilitydatascience, p. 150]

**Poisson random variable:** Models the number of arrivals (events) in a fixed
interval, where arrivals are independent and occur at a constant rate. The PMF
is: [@chan2021probabilitydatascience, p. 152]

$$p_X(k) = \frac{\lambda^k}{k!} e^{-\lambda}, \qquad k = 0, 1, 2, \ldots,$$

where $\lambda > 0$ is the **rate** parameter. We write
$X \sim \text{Poisson}(\lambda)$. The Poisson is distinguished by the property
that its mean and variance are both equal to $\lambda$.
[@chan2021probabilitydatascience, pp. 152, 155]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $X \sim \text{Bernoulli}(p)$ | "X follows a Bernoulli with parameter p" | $X$ is a coin flip with success probability $p$. [@chan2021probabilitydatascience, p. 137] |
| $X \sim \text{Binomial}(n, p)$ | "X follows a binomial with n trials and probability p" | $X$ counts successes in $n$ independent trials. [@chan2021probabilitydatascience, p. 143] |
| $X \sim \text{Geometric}(p)$ | "X follows a geometric with parameter p" | $X$ counts trials until first success. [@chan2021probabilitydatascience, p. 150] |
| $X \sim \text{Poisson}(\lambda)$ | "X follows a Poisson with rate lambda" | $X$ counts independent arrivals at rate $\lambda$. [@chan2021probabilitydatascience, p. 152] |
| $\binom{n}{k}$ | "n choose k" | The binomial coefficient $\frac{n!}{k!(n-k)!}$: the number of ways to choose $k$ items from $n$. [@chan2021probabilitydatascience, p. 144] |

## Key results & derivations

- **Bernoulli moments (Theorem 3.6)** -- if $X \sim \text{Bernoulli}(p)$, then
  $\mathbb{E}[X] = p$, $\mathbb{E}[X^2] = p$, and
  $\text{Var}[X] = p(1-p)$. The variance is maximized at $p = 1/2$ (a fair
  coin has maximum uncertainty) and equals zero at $p = 0$ or $p = 1$ (certain
  outcomes have no variability). [@chan2021probabilitydatascience, pp. 138, 140]

- **Binomial as sum of Bernoullis** -- if $I_1, \ldots, I_n$ are independent
  $\text{Bernoulli}(p)$ random variables, then
  $X = I_1 + \cdots + I_n \sim \text{Binomial}(n, p)$. This decomposition
  simplifies proofs: $\mathbb{E}[X] = n\mathbb{E}[I_1] = np$ by linearity; $\text{Var}[X] = n\,\text{Var}[I_1] = np(1-p)$ by independence.
  [@chan2021probabilitydatascience, p. 148]

- **Binomial moments (Theorem 3.7)** -- if $X \sim \text{Binomial}(n, p)$, then
  $\mathbb{E}[X] = np$, $\mathbb{E}[X^2] = np(np + (1-p))$, and
  $\text{Var}[X] = np(1-p)$. The direct proof of $\mathbb{E}[X] = np$ uses an
  index-shifting trick to recognize the remaining sum as a
  $\text{Binomial}(n-1, p)$ PMF summing to 1.
  [@chan2021probabilitydatascience, pp. 146--147]

- **Geometric moments (Theorem 3.8)** -- if $X \sim \text{Geometric}(p)$, then
  $\mathbb{E}[X] = 1/p$, $\mathbb{E}[X^2] = 2/p^2 - 1/p$, and
  $\text{Var}[X] = (1-p)/p^2$. The mean $1/p$ has a natural interpretation: if
  each trial succeeds with probability $p$, on average you need $1/p$ trials.
  [@chan2021probabilitydatascience, pp. 151--152]

- **Poisson moments (Theorem 3.9)** -- if $X \sim \text{Poisson}(\lambda)$, then
  $\mathbb{E}[X] = \lambda$, $\mathbb{E}[X^2] = \lambda + \lambda^2$, and
  $\text{Var}[X] = \lambda$. The mean equals the variance -- a distinctive
  property of the Poisson. [@chan2021probabilitydatascience, pp. 155--156]

- **Poisson approximation to binomial (Theorem 3.10)** -- for large $n$ and
  small $p$ with $\lambda = np$ fixed, the binomial PMF converges to the
  Poisson PMF: $\binom{n}{k} p^k(1-p)^{n-k} \approx \frac{\lambda^k}{k!}
  e^{-\lambda}$. The proof uses $(1 - \lambda/n)^n \to e^{-\lambda}$ as
  $n \to \infty$. This is practically useful when $n$ is too large for
  factorial computation. [@chan2021probabilitydatascience, pp. 159--160]

- **Origin of the Poisson PMF** -- derived from three physical hypotheses about
  an arrival process: (i) the probability of one arrival in a short interval
  $\Delta t$ is $\lambda \Delta t$; (ii) the probability of more than one
  arrival in $\Delta t$ is negligible; (iii) arrivals in non-overlapping
  intervals are independent. These lead to the ODE
  $\frac{d}{dt}\mathbb{P}[X(t) = k] = \lambda(\mathbb{P}[X(t) = k-1] - \mathbb{P}[X(t) = k])$,
  whose solution is the Poisson PMF $\frac{(\lambda t)^k}{k!}e^{-\lambda t}$.
  [@chan2021probabilitydatascience, pp. 157--158]

## Prerequisites

- [random-variables-and-distributions](random-variables-and-distributions.md) --
  the PMF, CDF, and state-space concepts are needed to define each distribution.
- [expectation-and-moments](expectation-and-moments.md) -- expectation, variance,
  and moments are used to characterize each distribution.
- [conditional-probability](conditional-probability.md) -- independence
  (required for binomial, geometric, and Poisson derivations) is defined via
  conditional probability.

## Misconceptions & learner traps

- **Thinking the binomial coefficient counts probabilities** -- the
  $\binom{n}{k}$ factor counts the number of orderings, not probabilities. It
  appears because the $k$ successes can occur in any positions among the $n$
  trials, and each ordering has the same probability $p^k(1-p)^{n-k}$.
  [@chan2021probabilitydatascience, p. 144]

- **Confusing binomial and geometric** -- the binomial counts the number of
  successes in a fixed number of trials ($n$ is fixed, $k$ varies); the
  geometric counts the number of trials until the first success ($k$ varies
  with no upper bound). [@chan2021probabilitydatascience, pp. 143, 149]

- **Using Poisson when arrivals are not independent** -- the Poisson model
  requires independent arrivals. If there is scattering, clustering, or
  other dependencies between events, the Poisson PMF does not apply.
  [@chan2021probabilitydatascience, p. 158]

- **As $n$ increases, binomial approaches Gaussian** -- for fixed $p$ (not
  small), increasing $n$ makes the binomial PMF bell-shaped and symmetric,
  approaching the Gaussian distribution. This is a consequence of the central
  limit theorem, not the Poisson approximation (which requires small $p$).
  [@chan2021probabilitydatascience, p. 146]

## Teaching insights & analogies

- **Understanding the physics behind the model** -- Chan emphasizes that
  understanding the origin of each distribution (e.g. coin flips for Bernoulli,
  arrival processes for Poisson) is more important than memorizing the PMF
  formulas. The origin tells you when the model applies and when it breaks.
  [@chan2021probabilitydatascience, pp. 136--137]

- **Bernoulli variance is maximized at $p = 1/2$** -- this has a natural
  interpretation: a fair coin flip has maximum uncertainty (you have no idea
  which side will come up). As the coin becomes more biased ($p \to 0$ or
  $p \to 1$), uncertainty decreases and so does the variance.
  [@chan2021probabilitydatascience, p. 140]

- **Poisson signal-to-noise ratio** -- for a Poisson random variable,
  $\text{SNR} = \mathbb{E}[Y] / \sqrt{\text{Var}[Y]} = \lambda / \sqrt{\lambda} = \sqrt{\lambda}$. Brighter images (larger $\lambda$)
  have both more signal and more noise, but the SNR grows as $\sqrt{\lambda}$,
  so brighter scenes look cleaner despite higher absolute noise.
  [@chan2021probabilitydatascience, pp. 163--164]

- **Erdos-Renyi graph** -- the simplest random graph model: each edge is an
  independent $\text{Bernoulli}(p)$ draw. The parameter $p$ controls graph
  density. This connects the abstract Bernoulli to network science.
  [@chan2021probabilitydatascience, pp. 141--142]

## How the field talks about it

The notation $X \sim \text{Distribution}(\text{parameters})$ is standard. In R,
the four distributions have functions with the `d/p/q/r` prefix convention:
`dbinom`, `dpois`, `dgeom` for PMFs; `pbinom` etc. for CDFs; `rbinom` etc. for
random generation. The Poisson approximation to the binomial is a standard
textbook result invoked whenever $n$ is large and $p$ is small (the "rare
events" regime). The Bernoulli is sometimes treated as a special case of
the binomial with $n = 1$ rather than a separate distribution.
[@chan2021probabilitydatascience, pp. 137--160]
