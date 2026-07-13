---
title: "Random variables and distributions"
topic: probability
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

A random variable is a function $X : \Omega \to \mathbb{R}$ that maps each
outcome in a sample space to a number on the real line, providing a numerical
encoding of random experiments. Its probability structure is fully
characterized by its probability mass function (PMF) for discrete variables or
probability density function (PDF) for continuous variables.
[@chan2021probabilitydatascience, pp. 105--110]

**Also known as:** RV, stochastic variable

## Definition(s)

**Random variable:** A random variable $X$ is a function
$X : \Omega \to \mathbb{R}$ that maps an outcome $\xi \in \Omega$ to a number
$X(\xi)$ on the real line. [@chan2021probabilitydatascience, p. 105]

The values $X$ can take are called its **states**, and the set of all states is
denoted $X(\Omega)$. The variable $X$ is the function; a state $x$ is a
particular value it assigns. When we write $\mathbb{P}[X = x]$, we mean
$\mathbb{P}[\{\xi \in \Omega \mid X(\xi) = x\}]$ -- the probability of the
**pre-image** $X^{-1}(x) = \{\xi \in \Omega \mid X(\xi) = x\}$.
[@chan2021probabilitydatascience, pp. 108--109]

The mapping is not necessarily one-to-one: multiple outcomes can map to the
same state. [@chan2021probabilitydatascience, p. 107]

**Probability mass function (PMF):** The PMF of a discrete random variable $X$
is a function specifying the probability of obtaining each state:
[@chan2021probabilitydatascience, p. 110]

$$p_X(x) = \mathbb{P}[X = x].$$

The PMF provides a complete characterization of a discrete random variable: if
you know the PMF, you know everything about the random variable's probability
structure, and vice versa. Two random variables with the same PMF are
effectively the same (though they may have different underlying sample spaces).
[@chan2021probabilitydatascience, pp. 110--111]

**Cumulative distribution function (CDF):** The CDF of a discrete random
variable $X$ with states $\{x_1, x_2, \ldots\}$ is:
[@chan2021probabilitydatascience, p. 121]

$$F_X(x_k) \stackrel{\text{def}}{=} \mathbb{P}[X \le x_k] = \sum_{\ell=1}^{k} p_X(x_\ell).$$

If the states are integers, $F_X(k) = \sum_{\ell=-\infty}^{k} p_X(\ell)$.
The CDF is essentially the cumulative sum of the PMF.
[@chan2021probabilitydatascience, p. 121]

**Probability density function (PDF):** A continuous random variable $X$ is
defined by its probability density function $f_X : \Omega \to \mathbb{R}$, with
the properties: (i) non-negativity: $f_X(x) \ge 0$; (ii) unity:
$\int_\Omega f_X(x)\,dx = 1$; (iii) measure of a set:
$\mathbb{P}[\{x \in A\}] = \int_A f_X(x)\,dx$.
[@chan2021probabilitydatascience, p. 174]

When $X$ takes real values, a more concrete definition is: the PDF $f_X$ is a
function such that, integrated over any interval $[a,b]$, it yields the
probability of obtaining $a \le X \le b$:
[@chan2021probabilitydatascience, p. 175]

$$\mathbb{P}[a \le X \le b] = \int_a^b f_X(x)\,dx.$$

Unlike the PMF, the PDF value $f_X(x)$ is **not** a probability -- it is the
probability **per unit length**. The PDF can exceed 1 as long as it integrates
to 1. The probability of a single point $\mathbb{P}[X = x] = 0$ for any
continuous random variable because a point has zero length.
[@chan2021probabilitydatascience, pp. 175--176]

**CDF for continuous random variables:** The CDF of a continuous random
variable $X$ with sample space $\Omega = \mathbb{R}$ is:
[@chan2021probabilitydatascience, p. 186]

