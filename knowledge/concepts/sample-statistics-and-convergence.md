---
title: "Sample statistics and convergence"
topic: probability
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

The sample average $\overline{X}_N = \frac{1}{N}\sum_{n=1}^{N} X_n$ is a random
variable that summarizes a collection of i.i.d. observations. Two fundamental
theorems describe its behavior as $N$ grows: the law of large numbers says
$\overline{X}_N$ converges to the true mean $\mu$, and the central limit
theorem says the CDF of the standardized $\overline{X}_N$ converges to the
Gaussian CDF. Probability inequalities (Markov, Chebyshev, Chernoff,
Hoeffding, Jensen) provide the tools for bounding tail probabilities that
underpin these convergence results.
[@chan2021probabilitydatascience, pp. 319--323]

**Also known as:** sample mean (for $\overline{X}_N$); concentration
inequalities (for the probability-inequality family); limit theorems
(collective name for LLN and CLT)

## Definition(s)

**Sample average (Definition 6.5):** Given i.i.d. random variables
$X_1, \ldots, X_N$, the sample average is:
[@chan2021probabilitydatascience, p. 351]

$$\overline{X}_N = \frac{1}{N}\sum_{n=1}^{N} X_n.$$

Since each $X_n$ is random, $\overline{X}_N$ is itself a random variable with
a PDF, a mean ($\mathbb{E}[\overline{X}_N] = \mu$), and a variance
($\text{Var}[\overline{X}_N] = \sigma^2/N$). It is called a **statistic**
because it summarizes the microstates, and a **sample** statistic because it
is based on random samples.
[@chan2021probabilitydatascience, pp. 320, 351--352]

**Convex function (Definition 6.4):** A function $g$ is convex if for any
$0 \le \lambda \le 1$:
[@chan2021probabilitydatascience, p. 336]

$$g(\lambda x + (1-\lambda)y) \le \lambda g(x) + (1-\lambda) g(y).$$

For twice-differentiable functions, convexity is equivalent to
$g''(x) \ge 0$ everywhere. A concave function satisfies the reverse
inequality. [@chan2021probabilitydatascience, pp. 336--337]

**Convergence in probability (Definition 6.6):** A sequence of random
variables $A_1, A_2, \ldots$ converges in probability to a deterministic
number $\alpha$ if for every $\varepsilon > 0$:
[@chan2021probabilitydatascience, p. 357]

$$\lim_{N \to \infty} \mathbb{P}[|A_N - \alpha| > \varepsilon] = 0.$$

Written $A_N \xrightarrow{p} \alpha$. This says the probability of being
far from $\alpha$ vanishes, but at any finite $N$ bad outcomes remain possible.
[@chan2021probabilitydatascience, pp. 356--357]

**Almost sure convergence (Definition 6.7):** A sequence $A_1, A_2, \ldots$
converges almost surely to $\alpha$ if:
[@chan2021probabilitydatascience, p. 362]

$$\mathbb{P}\left[\lim_{N \to \infty} A_N = \alpha\right] = 1.$$

Written $A_N \xrightarrow{a.s.} \alpha$. This means the number of
"failures" ($A_N \ne \alpha$) is finite with probability 1; after those
finite failures, $A_N = \alpha$ forever. Almost sure convergence implies
convergence in probability, but not vice versa.
[@chan2021probabilitydatascience, pp. 361--364]

**Convergence in distribution (Definition 6.8):** A sequence
$Z_1, Z_2, \ldots$ with CDFs $F_{Z_1}, F_{Z_2}, \ldots$ converges in
distribution to a random variable $Z$ with CDF $F_Z$ if:
[@chan2021probabilitydatascience, p. 368]

$$\lim_{N \to \infty} F_{Z_N}(z) = F_Z(z)$$

