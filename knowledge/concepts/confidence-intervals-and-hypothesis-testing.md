---
title: "Confidence intervals and hypothesis testing"
topic: statistical-inference
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

A confidence interval is a random interval $[\hat{\Theta} - \epsilon,\; \hat{\Theta} + \epsilon]$ that has at least a $1 - \alpha$ probability of containing the true parameter $\theta$; hypothesis testing is a principled procedure for deciding whether to reject a default assumption ($H_0$) about $\theta$ based on the data. The two are deeply connected: an observation falls outside a $1 - \alpha$ confidence interval if and only if the corresponding hypothesis test at level $\alpha$ rejects $H_0$. [@chan2021probabilitydatascience, pp. 545--590]

**Also known as:** CI (confidence interval); significance test (hypothesis test); statistical test

## Definition(s)

An **estimator** $\hat{\Theta} = g(X_1, \ldots, X_N)$ is a function of the random samples; it is itself a random variable with its own PDF, CDF, mean, and variance. The **confidence interval** for $\hat{\Theta}$ is the random interval $\mathcal{I} = [\hat{\Theta} - \epsilon,\; \hat{\Theta} + \epsilon]$, where $\epsilon$ is chosen so that $\mathbb{P}[\hat{\Theta} - \epsilon \le \theta \le \hat{\Theta} + \epsilon] \ge 1 - \alpha$. The quantity $1 - \alpha$ is called the **confidence level** (typically 95%). [@chan2021probabilitydatascience, pp. 545--549, Eqs. 9.1--9.4]

The confidence interval is a random interval (it changes with each new dataset); it is *not* the deterministic interval $[\theta - \epsilon, \theta + \epsilon]$. The randomness comes from $\hat{\Theta}$, not from $\theta$. Saying "there is 95% probability that the interval contains $\theta$" refers to the probability over repeated sampling of $\hat{\Theta}$, not to the probability that $\theta$ takes a particular value. [@chan2021probabilitydatascience, pp. 547--549]

A **hypothesis** is a statement that can be tested by observation. In hypothesis testing, two complementary hypotheses are defined: the **null hypothesis** $H_0$ (the default belief, the "status quo") and the **alternative hypothesis** $H_1$ (the claim to be tested). The goal is to determine whether the data provide strong enough evidence to reject $H_0$. [@chan2021probabilitydatascience, pp. 568--569]

The **Student's $t$-distribution** with $\nu$ degrees of freedom has the PDF $f_X(x) = \frac{\Gamma((\nu+1)/2)}{\sqrt{\nu\pi}\,\Gamma(\nu/2)}\left(1 + \frac{x^2}{\nu}\right)^{-(\nu+1)/2}$. It arises when the population variance $\sigma^2$ is unknown and must be replaced by the sample variance $\hat{S}^2 = \frac{1}{N-1}\sum(X_n - \hat{\Theta})^2$. The resulting test statistic $T = (\hat{\Theta} - \theta)/(\hat{S}/\sqrt{N})$ follows a $t$-distribution with $\nu = N - 1$ degrees of freedom. [@chan2021probabilitydatascience, pp. 556--557, Def. 9.1, Eq. 9.10]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $\hat{\Theta}$ | "theta-hat" | An estimator: a function of the random samples $g(X_1, \ldots, X_N)$; a random variable [@chan2021probabilitydatascience, p. 545] |
| $\mathcal{I}$ | "the confidence interval" | The random interval $[\hat{\Theta} - \epsilon,\; \hat{\Theta} + \epsilon]$ [@chan2021probabilitydatascience, p. 547] |
| $1 - \alpha$ | "the confidence level" | The probability that $\mathcal{I}$ contains the true parameter $\theta$; typically 0.95 [@chan2021probabilitydatascience, p. 549] |
| $\text{se}$ | "standard error" | The standard deviation of the estimator: $\text{se} = \sqrt{\text{Var}[\hat{\Theta}]} = \sigma/\sqrt{N}$ (for the sample mean) [@chan2021probabilitydatascience, p. 553, Eq. 9.7] |
| $z_\alpha$ | "z-alpha" or "critical value" | The value such that $\mathbb{P}[\lvert\hat{Z}\rvert \le z_\alpha] = 1 - \alpha$; for a standard Gaussian, $z_\alpha = \Phi^{-1}(1 - \alpha/2)$ [@chan2021probabilitydatascience, p. 553, Eq. 9.8] |
| $H_0, H_1$ | "H-naught, H-one" | Null hypothesis and alternative hypothesis [@chan2021probabilitydatascience, p. 568] |
| $\hat{Z}$ | "Z-hat" | The normalized test statistic $(\hat{\Theta} - \theta)/(\sigma/\sqrt{N})$; follows Gaussian(0,1) when $H_0$ is true and $\sigma$ is known [@chan2021probabilitydatascience, p. 570] |
| $T$ | "the T statistic" | The test statistic $(\hat{\Theta} - \theta)/(\hat{S}/\sqrt{N})$; follows a Student's $t$-distribution with $\nu = N - 1$ degrees of freedom when $\sigma$ is unknown [@chan2021probabilitydatascience, p. 556, Eq. 9.10] |
| $p_F$ | "p-F" or "false alarm rate" | $\mathbb{P}[Y \ge \eta \mid H_0]$: the probability of declaring $H_1$ when $H_0$ is true (Type I error) [@chan2021probabilitydatascience, p. 582, Eq. 9.28] |
| $p_M$ | "p-M" or "miss rate" | $\mathbb{P}[Y < \eta \mid H_1]$: the probability of declaring $H_0$ when $H_1$ is true (Type II error) [@chan2021probabilitydatascience, p. 583, Eq. 9.29] |
| $p_D$ | "p-D" or "power" | $\mathbb{P}[Y \ge \eta \mid H_1] = 1 - p_M$: the probability of correctly detecting $H_1$ (the detection rate) [@chan2021probabilitydatascience, p. 583, Eq. 9.30] |
| $L(y)$ | "the likelihood ratio" | $f_1(y)/f_0(y)$: the ratio of the alternative PDF to the null PDF [@chan2021probabilitydatascience, p. 586, Def. 9.3, Eq. 9.35] |
| $R_\alpha$ | "the rejection zone" | The set of test-statistic values for which we reject $H_0$: $R_\alpha = \{y \mid \text{reject } H_0 \text{ at level } \alpha\}$ [@chan2021probabilitydatascience, p. 581, Eq. 9.27] |

