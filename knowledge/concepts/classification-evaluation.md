---
title: "Classification evaluation"
topic: statistical-learning
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

The tools for measuring and comparing the performance of classifiers, including confusion matrices, sensitivity, specificity, ROC curves, and the area under the ROC curve (AUC), as well as the effect of varying the classification threshold. [@james2021introductionstatisticallearning, pp. 148--153]

**Also known as:** classifier performance metrics, classification diagnostics

## Definition(s)

A **confusion matrix** is a table that displays the number of true positives (TP), true negatives (TN), false positives (FP), and false negatives (FN) produced by a classifier on a dataset. It reveals how the two types of errors are distributed across classes, which overall error rate alone does not capture. [@james2021introductionstatisticallearning, pp. 148--149]

**Sensitivity** (the true positive rate, also called recall or power) is the fraction of truly positive observations that the classifier correctly identifies: $\text{TP} / \text{P}$, where P is the total number of actual positives. [@james2021introductionstatisticallearning, pp. 149, 153]

**Specificity** is the fraction of truly negative observations that the classifier correctly identifies: $\text{TN} / \text{N}$, where N is the total number of actual negatives. Equivalently, the false positive rate is $1 - \text{specificity} = \text{FP} / \text{N}$. [@james2021introductionstatisticallearning, pp. 149, 152--153]

The **ROC curve** (receiver operating characteristics) plots the true positive rate (sensitivity) against the false positive rate ($1 - \text{specificity}$) across all possible classification thresholds. An ideal classifier hugs the top-left corner (high sensitivity, low false positive rate). A classifier performing no better than chance traces the $45^\circ$ diagonal. [@james2021introductionstatisticallearning, pp. 150--151]

The **area under the ROC curve (AUC)** summarizes the overall performance of a classifier across all thresholds in a single number. Larger AUC is better; AUC = 1 is a perfect classifier; AUC = 0.5 corresponds to random guessing. [@james2021introductionstatisticallearning, p. 151]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| TP | "true positives" | Correctly identified positive cases [@james2021introductionstatisticallearning, p. 152] |
| TN | "true negatives" | Correctly identified negative cases [@james2021introductionstatisticallearning, p. 152] |
| FP | "false positives" | Negative cases incorrectly classified as positive (Type I error) [@james2021introductionstatisticallearning, p. 152] |
| FN | "false negatives" | Positive cases incorrectly classified as negative (Type II error) [@james2021introductionstatisticallearning, p. 152] |
| P, N | "positives, negatives" | Total actual positive and negative counts in the population [@james2021introductionstatisticallearning, p. 152] |
| $\text{P}^*$, $\text{N}^*$ | "predicted positives, predicted negatives" | Total predicted positive and negative counts [@james2021introductionstatisticallearning, p. 152] |
| $L(y) = f_1(y)/f_0(y)$ | "the likelihood ratio" | Ratio of the PDF under $H_1$ to the PDF under $H_0$; the Neyman-Pearson decision rule rejects $H_0$ when $L(y) \ge \eta$ [@chan2021probabilitydatascience, p. 586, Eq. 9.35] |
| $p_F, p_D, p_M$ | "false alarm, detection, miss" | $p_F = \mathbb{P}[Y \ge \eta \mid H_0]$ (Type I), $p_D = \mathbb{P}[Y \ge \eta \mid H_1]$ (power), $p_M = 1 - p_D$ (Type II); the ROC curve plots $p_D$ vs. $p_F$ [@chan2021probabilitydatascience, pp. 582--583, Eqs. 9.28--9.30] |

## Key results & derivations

- **The threshold controls the sensitivity-specificity trade-off** -- By default, the Bayes classifier (and by extension LDA, logistic regression) uses a 50% posterior probability threshold to assign class membership. Lowering the threshold (e.g., predicting "default" if $\Pr(\text{default} \mid X) > 0.2$) increases sensitivity (more true positives detected) but decreases specificity (more false positives). The overall error rate is minimized at the 0.5 threshold, but domain knowledge may dictate a different threshold when the costs of the two error types are unequal. [@james2021introductionstatisticallearning, pp. 149--150]