for every continuous point $z$ of $F_Z$. Written $Z_N \xrightarrow{d} Z$.
This is weaker than convergence in probability: it says only that the CDF
values converge, not that the random variables themselves get close.
[@chan2021probabilitydatascience, pp. 368--371]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $\overline{X}_N$ | "X bar sub N" or "the sample average" | $(1/N)\sum_{n=1}^{N} X_n$; a random variable that is the mean of $N$ i.i.d. draws. [@chan2021probabilitydatascience, p. 351] |
| $\mu$ | "mu" or "the population mean" | $\mathbb{E}[X_n]$; the true mean that $\overline{X}_N$ converges to. [@chan2021probabilitydatascience, p. 351] |
| $Z_N$ | "Z sub N" or "the normalized sample average" | $\sqrt{N}\left(\frac{\overline{X}_N - \mu}{\sigma}\right)$; the standardized version used in the CLT. [@chan2021probabilitydatascience, p. 372] |
| $\xrightarrow{p}$ | "converges in probability" | The probability of deviation vanishes as $N \to \infty$. [@chan2021probabilitydatascience, p. 357] |
| $\xrightarrow{a.s.}$ | "converges almost surely" | The limit equals the target with probability 1. [@chan2021probabilitydatascience, p. 362] |
| $\xrightarrow{d}$ | "converges in distribution" | The CDF values converge pointwise. [@chan2021probabilitydatascience, p. 368] |
| $\Phi(z)$ | "Phi of z" | The CDF of the standard Gaussian: $\int_{-\infty}^{z} \frac{1}{\sqrt{2\pi}} e^{-t^2/2}\, dt$. [@chan2021probabilitydatascience, p. 372] |

## Key results & derivations

- **Markov's inequality (Theorem 6.11)** -- for any non-negative random variable
  $X \ge 0$ and $\varepsilon > 0$:
  $\mathbb{P}[X \ge \varepsilon] \le \mathbb{E}[X]/\varepsilon$. The proof
  uses $\varepsilon \cdot \mathbb{P}[X \ge \varepsilon] = \int_\varepsilon^\infty
  \varepsilon\, f_X(x)\, dx \le \int_\varepsilon^\infty x\, f_X(x)\, dx
  \le \mathbb{E}[X]$. Markov's inequality is simple but often loose.
  [@chan2021probabilitydatascience, p. 339]

- **Chebyshev's inequality (Theorem 6.12)** -- for any random variable $X$ with
  mean $\mu$: $\mathbb{P}[|X - \mu| \ge \varepsilon] \le
  \text{Var}[X]/\varepsilon^2$. The proof applies Markov's inequality to
  $(X - \mu)^2$. In the alternative form with $\varepsilon = k\sigma$:
  $\mathbb{P}[|X - \mu| \ge k\sigma] \le 1/k^2$.
  [@chan2021probabilitydatascience, pp. 341--342]

- **Chebyshev applied to the sample mean (Corollary 6.2)** -- for i.i.d.
  $X_1, \ldots, X_N$ with mean $\mu$ and variance $\sigma^2$:
  $\mathbb{P}[|\overline{X}_N - \mu| > \epsilon] \le \sigma^2/(N\epsilon^2)$.
  This bound vanishes as $N \to \infty$, which directly proves the WLLN.
  [@chan2021probabilitydatascience, p. 343]

- **Jensen's inequality (Theorem 6.10)** -- if $g$ is convex, then
  $\mathbb{E}[g(X)] \ge g(\mathbb{E}[X])$. If $g$ is concave, the inequality
  flips. Special cases: $\mathbb{E}[X^2] \ge (\mathbb{E}[X])^2$ (which gives
  $\text{Var}[X] \ge 0$), $\mathbb{E}[1/X] \ge 1/\mathbb{E}[X]$, and
  $\mathbb{E}[\log X] \le \log \mathbb{E}[X]$. The proof uses the tangent
  line at $\mathbb{E}[X]$ as a lower bound: since $g$ is convex,
  $g(X) \ge L(X) = aX + b$ for all $X$, so
  $\mathbb{E}[g(X)] \ge \mathbb{E}[L(X)] = a\mathbb{E}[X] + b = g(\mathbb{E}[X])$.
  [@chan2021probabilitydatascience, pp. 336--338]