## Key results & derivations

- **95% confidence interval (known variance)** -- For i.i.d. $X_n \sim \text{Gaussian}(\theta, \sigma^2)$ with $\sigma$ known, the 95% CI is $[\hat{\Theta} - 1.96\,\sigma/\sqrt{N},\; \hat{\Theta} + 1.96\,\sigma/\sqrt{N}]$, where $1.96 = \Phi^{-1}(0.975)$. This does not require knowing $\theta$ at any point. [@chan2021probabilitydatascience, p. 552, Eq. 9.5]

- **Margin of error** -- The margin of error is $z_\alpha \cdot \sigma/\sqrt{N}$, the half-width of the confidence interval. It shrinks as $\sqrt{N}$ (more data = narrower CI) and grows with $\sigma$ (more variability = wider CI). To achieve a margin of error $< \epsilon$ at a given confidence level, we need $N \ge (z_\alpha \sigma/\epsilon)^2$. [@chan2021probabilitydatascience, p. 554, Eq. 9.9]

- **Student's $t$-distribution CI (unknown variance)** -- When $\sigma$ is unknown and replaced by the sample standard deviation $\hat{S}$, the CI becomes $[\hat{\Theta} - z_\alpha\,\hat{S}/\sqrt{N},\; \hat{\Theta} + z_\alpha\,\hat{S}/\sqrt{N}]$ where $z_\alpha = \Psi_\nu^{-1}(1 - \alpha/2)$ with $\nu = N - 1$ degrees of freedom and $\Psi_\nu$ is the CDF of the $t$-distribution. The $t$-distribution has heavier tails than the Gaussian, so $z_\alpha$ is larger (wider CI) for small $N$. [@chan2021probabilitydatascience, pp. 556--557, Eq. 9.12]

- **Student's $t$ converges to Gaussian** -- As $\nu \to \infty$, the $t$-distribution PDF converges to the standard Gaussian PDF. The practical rule: for $N \le 30$, use Student's $t$; for $N \ge 30$, the Gaussian approximation suffices. [@chan2021probabilitydatascience, pp. 560--561, Thm. 9.1, Eq. 9.13]

- **Critical-value test** -- Compute $\hat{Z} = (\hat{\Theta} - \theta)/(\sigma/\sqrt{N})$; reject $H_0$ if $\hat{Z} \ge z_\alpha$ (one-sided) or $|\hat{Z}| \ge z_\alpha$ (two-sided). The critical value $z_\alpha$ is the cutoff on the standardized axis corresponding to the desired significance level $\alpha$. [@chan2021probabilitydatascience, pp. 571--572, Eqs. 9.24--9.25]

