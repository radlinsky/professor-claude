---
title: "False discovery rate and multiple testing"
topic: statistical-inference
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet --- do not leave placeholders. -->

When testing $m$ null hypotheses simultaneously, controlling the error rate for each individual test at level $\alpha$ does not control the overall rate of false discoveries; specialized procedures such as the Bonferroni correction (controlling the family-wise error rate) and the Benjamini--Hochberg procedure (controlling the false discovery rate) are needed. [@james2021introductionstatisticallearning, pp. 559--571]

**Also known as:** multiple testing correction, multiplicity adjustment, FDR control, FWER control

## Definition(s)

**Family-wise error rate (FWER).** The probability of making at least one Type I error (false positive) when performing $m$ hypothesis tests. Using the notation of Table 13.2 in ISL, where $V$ is the number of Type I errors among $m$ tests: $\text{FWER} = \Pr(V \geq 1)$. [@james2021introductionstatisticallearning, p. 560, Eq. 13.3]

**False discovery proportion (FDP).** The ratio of false positives to total rejections: $V/R$, where $V$ is the number of true null hypotheses incorrectly rejected and $R$ is the total number of rejections. By convention, $\text{FDP} = 0$ when $R = 0$ (no rejections means no false discoveries). The FDP is a random quantity that cannot be controlled directly because the analyst does not know which hypotheses are truly null. [@james2021introductionstatisticallearning, p. 569]

**False discovery rate (FDR).** The expected value of the false discovery proportion: $\text{FDR} = \text{E}(V/R)$. When we control the FDR at level $q$, we are guaranteeing that on average no more than a fraction $q$ of rejected null hypotheses are false positives. On a given dataset, the actual false discovery proportion may be above or below $q$. [@james2021introductionstatisticallearning, p. 569, Eq. 13.9]

**Bonferroni correction.** To control the FWER at level $\alpha$ when testing $m$ null hypotheses, reject only those hypotheses with $p$-value below $\alpha/m$. This follows from the union bound: $\text{FWER} \leq m \times (\alpha/m) = \alpha$. The Bonferroni correction applies regardless of whether the $m$ tests are independent, but it can be very conservative (the true FWER is often much below $\alpha$). [@james2021introductionstatisticallearning, pp. 562--563, Eq. 13.6]

**Holm's step-down procedure (Algorithm 13.1).** Order the $m$ $p$-values: $p_{(1)} \leq p_{(2)} \leq \cdots \leq p_{(m)}$. Find the smallest index $L$ such that $p_{(j)} > \alpha/(m+1-j)$. Reject all null hypotheses $H_{0j}$ for which $p_j < p_{(L)}$. Holm's method controls the FWER, makes no independence assumptions about the $m$ tests, and is uniformly more powerful than Bonferroni -- it always rejects at least as many null hypotheses. [@james2021introductionstatisticallearning, pp. 563--564, Eq. 13.7]

**Benjamini--Hochberg procedure (Algorithm 13.2).** Order the $m$ $p$-values: $p_{(1)} \leq p_{(2)} \leq \cdots \leq p_{(m)}$. Find $L = \max\{j : p_{(j)} < qj/m\}$. Reject all null hypotheses $H_{0j}$ for which $p_j \leq p_{(L)}$. This controls the FDR at level $q$, provided the $p$-values are independent or only mildly dependent. [@james2021introductionstatisticallearning, pp. 571, Eq. 13.10]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $m$ | "em" | The total number of null hypotheses being tested simultaneously [@james2021introductionstatisticallearning, p. 560] |
| $m_0$ | "em-zero" | The number of null hypotheses that are in fact true (unknown to the analyst) [@james2021introductionstatisticallearning, p. 560] |
| $V$ | "vee" | The number of Type I errors (false positives, or false discoveries): true null hypotheses that were incorrectly rejected [@james2021introductionstatisticallearning, p. 560] |
| $S$ | "ess" | The number of true positives (true discoveries): false null hypotheses correctly rejected [@james2021introductionstatisticallearning, p. 560] |
| $R$ | "arr" | The total number of rejections: $R = V + S$ [@james2021introductionstatisticallearning, p. 560] |
| $\alpha$ | "alpha" | The significance level (Type I error rate) for each individual test, or the target FWER level [@james2021introductionstatisticallearning, pp. 558--560] |
| $q$ | "cue" | The target FDR level in the Benjamini--Hochberg procedure [@james2021introductionstatisticallearning, p. 571] |
| $p_{(j)}$ | "p sub parenthesis j" | The $j$th smallest $p$-value among $m$ tests (the order statistic) [@james2021introductionstatisticallearning, p. 564] |

## Key results & derivations

- **FWER grows rapidly with the number of tests** -- Under independence and with all $m$ null hypotheses true, $\text{FWER}(\alpha) = 1 - (1-\alpha)^m$. With $\alpha = 0.05$ and $m = 100$, $\text{FWER} \approx 0.994$: virtually guaranteed to make at least one Type I error. Even with $\alpha = 0.01$, the FWER first exceeds 0.05 at six tests ($1 - 0.99^6 \approx 0.0585$; at five tests $1 - 0.99^5 \approx 0.0490 < 0.05$). [@james2021introductionstatisticallearning, pp. 560--561, Eq. 13.5]