- **Chernoff's bound (Theorem 6.13)** -- for any random variable $X$ and
  $\varepsilon \ge 0$: $\mathbb{P}[X \ge \varepsilon] \le e^{-\varphi(\varepsilon)}$,
  where $\varphi(\varepsilon) = \max_{s > 0}\{s\varepsilon - \log M_X(s)\}$
  (the Fenchel-Legendre dual of $\log M_X$). The proof uses two tricks:
  (1) the nonlinear transformation $\mathbb{P}[X \ge \varepsilon] =
  \mathbb{P}[e^{sX} \ge e^{s\varepsilon}]$, then (2) Markov's inequality on
  $e^{sX}$, then optimize over $s$. For a Gaussian with variance $\sigma^2/N$,
  this gives $\mathbb{P}[X \ge \varepsilon] \le \exp\{-\varepsilon^2 N/(2\sigma^2)\}$,
  which decays exponentially in $N$ (much tighter than Chebyshev's $O(1/N)$
  bound). [@chan2021probabilitydatascience, pp. 343--346]

- **Hoeffding's inequality (Theorem 6.15)** -- for i.i.d. random variables
  $X_1, \ldots, X_N$ with $0 \le X_n \le 1$ and $\mathbb{E}[X_n] = \mu$:
  $\mathbb{P}[|\overline{X}_N - \mu| > \epsilon] \le 2e^{-2\epsilon^2 N}$.
  This is derived from Chernoff's bound via Hoeffding's lemma and inherits
  exponential tightness. Its key advantage: it requires only boundedness, not
  knowledge of $\mathbb{E}[X]$ or $\text{Var}[X]$. It directly gives a
  confidence interval:
  $\overline{X}_N - \sqrt{\frac{1}{2N}\log\frac{2}{\delta}} \le \mu \le
  \overline{X}_N + \sqrt{\frac{1}{2N}\log\frac{2}{\delta}}$ with probability
  at least $1 - \delta$.
  [@chan2021probabilitydatascience, pp. 348--350]

- **Union bound (Theorem 6.8)** --
  $\mathbb{P}[\bigcup_{n=1}^{N} A_n] \le \sum_{n=1}^{N} \mathbb{P}[A_n]$.
  Tight when events are disjoint; loose when they overlap significantly.
  [@chan2021probabilitydatascience, pp. 333--334]

- **Weak law of large numbers (WLLN, Theorem 6.16)** -- for i.i.d. random
  variables with mean $\mu$ and finite variance $\sigma^2$:
  $\lim_{N \to \infty} \mathbb{P}[|\overline{X}_N - \mu| > \varepsilon] = 0$.
  The proof is one line from Chebyshev's inequality applied to the sample
  mean. The WLLN fails for the Cauchy distribution because it has infinite
  variance: the sample average of i.i.d. Cauchy RVs is again Cauchy (same
  distribution regardless of $N$).
  [@chan2021probabilitydatascience, pp. 354, 360]

- **Strong law of large numbers (SLLN, Theorem 6.18)** -- for i.i.d. random
  variables with mean $\mu$, finite variance $\sigma^2$, and finite fourth
  moment $\mathbb{E}[X_n^4] < \infty$:
  $\mathbb{P}[\lim_{N \to \infty} \overline{X}_N = \mu] = 1$. The strong law
  places the limit inside the probability (almost sure convergence), while the
  weak law places it outside (convergence in probability). The strong law
  guarantees a finite number of failures, then convergence forever.
  [@chan2021probabilitydatascience, pp. 361, 365--366]

- **Central Limit Theorem (Theorem 6.19)** -- for i.i.d. random variables with
  mean $\mu$, variance $\sigma^2$, and finite $\mathbb{E}[|X_n|^3]$, the
  normalized sample average $Z_N = \sqrt{N}\left(\frac{\overline{X}_N - \mu}
  {\sigma}\right)$ satisfies $\lim_{N \to \infty} F_{Z_N}(z) = \Phi(z)$ for
  all $z$, where $\Phi$ is the standard Gaussian CDF. Equivalently,
  $\overline{X}_N \xrightarrow{d} \text{Gaussian}(\mu, \sigma^2/N)$.
  The CLT does NOT say the PDF converges to a Gaussian PDF; it says only
  that the CDF values converge. For discrete RVs (e.g., binomial), the PDF
  is a train of delta functions that never becomes continuous.
  [@chan2021probabilitydatascience, pp. 367--372]

- **CLT practical corollary (Corollary 6.3)** -- for the sample average
  $\overline{X}_N$ of i.i.d. RVs with mean $\mu$ and variance $\sigma^2$:
  $\mathbb{P}[a \le \overline{X}_N \le b] \approx
  \Phi\left(\sqrt{N}\frac{b-\mu}{\sigma}\right) -
  \Phi\left(\sqrt{N}\frac{a-\mu}{\sigma}\right)$.
  [@chan2021probabilitydatascience, p. 373]

