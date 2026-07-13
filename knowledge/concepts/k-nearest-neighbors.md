---
title: "K-nearest neighbors"
topic: statistical-learning
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

A non-parametric classification (and regression) method that predicts the response for a new observation by finding the $K$ closest training observations and taking their majority vote (classification) or average (regression). [@james2021introductionstatisticallearning, §2.2.3]

**Also known as:** KNN, $K$-nearest neighbors classifier

## Definition(s)

Given a positive integer $K$ and a test observation $x_0$, the KNN classifier identifies the $K$ points in the training data that are closest to $x_0$ (the neighborhood $\mathcal{N}_0$), then estimates the conditional probability for each class $j$ as the fraction of points in $\mathcal{N}_0$ whose response equals $j$:

$$\Pr(Y = j \mid X = x_0) = \frac{1}{K} \sum_{i \in \mathcal{N}_0} I(y_i = j)$$

KNN then classifies $x_0$ to the class with the largest estimated probability. [@james2021introductionstatisticallearning, p. 39]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $K$ | "K" | The number of nearest neighbors to consider [@james2021introductionstatisticallearning, §2.2.3] |
| $\mathcal{N}_0$ | "script N zero" or "the neighborhood" | The set of $K$ training points closest to the test observation $x_0$ [@james2021introductionstatisticallearning, p. 39] |
| $I(y_i = j)$ | "indicator that y-i equals j" | Equals 1 if the $i$th neighbor belongs to class $j$, 0 otherwise [@james2021introductionstatisticallearning, p. 39] |

## Key results & derivations

- **KNN can closely approximate the Bayes classifier** -- Despite not knowing the true conditional distribution of $Y$ given $X$, KNN with an appropriate $K$ produces decision boundaries that are very close to the optimal Bayes decision boundary. In ISL's simulated example, KNN with $K=10$ achieves a test error rate of 0.1363, close to the Bayes error rate of 0.1304. [@james2021introductionstatisticallearning, pp. 39--41]

- **$1/K$ controls flexibility** -- As $K$ decreases (fewer neighbors), the decision boundary becomes more flexible and irregular (low bias, high variance). As $K$ increases, the boundary becomes smoother and more linear (high bias, low variance). At $K=1$, training error is zero but test error may be high; at very large $K$, the boundary is nearly linear and both bias and test error are high. [@james2021introductionstatisticallearning, pp. 41--42]

- **U-shaped test error** -- The test error rate as a function of $1/K$ (flexibility) exhibits the same U-shape seen in the regression setting: it decreases initially, reaches a minimum, then increases as the method becomes excessively flexible. This is a direct manifestation of the bias-variance trade-off in the classification setting. [@james2021introductionstatisticallearning, p. 42]

## Prerequisites

What you must already understand for this concept to make sense:

- [bias-variance-trade-off](bias-variance-trade-off.md) -- KNN's behavior with different values of $K$ is a canonical example of the bias-variance trade-off.
- [distance-similarity-and-geometry](../foundations/distance-similarity-and-geometry/lesson.qmd) -- "closest" requires a distance metric (typically Euclidean).

## Misconceptions & learner traps

- **"Smaller K is always better because it captures local structure"** -- With $K=1$, the decision boundary is overly flexible and the training error rate is exactly zero, but the test error rate can be much higher than the Bayes error rate. The model is fitting noise, not signal. [@james2021introductionstatisticallearning, p. 41]

- **"KNN is only for classification"** -- KNN can also be used for regression (averaging the $K$ nearest responses instead of taking a majority vote), though ISL introduces it in the classification context. [@james2021introductionstatisticallearning, p. 29]

## Teaching insights & analogies

- **The Bayes classifier as unattainable gold standard** -- ISL introduces the Bayes classifier first (assign each observation to the class with the highest conditional probability) and shows it produces the lowest possible test error rate. KNN is then motivated as a practical approximation: since the true conditional probabilities are unknown, KNN estimates them from the $K$ nearest training points. This framing gives KNN a clear theoretical motivation rather than presenting it as an ad hoc method. [@james2021introductionstatisticallearning, pp. 37--39]

- **Visual progression from K=1 to K=100** -- ISL displays KNN decision boundaries for $K=1$ (jagged, overfitting) and $K=100$ (nearly linear, underfitting) side by side with the Bayes boundary. The visual comparison makes the bias-variance trade-off tangible: the $K=10$ boundary is closest to the optimal one. [@james2021introductionstatisticallearning, pp. 40--41]

## How the field talks about it

KNN is often described as a "lazy" learner because it stores the training data and does all computation at prediction time rather than fitting parameters during training. When a paper mentions choosing $K$ by cross-validation, it means using the resampling methods from Chapter 5 to estimate the test error rate for each value of $K$ and picking the one with the lowest estimated error. [@james2021introductionstatisticallearning, pp. 39, 42]