- **$p$-value test** -- The $p$-value is $\mathbb{P}[\hat{Z} \le \hat{z}]$ (left-tail) or $\mathbb{P}[\hat{Z} \ge \hat{z}]$ (right-tail), where $\hat{z}$ is the observed value of the test statistic under $H_0$. Reject $H_0$ if $p\text{-value} < \alpha$. The $p$-value and critical-value tests always give the same conclusion because of the one-to-one correspondence $\hat{z} = \Phi^{-1}(p\text{-value})$. [@chan2021probabilitydatascience, pp. 573--575, Eq. 9.26]

- **Z-test vs. T-test** -- Both test the sample mean. The Z-test assumes known variance and uses the Gaussian distribution; the T-test assumes unknown variance and uses Student's $t$-distribution with $\nu = N - 1$. Both can be implemented via either the critical-value or $p$-value approach. [@chan2021probabilitydatascience, pp. 576--579]

- **Type I and Type II errors** -- Type I error (false positive / false alarm): declaring $H_1$ when $H_0$ is true, with probability $p_F = \mathbb{P}[Y \ge \eta \mid H_0]$. Type II error (false negative / miss): declaring $H_0$ when $H_1$ is true, with probability $p_M = \mathbb{P}[Y < \eta \mid H_1]$. The power (detection rate) is $p_D = 1 - p_M$. Lowering $p_F$ necessarily increases $p_M$ (and vice versa) for a fixed sample size and effect size. [@chan2021probabilitydatascience, pp. 581--583, Eqs. 9.28--9.30]

- **Neyman-Pearson decision rule** -- The optimal decision rule $\delta^*$ maximizes the detection rate $p_D(\delta)$ subject to a constraint on the false alarm rate $p_F(\delta) \le \alpha$. The optimum occurs at $p_F(\delta) = \alpha$ (using the full budget). [@chan2021probabilitydatascience, pp. 585--586, Def. 9.2, Eq. 9.34]

- **Likelihood ratio test solves Neyman-Pearson** -- The solution to the Neyman-Pearson optimization is the likelihood ratio test: reject $H_0$ if $L(y) = f_1(y)/f_0(y) \ge \eta$, for a threshold $\eta$ determined by the constraint $p_F(\delta^*) = \alpha$. The critical-value test and $p$-value test are special cases of the likelihood ratio test when the distributions are Gaussian. [@chan2021probabilitydatascience, pp. 586--589, Def. 9.3, Thm. 9.2, Eq. 9.36]

- **ROC-PR equivalence** -- The false alarm rate and detection rate can be expressed in terms of precision and recall: $p_F = \text{recall}(1 - \text{precision})/\text{precision}$ and $p_D = \text{recall}$. This means any ROC curve can be converted to a PR curve and vice versa; they carry the same information but offer different interpretations. [@chan2021probabilitydatascience, p. 605, Thm. 9.3, Eq. 9.44]

## Prerequisites

- [sample-statistics-and-convergence](sample-statistics-and-convergence.md) -- the CLT justifies treating the standardized sample mean as approximately Gaussian, which underpins the CI construction and Z-test.
- [likelihood-and-log-likelihood](likelihood-and-log-likelihood.md) -- the likelihood ratio test is the optimal solution to the Neyman-Pearson optimization; understanding likelihood functions is essential.
- [random-variables-and-distributions](random-variables-and-distributions.md) -- the Gaussian CDF $\Phi$ and the $t$-distribution CDF $\Psi_\nu$ are the main tools for computing critical values and $p$-values.
- [continuous-named-distributions](continuous-named-distributions.md) -- the Gaussian and Student's $t$-distribution are the two reference distributions for all the tests.

## Misconceptions & learner traps

- **"A 95% CI means there is 95% probability that $\theta$ is in the interval"** -- The parameter $\theta$ is a fixed constant; it either is or is not in any particular realized interval. The 95% refers to the procedure: if you construct 100 random intervals from 100 independent datasets, about 95 of them will contain $\theta$. The randomness is in $\hat{\Theta}$, not in $\theta$. [@chan2021probabilitydatascience, pp. 547--549]

- **"Failing to reject $H_0$ proves $H_0$ is true"** -- Failing to reject $H_0$ means the data do not provide sufficient evidence against it at the chosen significance level. It does not prove $H_0$ is true; it could be that the sample size is too small to detect the effect (low power). [@chan2021probabilitydatascience, pp. 568, 571]

- **"A small $p$-value means the effect is large"** -- A small $p$-value means the observed test statistic is unlikely under $H_0$. With large $N$, even a tiny effect can produce a small $p$-value because $\hat{Z} = (\hat{\Theta} - \theta)/(\sigma/\sqrt{N})$ grows with $\sqrt{N}$. Statistical significance is not the same as practical significance. [@chan2021probabilitydatascience, pp. 571, 573]

