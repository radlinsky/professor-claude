---
title: "Conditional probability"
topic: probability
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

The probability of an event $A$ occurring given that another event $B$ has
already occurred, defined as the ratio
$\mathbb{P}[A \mid B] = \mathbb{P}[A \cap B] / \mathbb{P}[B]$ (provided
$\mathbb{P}[B] \neq 0$). Conditional probability measures the relative size of
$A$ inside $B$, not in the full sample space.
[@chan2021probabilitydatascience, pp. 80--81]

**Also known as:** posterior probability (when used in a Bayesian context)

## Definition(s)

**Conditional probability:** Given two events $A$ and $B$ with
$\mathbb{P}[B] \neq 0$, the conditional probability of $A$ given $B$ is:
[@chan2021probabilitydatascience, p. 81]

$$\mathbb{P}[A \mid B] \stackrel{\text{def}}{=} \frac{\mathbb{P}[A \cap B]}{\mathbb{P}[B]}.$$

This differs from the joint probability $\mathbb{P}[A \cap B]$, which measures
the overlap between $A$ and $B$ relative to the entire sample space $\Omega$:
[@chan2021probabilitydatascience, p. 81]

$$\mathbb{P}[A \mid B] = \frac{\mathbb{P}[A \cap B]}{\mathbb{P}[B]} \quad \text{vs.} \quad \mathbb{P}[A \cap B] = \frac{\mathbb{P}[A \cap B]}{\mathbb{P}[\Omega]}.$$

**Bayes' theorem:** For any two events $A$ and $B$ with $\mathbb{P}[A] > 0$
and $\mathbb{P}[B] > 0$: [@chan2021probabilitydatascience, p. 89]

$$\mathbb{P}[A \mid B] = \frac{\mathbb{P}[B \mid A]\,\mathbb{P}[A]}{\mathbb{P}[B]}.$$

The theorem provides two views of the intersection $\mathbb{P}[A \cap B]$
using two different conditional probabilities: $\mathbb{P}[B \mid A]$ (called
the **conditional probability** or **likelihood**) and $\mathbb{P}[A \mid B]$
(called the **posterior probability**). The order of $A$ and $B$ is arbitrary.
[@chan2021probabilitydatascience, p. 89]

**Law of total probability:** Let $\{A_1, \ldots, A_n\}$ be a partition of
$\Omega$ (pairwise disjoint and $A_1 \cup \cdots \cup A_n = \Omega$). Then for
any event $B \subseteq \Omega$: [@chan2021probabilitydatascience, p. 89]

$$\mathbb{P}[B] = \sum_{i=1}^{n} \mathbb{P}[B \mid A_i]\,\mathbb{P}[A_i].$$

The law decomposes $\mathbb{P}[B]$ by summing the contributions of $B$ within
each piece of the partition, weighted by the prior probabilities
$\mathbb{P}[A_i]$. [@chan2021probabilitydatascience, pp. 89--90]

**Bayes' theorem with total probability (Corollary 2.4):** Combining both
results yields the full Bayesian update formula: for any $A_j$ in a partition
$\{A_1, \ldots, A_n\}$ of $\Omega$ and any $B \subseteq \Omega$:
[@chan2021probabilitydatascience, p. 90]

$$\mathbb{P}[A_j \mid B] = \frac{\mathbb{P}[B \mid A_j]\,\mathbb{P}[A_j]}{\sum_{i=1}^{n} \mathbb{P}[B \mid A_i]\,\mathbb{P}[A_i]}.$$

**Statistical independence:** Two events $A$ and $B$ are **independent** if:
[@chan2021probabilitydatascience, p. 85]

$$\mathbb{P}[A \cap B] = \mathbb{P}[A]\,\mathbb{P}[B].$$

Equivalently (when $\mathbb{P}[A] > 0$ and $\mathbb{P}[B] > 0$):
$\mathbb{P}[A \mid B] = \mathbb{P}[A]$ or $\mathbb{P}[B \mid A] = \mathbb{P}[B]$.
Independence means that knowing $B$ occurred provides no information about
whether $A$ occurred. [@chan2021probabilitydatascience, pp. 85--86]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $\mathbb{P}[A \mid B]$ | "probability of A given B" | Conditional probability of $A$ given $B$. [@chan2021probabilitydatascience, p. 81] |
| $\mathbb{P}[A \cap B]$ | "probability of A and B" | Joint probability: both $A$ and $B$ occur. [@chan2021probabilitydatascience, p. 81] |
| $A \perp B$ | "A is independent of B" | Events $A$ and $B$ are statistically independent. *(synthesis)* |