- **The union bound (Boole's inequality) underlies Bonferroni** -- For any events $A_1, \ldots, A_m$: $\Pr(\cup_{j=1}^m A_j) \leq \sum_{j=1}^m \Pr(A_j)$. Setting the threshold for each test at $\alpha/m$ ensures $\text{FWER} \leq \alpha$ regardless of the dependence structure among the tests. The inequality is what makes Bonferroni conservative: the true FWER may be well below $\alpha$, especially when tests are positively correlated. [@james2021introductionstatisticallearning, pp. 562--563, Eq. 13.6]

- **Holm always dominates Bonferroni** -- Holm's method uses adaptive thresholds $\alpha/(m+1-j)$ instead of a single fixed threshold $\alpha/m$. It controls the FWER at level $\alpha$, requires no independence assumption, and will always reject at least as many null hypotheses as Bonferroni. In the Fund data example with $m = 5$, Holm rejects two null hypotheses while Bonferroni rejects only one. [@james2021introductionstatisticallearning, pp. 563--565]

- **Tukey's method exploits correlation structure** -- When performing $m = G(G-1)/2$ pairwise comparisons of $G$ means, the $p$-values are correlated (they share observations). Tukey's method exploits this to achieve higher power than Bonferroni while still controlling the FWER. [@james2021introductionstatisticallearning, pp. 565--567]

- **FWER control has vanishing power for large $m$** -- Controlling the FWER at 0.05 with $m = 500$ tests results in power below 0.2 (fewer than 20% of false null hypotheses are detected). As $m$ increases, the power to reject any individual false null hypothesis decreases dramatically. This motivates FDR control for large-scale testing. [@james2021introductionstatisticallearning, pp. 568--569]

- **FDR control is milder and more powerful than FWER control** -- Controlling the FDR at level $q$ allows more rejections than controlling the FWER at $\alpha = q$, because the FDR tolerates some false positives among the rejected hypotheses while FWER demands that the probability of even one false positive is small. In the Fund data ($m = 2000$), FWER control via Bonferroni at $\alpha = 0.3$ rejects only 1 hypothesis; FDR control via Benjamini--Hochberg at $q = 0.3$ rejects 279. [@james2021introductionstatisticallearning, pp. 572--573]

- **Benjamini--Hochberg threshold is data-dependent** -- Unlike Bonferroni's fixed threshold $\alpha/m$, the BH rejection threshold $p_{(L)}$ depends on all $m$ observed $p$-values. This means the analyst cannot determine in advance whether a given $p$-value will be rejected; the decision depends on the other $p$-values. This property is shared by Holm's method. [@james2021introductionstatisticallearning, p. 572]

- **Re-sampling approach to FDR estimation** -- When no theoretical null distribution is available (or when its assumptions are questionable), permutation can approximate the null distribution of the test statistic. For $m$ hypothesis tests, the plug-in FDR estimator uses the approximation $\text{FDR} = \text{E}(V/R) \approx \text{E}(V)/R$, where $\text{E}(V)$ is estimated from the number of permuted test statistics exceeding the threshold, and $R$ is the observed number of rejections. This approach (Algorithm 13.4) produces FDR estimates nearly identical to the Benjamini--Hochberg procedure in practice. [@james2021introductionstatisticallearning, pp. 576--579, Eq. 13.13]

## Prerequisites

What you must already understand for this concept to make sense:

- [resampling-bootstrap-and-permutation](resampling-bootstrap-and-permutation.md) -- permutation tests provide an alternative way to compute $p$-values and estimate the FDR when theoretical null distributions are unavailable.

## Misconceptions & learner traps

- **"A $p$-value is the probability that $H_0$ is true"** -- This is perhaps the most common misconception in statistics. The $p$-value is the probability of observing a test statistic at least as extreme as the one observed, under the assumption that $H_0$ is true. It says nothing about the probability that $H_0$ is true. [@james2021introductionstatisticallearning, p. 556]

- **"Controlling the Type I error for each test controls the overall error rate"** -- Rejecting each $H_{0j}$ when $p_j < \alpha$ controls the Type I error for that individual test at $\alpha$, but the probability of at least one false rejection across $m$ tests can be far larger. With $\alpha = 0.01$ and $m = 10{,}000$, we expect about 100 false rejections by chance alone. [@james2021introductionstatisticallearning, p. 559]

- **"Bonferroni is the best multiple testing correction"** -- The Bonferroni correction is the best known but not the most powerful. Holm's method always rejects at least as many hypotheses as Bonferroni while controlling the FWER at the same level; it should always be preferred. When the tests are structured (e.g., pairwise comparisons), specialized methods like Tukey's can achieve even higher power. [@james2021introductionstatisticallearning, pp. 563--565]

- **"FDR control and FWER control are interchangeable"** -- FWER controls the probability of any false positive; FDR controls the expected proportion of rejections that are false positives. When $m$ is large, FWER control is too stringent (very low power), while FDR control remains practical. FDR and FWER control answer different questions and are appropriate in different settings. [@james2021introductionstatisticallearning, pp. 568--569]

- **"Failing to reject $H_0$ means $H_0$ is true"** -- Failing to reject is not evidence for $H_0$; it may simply mean the sample size was too small or the effect was too weak to detect. This is why we say "fail to reject $H_0$" rather than "accept $H_0$." [@james2021introductionstatisticallearning, p. 553]

- **"The FDR threshold is always 0.05"** -- Unlike $p$-value thresholds, there is no standard accepted FDR threshold. The choice is context-dependent: a genomic researcher might use $q = 0.10$ if follow-up is expensive, or $q = 0.30$ if follow-up is cheap. [@james2021introductionstatisticallearning, p. 570]

## Teaching insights & analogies

- **The stockbroker parable (Section 13.2)** -- A stockbroker emails 1,024 potential clients with predictions for Apple's stock price over 10 days. There are $2^{10} = 1{,}024$ possible outcomes; she sends each client a different one. One client will see 10 consecutive correct predictions and become a new client. The stockbroker has no insight -- she just made a lot of guesses. This is exactly the multiple testing problem: when testing many hypotheses, some will appear significant by chance alone. [@james2021introductionstatisticallearning, pp. 558--559]

- **The coin-flipping analogy** -- Flip 1,024 fair coins 10 times each. On average, one coin will come up all tails. A naive hypothesis test would reject the null that this coin is fair ($p < 0.002$), but the null hypothesis holds -- we just tested many coins. This makes the core multiple testing problem viscerally concrete. [@james2021introductionstatisticallearning, p. 559]

- **FWER vs. number of tests curve (Figure 13.2)** -- Plots the FWER as a function of $m$ for $\alpha = 0.05$, $0.01$, and $0.001$ on a log scale. Shows that with $\alpha = 0.05$, the FWER exceeds 0.5 after just 14 tests and approaches 1.0 rapidly. Even $\alpha = 0.001$ is overwhelmed by $m = 500$. Only very small per-test $\alpha$ keeps the FWER low for large $m$. [@james2021introductionstatisticallearning, pp. 560--561]

- **Bonferroni vs. Holm on sorted $p$-values (Figure 13.3)** -- Sorted $p$-values plotted on a log scale with horizontal lines for the Bonferroni threshold (black) and the Holm adaptive thresholds (blue curve, always above). The region between the lines shows hypotheses rejected by Holm but not Bonferroni. True nulls are black dots, false nulls are red. Neither method makes Type I errors in any of the three simulated datasets. [@james2021introductionstatisticallearning, pp. 564--565]

- **Bonferroni vs. BH on the Fund data (Figure 13.6)** -- The BH threshold is a line through the origin with slope $q/m$ (orange), while Bonferroni is a horizontal line at $\alpha/m$ (green). The BH line rises with the index, so hypotheses with moderate $p$-values can be rejected if enough small $p$-values are present. At $q = 0.1$, BH rejects 146 of 2,000 fund managers; Bonferroni at $\alpha = 0.1$ rejects only a handful. [@james2021introductionstatisticallearning, pp. 572--573]

- **Power decay with $m$ (Figure 13.5)** -- Power (proportion of false nulls rejected) plotted against FWER for $m = 10$, $100$, and $500$. At a FWER of 0.05, power drops from ~60% ($m = 10$) to ~40% ($m = 100$) to ~20% ($m = 500$). This visual makes the case for FDR control in high-dimensional settings. [@james2021introductionstatisticallearning, p. 568]

- **The genomics motivation** -- A genomic researcher testing 20,000 genes for association with a disease would expect 1,000 false positives at $\alpha = 0.05$ even if no genes are truly associated. Controlling the FDR at 20% guarantees that the *expected proportion* of reported associations that are false is at most 20% -- a practically useful guarantee for exploratory analyses. [@james2021introductionstatisticallearning, p. 570]

## How the field talks about it

When a paper says "we corrected for multiple testing using Bonferroni," it means $p$-values were compared to $\alpha/m$. "Benjamini--Hochberg corrected" or "BH-adjusted $p$-values" means the FDR was controlled using Algorithm 13.2. "FDR $< 0.05$" means the results are reported at a 5% false discovery rate. In genomics, "$p < 5 \times 10^{-8}$" is the genome-wide significance threshold, essentially a Bonferroni correction for $\sim 10^6$ independent tests. "$q$-values" in some software packages are adjusted $p$-values from the BH procedure. "Adjusted $p$-values" from R's `p.adjust()` function are raw $p$-values multiplied by a correction factor so they can be compared directly to $\alpha$ or $q$; for Bonferroni, the adjusted $p$-value is $\min(mp_j, 1)$. [@james2021introductionstatisticallearning, pp. 562--572, 582]