- **The ROC curve traces all threshold choices simultaneously** -- Rather than choosing a single threshold and reporting one confusion matrix, the ROC curve shows the full trade-off between sensitivity and false positive rate. This makes it possible to compare classifiers without committing to a particular threshold. [@james2021introductionstatisticallearning, pp. 150--151]

- **AUC as a single-number summary** -- The AUC aggregates classifier performance across all thresholds. For the LDA classifier on the Default dataset, the AUC is 0.95 (close to 1.0), indicating strong discrimination between defaulters and non-defaulters. The logistic regression ROC curve for the same data is virtually indistinguishable from the LDA curve. [@james2021introductionstatisticallearning, p. 151]

- **Key performance measures derived from the confusion matrix** -- False positive rate = FP/N (also: Type I error, $1 - \text{specificity}$). True positive rate = TP/P (also: $1 - \text{Type II error}$, power, sensitivity, recall). Positive predictive value = $\text{TP}/\text{P}^*$ (also: precision, $1 - \text{false discovery proportion}$). Negative predictive value = $\text{TN}/\text{N}^*$. Note that the denominators for FPR/TPR are the actual class counts (N and P), while the denominators for PPV/NPV are the predicted class counts ($\text{P}^*$ and $\text{N}^*$). [@james2021introductionstatisticallearning, pp. 152--153]

- **Neyman-Pearson optimality of the ROC curve** -- The ROC curve arises naturally from the Neyman-Pearson framework. The optimal decision rule $\delta^*(\alpha) = \operatorname{argmax}_\delta\, p_D(\delta)$ subject to $p_F(\delta) \le \alpha$ is solved by the likelihood ratio test: reject $H_0$ when $L(y) = f_1(y)/f_0(y) \ge \eta$. Sweeping the critical level $\alpha$ traces out the ROC curve as the set of achievable $(p_F, p_D)$ pairs. Any other decision rule produces a point on or below the optimal ROC curve. [@chan2021probabilitydatascience, pp. 585--586, 591--593, Def. 9.2, Thm. 9.2]

- **AUC of a blind guess is 0.5** -- A decision rule that ignores the observation and rejects $H_0$ with probability $\alpha$ has $p_F(\alpha) = \alpha$ and $p_D(\alpha) = \alpha$. Its ROC curve is the diagonal $p_D = p_F$, so its AUC is exactly 0.5. Any classifier with AUC below 0.5 is worse than random guessing; flipping its decisions produces a classifier with AUC $= 1 - \text{original AUC} > 0.5$. [@chan2021probabilitydatascience, pp. 594--598, Ex. 9.17]

- **Precision and recall (formal definitions from rates)** -- Precision $= \text{TP}/(\text{TP} + \text{FP}) = \pi p_D / (\pi p_D + (1-\pi) p_F)$, where $\pi$ is the class prevalence, measures how trustworthy the positive claims are. Recall $= p_D = \text{TP}/(\text{TP} + \text{FN})$ measures how completely positives are detected. The two trade off: lowering the threshold increases recall but can decrease precision. [@chan2021probabilitydatascience, pp. 603--604, Def. 9.4, Eqs. 9.40--9.43]

- **ROC-PR equivalence** -- There is a one-to-one correspondence between ROC and PR curves. The conversion depends on the class prevalence $\pi = P/(P+N)$: precision $= \pi p_D / (\pi p_D + (1-\pi) p_F)$ and recall $= p_D$. Any ROC curve can be converted to a PR curve and vice versa given the prevalence; they carry the same information but offer different interpretations. The PR curve of a blind-guess decision rule is a horizontal line at precision $= \pi$. [@chan2021probabilitydatascience, pp. 605--606, Thm. 9.3, Eq. 9.44]

## Prerequisites

What you must already understand for this concept to make sense:

- [bias-variance-trade-off](bias-variance-trade-off.md) -- the idea of test error vs. training error motivates why overall error rate alone is insufficient.
- [k-nearest-neighbors](k-nearest-neighbors.md) -- the Bayes classifier and the 50% posterior probability threshold are introduced alongside KNN.
- [conditional-probability](conditional-probability.md) -- posterior class probabilities $\Pr(Y = k \mid X = x)$ are the foundation for all classification rules.

## Misconceptions & learner traps