## Key results & derivations

- **Conditional probability satisfies all three axioms** -- if $\mathbb{P}[B] > 0$,
  then $\mathbb{P}[\cdot \mid B]$ is a legitimate probability measure: it
  satisfies non-negativity, normalization ($\mathbb{P}[\Omega \mid B] = 1$), and
  additivity. [@chan2021probabilitydatascience, pp. 84--85]

- **Conditioning shrinks the denominator** -- since $\mathbb{P}[B] \le
  \mathbb{P}[\Omega]$, we always have $\mathbb{P}[A \mid B] \ge \mathbb{P}[A
  \cap B]$. Conditioning can only increase or preserve the probability of an
  event relative to the joint. [@chan2021probabilitydatascience, p. 84]

- **Order of conditioning matters** -- $\mathbb{P}[A \mid B]$ and
  $\mathbb{P}[B \mid A]$ are generally not equal. In a die-throwing example,
  $\mathbb{P}[\text{getting 3} \mid \text{odd}] = 1/3$ while
  $\mathbb{P}[\text{odd} \mid \text{getting 3}] = 1$.
  [@chan2021probabilitydatascience, pp. 82--83]

- **Bayes' theorem switches the conditioning** -- it converts
  $\mathbb{P}[A \mid B]$ into $\mathbb{P}[B \mid A]$. The proof follows
  directly from writing $\mathbb{P}[A \cap B]$ in two ways using the
  definition of conditional probability and dividing both sides by
  $\mathbb{P}[B]$. [@chan2021probabilitydatascience, p. 89]

- **Law of total probability decomposes an event into sub-events** -- if
  $\{A_1, \ldots, A_n\}$ partitions $\Omega$, then $\mathbb{P}[B]$ can be
  computed by summing $\mathbb{P}[B \mid A_i]\mathbb{P}[A_i]$ over the
  partition. The proof uses the definition of conditional probability (step a),
  Axiom III of probability (step b), the distributive property of sets (step c),
  and the partition property $\bigcup A_i = \Omega$ (step d).
  [@chan2021probabilitydatascience, p. 89]

- **Three Prisoners problem illustrates independence** -- prisoner $A$ fears
  that learning the guard's information ($G_B$: "prisoner $B$ is pardoned")
  reduces $A$'s pardon probability from 2/3 to 1/2. The resolution: by Bayes'
  theorem and total probability, $\mathbb{P}[X_A \mid G_B] = 1/3 =
  \mathbb{P}[X_A]$, so the events are independent. The key insight is that
  $G_A, G_B, G_C$ do not form a partition, and verbal reasoning about reduced
  sets is misleading; writing down the conditional probabilities resolves the
  paradox. [@chan2021probabilitydatascience, pp. 92--94]

## Prerequisites

- [probability-and-odds](probability-and-odds.md) -- the axioms and the concept
  of a probability measure are needed to understand what conditioning preserves.

## Misconceptions & learner traps

- **Disjoint does not mean independent** -- disjoint events have
  $A \cap B = \emptyset$, so $\mathbb{P}[A \cap B] = 0$. Independent events have
  $\mathbb{P}[A \cap B] = \mathbb{P}[A]\mathbb{P}[B]$. The only case where
  disjoint implies independent is when $\mathbb{P}[A] = 0$ or
  $\mathbb{P}[B] = 0$. When two sets are disjoint, they simply do not overlap;
  when two sets are independent, the conditional probability (a ratio) remains
  unchanged from the unconditional probability.
  [@chan2021probabilitydatascience, p. 86]

- **Confusing $\mathbb{P}[A \mid B]$ with $\mathbb{P}[A \cap B]$** --
  $\mathbb{P}[A \mid B]$ is a ratio that normalizes by $\mathbb{P}[B]$;
  $\mathbb{P}[A \cap B]$ is the overlap relative to the full sample space. The
  conditional probability can be much larger than the joint.
  [@chan2021probabilitydatascience, p. 81]

