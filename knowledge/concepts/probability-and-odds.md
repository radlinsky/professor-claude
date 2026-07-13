---
title: "Probability and odds"
topic: probability
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

A probability space is the mathematical framework for modeling uncertainty: it
consists of a sample space (all possible outcomes), an event space (the
collection of subsets we can assign probabilities to), and a probability law (a
function that maps each event to a number in [0, 1] following three axioms).
[@chan2021probabilitydatascience, pp. 56--66]

**Also known as:** probability model, probability triple, Kolmogorov model

## Definition(s)

A **probability space** is a triple $(\Omega, \mathcal{F}, \mathbb{P})$ where:
[@chan2021probabilitydatascience, pp. 60--66, 74]

- $\Omega$ is the **sample space**: the set of all possible outcomes of an
  experiment. Outcomes must be exhaustive (every possibility is listed) and
  mutually exclusive (no outcome belongs to two categories).
  [@chan2021probabilitydatascience, pp. 56--58]
- $\mathcal{F}$ is the **event space**: the collection of all subsets of $\Omega$
  that we can assign probabilities to. For a finite sample space with $n$
  elements, $\mathcal{F}$ has at most $2^n$ events (exactly $2^n$ when
  $\mathcal{F}$ is the power set, which is the usual choice for finite
  sample spaces). The event space must be a
  **field** (closed under complement, union, and intersection) and, for
  infinite sample spaces, a **sigma-field** (closed under countably infinite
  unions and intersections as well).
  [@chan2021probabilitydatascience, pp. 60--65]
- $\mathbb{P}$ is the **probability law**: a function
  $\mathbb{P} : \mathcal{F} \to [0, 1]$ that assigns a real number to each
  event. The probability law must satisfy the axioms of probability.
  [@chan2021probabilitydatascience, p. 66]

The central slogan: **probability is a measure of the size of a set**. The
measure can be a counter (for finite sets), a ruler (for intervals), or an
integrator (for regions), depending on the nature of $\Omega$.
[@chan2021probabilitydatascience, pp. 67--68]

### Axioms of probability

A probability law $\mathbb{P} : \mathcal{F} \to [0, 1]$ must satisfy the
**Kolmogorov axioms**: [@chan2021probabilitydatascience, pp. 74--75]

I. **Non-negativity:** $\mathbb{P}[A] \ge 0$ for any event $A \in \mathcal{F}$ (i.e., $A \subseteq \Omega$).

II. **Normalization:** $\mathbb{P}[\Omega] = 1$.

III. **Additivity (countable):** For any disjoint events
$\{A_1, A_2, \ldots\}$,
$\mathbb{P}\!\left[\bigcup_{i=1}^{\infty} A_i\right] = \sum_{i=1}^{\infty} \mathbb{P}[A_i]$.

The finite case is: for disjoint $A$ and $B$,
$\mathbb{P}[A \cup B] = \mathbb{P}[A] + \mathbb{P}[B]$.
[@chan2021probabilitydatascience, p. 75]

### Key corollaries from the axioms

- **Complement rule:** $\mathbb{P}[A^c] = 1 - \mathbb{P}[A]$.
  [@chan2021probabilitydatascience, p. 77]
- **Upper bound:** $\mathbb{P}[A] \le 1$.
  [@chan2021probabilitydatascience, p. 77]
- **Empty set:** $\mathbb{P}[\emptyset] = 0$.
  [@chan2021probabilitydatascience, p. 77]
- **Inclusion-exclusion (two sets):**
  $\mathbb{P}[A \cup B] = \mathbb{P}[A] + \mathbb{P}[B] - \mathbb{P}[A \cap B]$.
  [@chan2021probabilitydatascience, p. 78]
- **Union bound:** $\mathbb{P}[A \cup B] \le \mathbb{P}[A] + \mathbb{P}[B]$.
  [@chan2021probabilitydatascience, p. 79]
- **Monotonicity:** If $A \subseteq B$, then
  $\mathbb{P}[A] \le \mathbb{P}[B]$.
  [@chan2021probabilitydatascience, p. 79]

### Measure zero sets

A set $A \in \mathcal{F}$ (with $A \subseteq \Omega$) has **measure zero** if, for any $\epsilon > 0$, there
exists a countable collection of subsets $\{A_n\}$ covering $A$ whose total
probability is less than $\epsilon$. A single point in a continuous sample space
always has measure zero (e.g. $\mathbb{P}[\{0.5\}] = 0$ when $\Omega = [0, 1]$),
but the same point can have positive probability under a discrete measure.
[@chan2021probabilitydatascience, pp. 71--72]