- **"Low overall error rate means the classifier is good"** -- When classes are highly imbalanced (e.g., 3.33% default rate), a trivial classifier that always predicts the majority class achieves an error rate of only 3.33%. A more useful classifier may have a slightly higher overall error rate but far better sensitivity for the minority class. [@james2021introductionstatisticallearning, pp. 148--149]

- **"The 50% threshold is always the right threshold"** -- The Bayes-optimal 50% threshold minimizes the total error rate, but in many applications the costs of false positives and false negatives are very different. A credit card company may prefer a 20% threshold to catch more defaulters, even though the overall error rate increases from 2.75% to 3.73%. The right threshold depends on domain-specific costs. [@james2021introductionstatisticallearning, pp. 149--150]

- **"Sensitivity and specificity can both be maximized simultaneously"** -- They trade off against each other: increasing sensitivity (by lowering the threshold) necessarily decreases specificity. The ROC curve makes this trade-off explicit. The only way to improve both simultaneously is to use a better classifier, not a different threshold. [@james2021introductionstatisticallearning, p. 150]

## Teaching insights & analogies

- **The credit-card default example as a running case study** -- ISL uses the Default dataset throughout Chapter 4 to illustrate every evaluation metric. The 2.75% training error rate from LDA sounds good, but inspection of the confusion matrix reveals that 75.7% of actual defaulters are missed (sensitivity = 24.3%). This dramatic gap between overall accuracy and class-specific performance is the motivating example for all the evaluation tools. [@james2021introductionstatisticallearning, pp. 148--149]

- **Two confusion matrices, two thresholds** -- ISL displays the confusion matrix at the default 50% threshold (Table 4.4) and at a 20% threshold (Table 4.5) side by side. Comparing them makes the sensitivity-specificity trade-off concrete: sensitivity jumps from 24.3% to 58.6%, but 235 non-defaulters are now incorrectly flagged (up from 23). [@james2021introductionstatisticallearning, pp. 148--150]

- **The error-rate-vs-threshold plot (Figure 4.7)** -- ISL plots overall error rate, class-specific error rate for defaulters, and class-specific error rate for non-defaulters as a function of the threshold. The three curves diverge sharply: the threshold that minimizes overall error (0.5) is terrible for defaulters. This visual is more intuitive than the ROC curve for a first encounter with the trade-off. [@james2021introductionstatisticallearning, p. 150]

- **Connection to hypothesis testing** -- ISL explicitly maps the confusion matrix onto hypothesis testing terminology: "+" = non-null, "-" = null; FP = Type I error, FN = Type II error, sensitivity = power. This bridge helps learners who know hypothesis testing understand classifier evaluation without learning a wholly new vocabulary. [@james2021introductionstatisticallearning, p. 152]

- **Neyman-Pearson as the theoretical foundation for ROC** -- Chan derives the ROC curve from the Neyman-Pearson optimization: each point on the ROC corresponds to an optimal decision rule $\delta^*(\alpha)$ that maximizes detection for a given false alarm budget. The curve itself is the Pareto frontier of achievable $(p_F, p_D)$ pairs, and the likelihood ratio test produces it. This explains *why* the ROC curve is concave (the NP solution is optimal) and *why* AUC measures classifier quality (it integrates over all possible operating points). [@chan2021probabilitydatascience, pp. 585--593]

- **PR curve vs. ROC for imbalanced classes** -- The PR curve behaves very differently from the ROC curve on the same data: it can be non-monotone and jagged, especially on empirical data. The ROC may look smooth and optimistic while the PR curve reveals poor precision at high recall. Both carry the same information (Thm. 9.3 establishes the one-to-one correspondence), but they emphasize different aspects of performance. [@chan2021probabilitydatascience, pp. 605--606, Figs. 9.31--9.33]

## How the field talks about it

When a paper says a classifier has "high AUC," it means the classifier discriminates well between classes across all thresholds. "Sensitivity" and "specificity" are the standard medical/epidemiological terms; machine learning papers often say "recall" (= sensitivity) and "precision" (= positive predictive value). The ROC curve is ubiquitous in biomedical literature for comparing diagnostic tests and classifiers. When a paper reports "the AUC was 0.82," the classifier correctly ranks a random positive case above a random negative case 82% of the time. [@james2021introductionstatisticallearning, pp. 150--153]