- **Assuming $\mathbb{P}[A \mid B] = \mathbb{P}[B \mid A]$** -- the
  "prosecutor's fallacy." These are generally different quantities.
  [@chan2021probabilitydatascience, pp. 82--83]

## Teaching insights & analogies

- **Conditioning as zooming in** -- when $B$ has happened, everything outside
  $B$ becomes irrelevant. The conditional probability "zooms in" on the subset
  $B$ and measures how much of $A$ lies inside it.
  [@chan2021probabilitydatascience, pp. 81--82]

- **Visual: Venn diagram ratio** -- the intersection $\mathbb{P}[A \cap B]$
  shows overlap; the conditional $\mathbb{P}[A \mid B]$ is that overlap
  divided by $\mathbb{P}[B]$, visualized as the fraction of $B$'s area that $A$
  covers. [@chan2021probabilitydatascience, p. 81]

- **Independence as ratio preservation** -- when $A$ and $B$ are independent,
  the ratio of $\mathbb{P}[A \cap B]$ to $\mathbb{P}[B]$ equals the ratio of
  $\mathbb{P}[A \cap \Omega]$ to $\mathbb{P}[\Omega]$ -- the "proportion of A"
  is the same whether you look inside $B$ or inside $\Omega$.
  [@chan2021probabilitydatascience, p. 86]

- **Bayes' theorem as role-switching** -- the text frames Bayes' theorem as
  answering: "You know $\mathbb{P}[\text{win} \mid \text{play with A}]$ (the
  conditional probability); now find $\mathbb{P}[\text{play with A} \mid
  \text{win}]$ (the posterior probability)." In practical problems the question
  of interest is often the posterior: given that something was observed, what
  caused it? [@chan2021probabilitydatascience, pp. 89, 95]

- **Law of total probability as decomposition** -- the text uses a pie-chart
  visualization: $\mathbb{P}[B]$ is the whole pie, each slice
  $\mathbb{P}[B \cap A_i] = \mathbb{P}[B \mid A_i]\mathbb{P}[A_i]$ is one
  piece. The conditional probability tells how much of the slice is $B$; the
  prior $\mathbb{P}[A_i]$ tells how big the slice is.
  [@chan2021probabilitydatascience, p. 90]

- **Tennis tournament example** -- three types of players ($A$, $B$, $C$) with
  different win probabilities. The law of total probability gives the overall
  win probability; Bayes' theorem then answers "given you won, which type of
  player did you face?" This concrete example shows how the prior
  $\mathbb{P}[A]$ and the likelihood $\mathbb{P}[W \mid A]$ combine to form the
  posterior. [@chan2021probabilitydatascience, pp. 90--91]

- **Communication channel example** -- a binary channel with error
  probabilities $\varepsilon$ and $\eta$ demonstrates Bayes' theorem and the law
  of total probability in an engineering context: given that a 1 was received,
  the posterior probability that a 1 was sent is
  $(1-\eta)p / [(1-\eta)p + \varepsilon(1-p)]$.
  [@chan2021probabilitydatascience, pp. 91--92]

## How the field talks about it

The vertical bar "$\mid$" is universally read as "given" in probability. When a
paper writes $P(Y = 1 \mid X = x)$, it means the probability that $Y$ equals 1
given that $X$ has been observed to take value $x$. In Bayesian statistics, the
posterior $P(\theta \mid \text{data})$ is a conditional probability; in machine
learning, class-conditional probabilities $P(X \mid Y = k)$ are the building
blocks of generative classifiers. The notation $A \perp B$ for independence is
standard but not universal; some texts use $A \perp\!\!\!\perp B$.
[@chan2021probabilitydatascience, pp. 80--86]

The terms **prior probability** ($\mathbb{P}[A]$ -- what you believe before
seeing data), **conditional probability** or **likelihood** ($\mathbb{P}[B
\mid A]$ -- how likely the data are under each hypothesis), and **posterior
probability** ($\mathbb{P}[A \mid B]$ -- updated belief after seeing data) are
the standard Bayesian vocabulary. Chan introduces all three via a tennis
tournament example. [@chan2021probabilitydatascience, p. 95]