An event holds **almost surely (a.s.)** if $\mathbb{P}[A] = 1$ except for
measure zero sets. [@chan2021probabilitydatascience, p. 73]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $\Omega$ | "omega" | Sample space: the set of all possible outcomes. [@chan2021probabilitydatascience, p. 56] |
| $\mathcal{F}$ | "script F" or "the event space" | Event space: the collection of all measurable subsets of $\Omega$. [@chan2021probabilitydatascience, p. 60] |
| $\mathbb{P}$ | "P" or "the probability law" | Probability law (the measure): a function mapping events to $[0, 1]$. [@chan2021probabilitydatascience, p. 66] |
| $\mathbb{P}[A]$ | "probability of A" or "P of A" | The probability assigned to event $A$ by the probability law. [@chan2021probabilitydatascience, p. 66] |
| $A^c$ | "A complement" | The complement of event $A$: all outcomes in $\Omega$ not in $A$. [@chan2021probabilitydatascience, p. 48] |
| $A \cup B$ | "A union B" | The event that $A$ or $B$ (or both) occurs. [@chan2021probabilitydatascience, p. 47] |
| $A \cap B$ | "A intersect B" | The event that both $A$ and $B$ occur. [@chan2021probabilitydatascience, p. 47] |

## Key results & derivations

- **All three components are required** -- dropping any one of $\Omega$,
  $\mathcal{F}$, or $\mathbb{P}$ makes the probability model undefined.
  Without $\Omega$, events cannot be defined; without $\mathcal{F}$, some
  events become undefined; without $\mathbb{P}$, there is no way to assign
  probabilities. [@chan2021probabilitydatascience, p. 74]

- **Two different probability laws on the same events produce different
  probabilities** -- the event is "what happened" and the measure is "how we
  weigh it." The same event $E = \{1, 2\}$ can have $\mathbb{F}(E) = 3/12$
  under one weighting and $\mathbb{G}(E) = 4/12$ under another.
  [@chan2021probabilitydatascience, pp. 70--71]

- **Probability as a measure eliminates frequentist dependency** -- viewing
  probability as a measure (the size of a set) rather than a relative
  frequency generalizes it from discrete coin-flip settings to intervals,
  areas, and volumes. [@chan2021probabilitydatascience, pp. 69--70]

- **Conditional probability inherits all three axioms** -- if $\mathbb{P}[B] > 0$,
  then $\mathbb{P}[A \mid B]$ satisfies non-negativity, normalization, and
  additivity, making it a legitimate probability in its own right.
  [@chan2021probabilitydatascience, pp. 84--85]

## Prerequisites

No concept-page prerequisites (this is a foundational concept).

## Misconceptions & learner traps

- **"Probability is about counting"** -- for finite sets, probability is
  counting, but for intervals and regions the measure is a ruler or
  integrator, not a counter. The "probability is the size of a set" framing
  encompasses both. [@chan2021probabilitydatascience, pp. 67--68]

- **Confusing an event with a probability** -- the event $E$ is a subset of
  $\Omega$ (the thing that happened); the probability $\mathbb{P}[E]$ is the
  number the measure assigns to it. Two different measures can assign
  different numbers to the same event. [@chan2021probabilitydatascience, p. 70]

- **Treating a single point in a continuous space as having positive
  probability** -- when $\Omega$ is an interval, $\mathbb{P}[\{x_0\}] = 0$
  (measure zero), even though the outcome $x_0$ is possible. The same point
  can have positive probability under a discrete (counting) measure.
  [@chan2021probabilitydatascience, pp. 71--72]

## Teaching insights & analogies

- **"Probability is a measure of the size of a set"** -- Chan's central slogan
  (introduced as boldface text and repeated in summaries). The measure can be
  a counter, ruler, or integrator depending on the nature of $\Omega$.
  [@chan2021probabilitydatascience, pp. 67--68, 74]

- **Card-suit examples** -- the text uses a sample space $\Omega = \{\clubsuit,
  \heartsuit, \spadesuit\}$ with non-uniform weights to build intuition about
  different probability laws on the same event space.
  [@chan2021probabilitydatascience, pp. 66--67, 69]

- **Three axioms as rules for building measures** -- non-negativity prevents
  negative "sizes," normalization sets the total "size" to 1, and additivity
  ensures non-overlapping pieces add up, making probability behave like a
  well-defined ruler. [@chan2021probabilitydatascience, p. 75]

## How the field talks about it

The probability triple $(\Omega, \mathcal{F}, \mathbb{P})$ is standard notation
across probability and statistics. In introductory courses the event space and
its sigma-field structure are often left implicit (since for finite sample
spaces, the power set works); advanced usage requires specifying the
sigma-field explicitly to handle uncountable spaces (the Borel sigma-field for
$\mathbb{R}$). The Kolmogorov axioms (attributed to Kolmogorov's 1933
*Foundations of the Theory of Probability*) are universally accepted as the
starting point of modern probability. [@chan2021probabilitydatascience, pp. 64--65, 80]