- **"The Z-test and T-test give different conclusions"** -- They use different reference distributions (Gaussian vs. Student's $t$) but address the same question. For large $N$, the $t$-distribution approaches the Gaussian and the two tests agree. For small $N$, the $t$-test is more conservative (wider CI, higher critical value) because it accounts for the uncertainty in estimating $\sigma$. [@chan2021probabilitydatascience, pp. 556, 576--579]

- **"Bootstrapping improves the point estimate"** -- Bootstrapping estimates the *variance* of the estimator and thereby provides a confidence interval. It does not change the point estimate at all: no matter how many bootstrap samples you synthesize, the original estimate stays the same. Bootstrapping uses whatever data you have and tells you how reliable the estimate is; it does not create information from nothing. [@chan2021probabilitydatascience, p. 607]

## Teaching insights & analogies

- **The courthouse analogy for hypothesis testing** -- Chan compares hypothesis testing to a court trial: the null hypothesis is "the defendant is innocent" (the default assumption). The prosecution must provide strong enough evidence to reject the null. Failing to convict does not prove innocence; it means the evidence was insufficient. [@chan2021probabilitydatascience, p. 568]

- **Random interval vs. deterministic interval visualization** -- Figure 9.2 contrasts the confidence interval $[\hat{\Theta} - \epsilon, \hat{\Theta} + \epsilon]$ (left: the interval moves, $\theta$ is fixed) with the deterministic interval $[\theta - \epsilon, \theta + \epsilon]$ (right: the interval is fixed, $\hat{\Theta}$ moves). The left side is what we compute; the right side is what we cannot compute because $\theta$ is unknown. [@chan2021probabilitydatascience, p. 548, Fig. 9.2]

- **Estimation hierarchy tree** -- Figure 9.8 organizes all estimation techniques: point estimation (MLE, MAP, MMSE) on the left, confidence intervals on the right. Under confidence intervals: sample mean with known variance (Gaussian CI), unknown variance (Student's $t$-CI), and other estimators (bootstrap). This tree helps learners see where each technique fits. [@chan2021probabilitydatascience, p. 562, Fig. 9.8]

- **Hypothesis test hierarchy** -- Figure 9.14 organizes hypothesis tests by assumption: known variance uses the Gaussian distribution (Z-test), unknown variance uses Student's $t$ (T-test). Each can be implemented via $p$-value or critical-value approach. The hierarchy makes the ocean of named tests manageable: pick the distribution first, then the tool. [@chan2021probabilitydatascience, p. 576, Fig. 9.14]

- **The $\hat{\Theta}$-axis and $\hat{Z}$-axis dual view** -- Figures 9.10--9.12 show two parallel axes: the estimator $\hat{\Theta}$ on one, the standardized $\hat{Z}$ on the other. This dual view makes explicit that comparing $\hat{Z}$ to $z_\alpha$ is the same as asking "how far is $\hat{\Theta}$ from the hypothesized $\theta$?" in units of standard error. [@chan2021probabilitydatascience, pp. 570--574, Figs. 9.10--9.12]

- **Neyman-Pearson as a constrained optimization** -- Instead of ad hoc threshold choices, Neyman-Pearson frames hypothesis testing as: maximize $p_D$ subject to $p_F \le \alpha$. This formulation (a) explains *why* the critical-value test is optimal (it maximizes power for a given false alarm budget) and (b) connects hypothesis testing to ROC curves (sweeping $\alpha$ traces out the ROC). [@chan2021probabilitydatascience, pp. 585--586, 591]

## How the field talks about it

"Confidence interval" or "CI" is standard; "$1 - \alpha$ confidence" means the interval captures the true parameter in $100(1-\alpha)\%$ of repeated experiments. "Significance level" $\alpha$ is both the Type I error rate and the complement of the confidence level. When a paper says "significant at the 5% level" or "$p < 0.05$," it means the $p$-value is below 0.05 and $H_0$ is rejected. "Power" means $1 - \beta$ where $\beta$ is the Type II error rate; "power analysis" computes the sample size needed to achieve a target power. "Likelihood ratio test" (LRT) generalizes to composite hypotheses and nested models; when a paper reports a "likelihood ratio statistic," it is the log-ratio $\log(f_1/f_0)$ evaluated at the data. "Z-test" signals known variance; "T-test" (or "Student's $t$-test") signals unknown variance estimated from the sample. The Neyman-Pearson lemma is the fundamental optimality result: the likelihood ratio test is the most powerful test at any given significance level. [@chan2021probabilitydatascience, pp. 549, 571, 576, 586--589]