$$F_X(x) \stackrel{\text{def}}{=} \mathbb{P}[X \le x] = \int_{-\infty}^{x} f_X(x')\,dx'.$$

The CDF is the integral (cumulative area) of the PDF from $-\infty$ to $x$.
For continuous random variables, the CDF is a smooth nondecreasing function
(rather than a staircase). The CDF unifies discrete and continuous random
variables: it is always well-defined, even when the PDF involves delta functions.
[@chan2021probabilitydatascience, pp. 185--186, 194]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $X$ | "the random variable X" | A function from outcomes to real numbers. [@chan2021probabilitydatascience, p. 105] |
| $X(\xi)$ | "X of xi" | The value the random variable assigns to outcome $\xi$. [@chan2021probabilitydatascience, p. 105] |
| $X(\Omega)$ | "the states of X" or "the range of X" | The set of all values $X$ can take. [@chan2021probabilitydatascience, p. 109] |
| $X^{-1}(a)$ | "the pre-image of a" | The set $\{\xi \in \Omega \mid X(\xi) = a\}$: all outcomes mapped to value $a$. [@chan2021probabilitydatascience, p. 108] |
| $p_X(x)$ | "p sub X of x" or "the PMF at x" | The probability that $X$ takes the value $x$. [@chan2021probabilitydatascience, p. 110] |
| $F_X(x)$ | "F sub X of x" or "the CDF at x" | The probability that $X$ is less than or equal to $x$. [@chan2021probabilitydatascience, p. 121] |
| $f_X(x)$ | "f sub X of x" or "the PDF at x" | The probability density of $X$ at $x$ (probability per unit length, not a probability). [@chan2021probabilitydatascience, p. 174] |
| $\Phi(x)$ | "Phi of x" | The CDF of the standard Gaussian $\mathcal{N}(0,1)$: $\Phi(x) = \frac{1}{\sqrt{2\pi}}\int_{-\infty}^{x} e^{-t^2/2}\,dt$. [@chan2021probabilitydatascience, p. 214] |

## Key results & derivations

- **PMF normalization (Theorem 3.1)** -- a valid PMF must sum to 1 over all
  states: $\sum_{x \in X(\Omega)} p_X(x) = 1$. The proof follows from Axiom II
  ($\mathbb{P}[\Omega] = 1$) and Axiom III (additivity over disjoint pre-images).
  [@chan2021probabilitydatascience, p. 112]

- **CDF properties (Theorem 3.2)** -- the CDF of a discrete random variable has
  four properties: (i) it is a sequence of increasing unit steps; (ii) the
  maximum is $F_X(+\infty) = 1$; (iii) the minimum is $F_X(-\infty) = 0$;
  (iv) the unit steps have jumps at positions where $p_X(x) > 0$. The CDF is
  right continuous (solid dot on the left, empty dot on the right at each jump).
  [@chan2021probabilitydatascience, pp. 123--124]

- **PMF-CDF conversion (Theorem 3.3)** -- the PMF can be recovered from the CDF
  by differencing: $p_X(x_k) = F_X(x_k) - F_X(x_{k-1})$. For integer-valued
  random variables: $p_X(k) = F_X(k) - F_X(k-1)$.
  [@chan2021probabilitydatascience, p. 124]

- **Same PMF does not imply same RV** -- two random variables $X$ and $Y$ can
  have identical PMFs ($p_X = p_Y$) but be different random variables if their
  underlying mappings from $\Omega$ to $\mathbb{R}$ differ. The PMF shape is the
  same, but the events being mapped are different.
  [@chan2021probabilitydatascience, pp. 111--112]

- **CDF properties (Proposition 4.1)** -- for any random variable (discrete or
  continuous): (i) the CDF is nondecreasing; (ii) $F_X(+\infty) = 1$; (iii)
  $F_X(-\infty) = 0$. The proof uses the integral definition and
  non-negativity of $f_X$. [@chan2021probabilitydatascience, p. 188]

- **CDF is always right-continuous (Theorem 4.3)** -- $F_X(b) = F_X(b^+) =
  \lim_{h \to 0} F_X(b + h)$. This follows from the $\le$ in the definition
  $F_X(x) = \mathbb{P}[X \le x]$. If the CDF were defined with $<$ instead,
  it would be left-continuous. [@chan2021probabilitydatascience, p. 191]

- **Probability at a point via CDF discontinuity (Theorem 4.4)** -- for any
  random variable, $\mathbb{P}[X = b] = F_X(b) - F_X(b^-)$. If $F_X$ is
  continuous at $b$, then $\mathbb{P}[X = b] = 0$. The jump height at a CDF
  discontinuity gives the probability mass at that point.
  [@chan2021probabilitydatascience, p. 192]

- **PDF is the derivative of CDF (Theorem 4.5)** -- $f_X(x) = \frac{d}{dx}
  F_X(x)$, by the fundamental theorem of calculus. At points where $F_X$ is
  not differentiable (discontinuities), $f_X(x_0) = \mathbb{P}[X = x_0]
  \,\delta(x - x_0)$, a delta function. This is the key link between
  integration (CDF from PDF) and differentiation (PDF from CDF).
  [@chan2021probabilitydatascience, p. 193]

- **Interval probability via CDF (Proposition 4.2)** -- for a continuous random
  variable with continuous CDF, $\mathbb{P}[a \le X \le b] = F_X(b) - F_X(a)$.
  For continuous variables, $\mathbb{P}[a \le X \le b] = \mathbb{P}[a < X < b]$
  since $\mathbb{P}[X = a] = \mathbb{P}[X = b] = 0$.
  [@chan2021probabilitydatascience, p. 189]

- **Inverse CDF transform (Theorem 4.12)** -- to generate random numbers from
  any distribution $F_X$: (1) generate $U \sim \text{Uniform}(0,1)$; (2) set
  $Y = F_X^{-1}(U)$. Then $Y$ has CDF $F_X$. This works because $F_U(u) = u$
  for the uniform, so $\mathbb{P}[F_X^{-1}(U) \le y] = \mathbb{P}[U \le
  F_X(y)] = F_X(y)$. [@chan2021probabilitydatascience, p. 229]

## Prerequisites

- [probability-and-odds](probability-and-odds.md) -- the probability triple
  $(\Omega, \mathcal{F}, \mathbb{P})$ and the three axioms are needed to define
  what $\mathbb{P}[X = x]$ means.

## Misconceptions & learner traps

- **Confusing $\Omega$ with $X(\Omega)$** -- the sample space $\Omega$ contains
  all possible outcomes of the experiment (which may be symbols, tuples, etc.);
  $X(\Omega)$ is the set of numerical states the random variable maps those
  outcomes to. [@chan2021probabilitydatascience, p. 110]

- **"Why define a function and call it a variable?"** -- $X$ is a function (it
  maps each outcome to a number), but it is called a variable because it has
  multiple possible states, and which state occurs is random. The word
  "variable" refers to the multiplicity of states, not to the function itself.
  [@chan2021probabilitydatascience, p. 106]

- **Confusing PMF values with probabilities in the continuous case** -- for
  discrete random variables, $p_X(x)$ is a probability (bounded by 1). For
  continuous random variables, the density $f_X(x)$ is probability **per unit
  length** and can exceed 1; only after integrating over an interval does it
  become a probability. [@chan2021probabilitydatascience, p. 176]

- **PMF vs. histogram** -- a PMF is the ideal (theoretical) histogram; an
  empirical histogram from data approximates the PMF and converges to it as the
  number of samples approaches infinity.
  [@chan2021probabilitydatascience, pp. 114--115]

## Teaching insights & analogies

- **"Random variables are mappings from events to numbers"** -- Chan's Key
  Concept 1. The mapping translates descriptive outcomes (like "heads" or
  "three of clubs") into numbers that can be computed with.
  [@chan2021probabilitydatascience, p. 104]

- **"PMFs are the ideal histograms of random variables"** -- Chan's Key
  Concept 2. A PMF is what a histogram converges to as the number of samples
  goes to infinity. The PMF is theoretical (from the model); the histogram is
  empirical (from data). [@chan2021probabilitydatascience, pp. 104, 114--116]

- **Card-suit encoding example** -- assigning $\clubsuit \to 1$,
  $\diamondsuit \to 2$, $\heartsuit \to 3$, $\spadesuit \to 4$ illustrates that
  the number assignment is arbitrary -- the random variable is just a convenient
  numerical encoding. [@chan2021probabilitydatascience, p. 105]

- **Probability via pre-image** -- to compute $\mathbb{P}[X = a]$, trace back
  through the mapping: find all outcomes $\xi$ such that $X(\xi) = a$ (the
  pre-image), then apply the probability law to that set. This is the
  fundamental bridge between the abstract probability space and numerical
  computation. [@chan2021probabilitydatascience, p. 108]

- **Synthesis vs. analysis** -- two complementary directions: synthesis starts
  with a known PMF and generates data; analysis starts with data and infers the
  PMF. Statistical inference is the analysis direction.
  [@chan2021probabilitydatascience, p. 116]

- **CDF as staircase** -- for discrete random variables, the CDF is a staircase
  function where each step up corresponds to a state with positive probability.
  The height of the jump at each step equals the PMF value at that state.
  [@chan2021probabilitydatascience, pp. 122--123]

- **CDF unifies discrete and continuous** -- the CDF is always well-defined (a
  staircase for discrete, a smooth curve for continuous, or a hybrid). By
  contrast, the PMF uses sums (counting) and the PDF uses integrals
  (measuring). The CDF bridges the two: differentiating a smooth CDF gives a
  PDF; differentiating a staircase CDF gives a train of delta functions (which
  recovers the PMF). [@chan2021probabilitydatascience, pp. 194, 196]

- **"Density is not probability"** -- for continuous random variables, $f_X(x)$
  is probability per unit length. Even though $f_X(x)$ can exceed 1 (e.g.,
  $\text{Uniform}(0.2, 0.6)$ has density 2.5), this is fine because integrating
  over any subinterval still yields a probability in $[0,1]$. The $dx$ in the
  integral provides the "length" that converts density to probability.
  [@chan2021probabilitydatascience, pp. 176, 202]

- **Generating random numbers via inverse CDF** -- any distribution can be
  sampled by generating $U \sim \text{Uniform}(0,1)$ and applying $F_X^{-1}(U)$.
  The CDF maps the real line to $[0,1]$; inverting it maps $[0,1]$ back to the
  real line with the desired distribution. This is the fundamental connection
  between uniform random numbers and arbitrary distributions.
  [@chan2021probabilitydatascience, pp. 228--229]

## How the field talks about it

The notation $X$ for a random variable and $x$ for a specific value (state) is
standard, as is the shorthand $\mathbb{P}[X = x]$ for the pre-image
probability $\mathbb{P}[\{\xi \in \Omega \mid X(\xi) = x\}]$. The PMF is
denoted $p_X(x)$ or $P(X = x)$; the subscript $X$ is often dropped when the
variable is clear from context. The CDF is universally denoted $F_X(x)$ or
$F(x)$. In data science and machine learning, the probability triple
$(\Omega, \mathcal{F}, \mathbb{P})$ is typically left implicit -- practitioners
jump directly to the PMF/PDF without constructing the sample space.
[@chan2021probabilitydatascience, pp. 109--110, 121]