## Prerequisites

- [expectation-and-moments](expectation-and-moments.md) -- the mean $\mu$
  and variance $\sigma^2$ are the parameters the sample average converges to.
- [joint-distributions](joint-distributions.md) -- i.i.d. random variables
  and the variance of a sum (Theorem 5.4) underpin the WLLN proof.
- [random-variables-and-distributions](random-variables-and-distributions.md) --
  CDF and PDF framework for stating convergence results.
- [continuous-named-distributions](continuous-named-distributions.md) -- the
  Gaussian CDF $\Phi$ is the target of the CLT.

## Misconceptions & learner traps

- **"The CLT says the sample average becomes Gaussian"** -- WRONG. The CLT says
  only that the CDF of $\overline{X}_N$ converges to the Gaussian CDF. The
  sample average of Bernoulli RVs is always a binomial (a discrete
  distribution), never a Gaussian; but its CDF values approach those of a
  Gaussian. [@chan2021probabilitydatascience, pp. 368--369]

- **"Small probability means impossible"** -- a probability converging to zero
  (as in the WLLN) does not exclude the event at any finite $N$. The weak law
  only guarantees the probability shrinks; the strong law guarantees a finite
  number of failures. Chan emphasizes: "Having a small probability does not
  mean that the outlier is impossible. It does not say that it will surely not
  happen." [@chan2021probabilitydatascience, p. 354]

- **Confusing convergence types** -- the ordering from strongest to weakest is:
  deterministic convergence $\Rightarrow$ almost sure convergence $\Rightarrow$
  convergence in probability $\Rightarrow$ convergence in distribution. The key
  difference between weak and strong LLN is that the weak law puts the limit
  outside the probability ($\lim \mathbb{P}[\cdot]$) while the strong law puts
  it inside ($\mathbb{P}[\lim \cdot]$).
  [@chan2021probabilitydatascience, pp. 361, 381]

- **"Chebyshev and Chernoff give similar bounds"** -- Chebyshev's bound decays
  as $O(1/N)$ (polynomial), while Chernoff's decays as $O(e^{-cN})$
  (exponential). For a Gaussian with $\sigma = 1$ and $\varepsilon = 0.1$,
  Chebyshev says $N \ge 2000$ samples suffice for 95% confidence, while
  Chernoff says $N \ge 600$ -- more than 3x fewer. Chebyshev is
  distribution-free but overly conservative.
  [@chan2021probabilitydatascience, pp. 346--347]

- **"The WLLN holds for all distributions"** -- the WLLN requires finite
  variance. The Cauchy distribution has infinite variance, so its sample
  average does not converge: $\overline{X}_N$ for i.i.d. Cauchy RVs is itself
  Cauchy with the same parameter regardless of $N$.
  [@chan2021probabilitydatascience, p. 360]

## Teaching insights & analogies

- **Micro vs. macro descriptions** -- the power of probability is its ability
  to summarize microstates (individual data points) using macro descriptions
  (the sample average). Instead of studying the joint PDF
  $f_{X_1, \ldots, X_N}$ (intractable for large $N$), we study
  $\overline{X}_N$ and get most of the information we need.
  [@chan2021probabilitydatascience, pp. 319--320]

- **Probabilistic vs. worst-case guarantee** -- a 100% guarantee
  (deterministic: no defects ever) is much more expensive than a 99.99%
  guarantee (probabilistic: one failure per 10,000 trials on average). The
  birthday paradox illustrates: we need 366 people for a 100% guarantee of a
  shared birthday, but only 23 for a 50% probability.
  [@chan2021probabilitydatascience, pp. 321--322]

- **Ladder of inequalities** -- each inequality in the chain (Markov $\to$
  Chebyshev $\to$ Chernoff $\to$ Hoeffding) uses more information about the
  distribution and gets a tighter bound. Markov needs only $\mathbb{E}[X]$;
  Chebyshev adds $\text{Var}[X]$; Chernoff uses the full MGF; Hoeffding needs
  only boundedness ($0 \le X \le 1$) but gets exponential decay.
  [@chan2021probabilitydatascience, pp. 339--350]

- **Jensen's intuition via convex warping** -- applying a convex function
  $g(\cdot)$ to a random variable $X$ warps the PDF asymmetrically: the
  convex curvature pushes the mean of $g(X)$ above $g(\text{mean of } X)$.
  The tangent-line proof makes this geometric: $g(X) \ge L(X)$ always, where
  $L$ is the tangent at $\mathbb{E}[X]$, so
  $\mathbb{E}[g(X)] \ge \mathbb{E}[L(X)] = g(\mathbb{E}[X])$.
  [@chan2021probabilitydatascience, pp. 337--338]

- **Shrinking PDFs visualization** -- as $N$ grows, the PDF of
  $\overline{X}_N$ becomes narrower (variance $\sigma^2/N$ shrinks),
  concentrating around $\mu$. Figure 6.13 illustrates this as a sequence of
  distributions getting thinner, with the probability in the tails vanishing.
  [@chan2021probabilitydatascience, pp. 352, 355--356]

- **Weak vs. strong law: electronic dictionary analogy** -- the weak law says
  if you use the dictionary long enough, the probability of an error becomes
  very small (99.99% guarantee). The strong law says after a finite number of
  errors, the dictionary becomes perfectly error-free forever (100% guarantee).
  The strong law does not say when this happens, only that it does.
  [@chan2021probabilitydatascience, p. 361]

- **Dice convolution for CLT** -- rolling 1 die gives a uniform distribution;
  rolling 2 gives a triangle; rolling 5 gives something very Gaussian. This
  sequence of experiments makes the CLT tangible: the sum of independent RVs
  has a CDF that approaches the Gaussian CDF.
  [@chan2021probabilitydatascience, p. 367]

- **CLT limitation at the tails** -- the CLT approximation is good near the
  mean but poor in the tails. For tail probabilities, Chernoff's bound is
  needed. The limitation comes from the CLT being a second-order approximation
  (it matches the first two moments of the MGF); if the third moment is large,
  convergence is slow. [@chan2021probabilitydatascience, p. 380]

- **Student's $t$-distribution converges to Gaussian** -- The Student's
  $t$-distribution with $\nu$ degrees of freedom has the PDF
  $f_X(x) = \frac{\Gamma((\nu+1)/2)}{\sqrt{\nu\pi}\,\Gamma(\nu/2)}
  (1 + x^2/\nu)^{-(\nu+1)/2}$. As $\nu \to \infty$, this converges to the
  standard Gaussian $\frac{1}{\sqrt{2\pi}}e^{-x^2/2}$ (Theorem 9.1, proved
  via Stirling's approximation). The practical implication: for the sample
  mean estimator with unknown variance, use Student's $t$ when $N \le 30$
  and the Gaussian when $N \ge 30$. If the underlying $X_n$ are Gaussian,
  $t$ is exact; if not, $t$ is an approximation that improves as $N$ grows.
  [@chan2021probabilitydatascience, pp. 556--561, Def. 9.1, Thm. 9.1]

- **Hoeffding in machine learning** -- Hoeffding's inequality is fundamental in
  learning theory for bounding generalization error. It connects the number of
  training samples, model complexity, and the gap between training and test
  error. [@chan2021probabilitydatascience, pp. 350--351]

## How the field talks about it

The notation $\overline{X}_N$ or $\bar{X}$ for the sample average is
universal. "LLN" and "CLT" are standard abbreviations. In statistics,
$\overline{X}_N \xrightarrow{p} \mu$ (convergence in probability) and
$\sqrt{N}(\overline{X}_N - \mu)/\sigma \xrightarrow{d} N(0,1)$ (convergence
in distribution) are the standard statements. The hierarchy of convergence
types (a.s. $\Rightarrow$ in prob. $\Rightarrow$ in distribution) is covered
in most probability textbooks. In applied statistics, the CLT justifies using
Gaussian-based confidence intervals and hypothesis tests even when the
underlying distribution is unknown, provided $N$ is "large enough" (often
cited as $N \ge 30$, though the actual requirement depends on the skewness of
the distribution). In R, `pnorm()` evaluates $\Phi(z)$; in Python,
`scipy.stats.norm.cdf(z)`.
[@chan2021probabilitydatascience, pp. 354, 367--373, 381]
