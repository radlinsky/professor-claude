---
title: "Model selection and information criteria"
topic: statistical-learning
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

Methods for choosing among a collection of models that differ in which predictors they include, balancing goodness of fit against model complexity by either adjusting the training error (information criteria) or directly estimating the test error (cross-validation). [@james2021introductionstatisticallearning, pp. 225--226, 232--237]

**Also known as:** variable selection, feature selection, model comparison

## Definition(s)

**Best subset selection** fits a separate least squares regression for each possible combination of the $p$ predictors -- all $p$ one-predictor models, all $\binom{p}{2}$ two-predictor models, and so on -- then selects the best model of each size by RSS (or equivalently $R^2$), and finally chooses among the $p + 1$ best models using an estimate of test error. The total number of models is $2^p$, making it computationally infeasible for $p$ greater than about 40. [@james2021introductionstatisticallearning, pp. 227--228]

**Forward stepwise selection** begins with the null model (no predictors) and adds one predictor at a time, choosing at each step the variable that gives the greatest additional improvement to the fit. It considers $1 + p(p+1)/2$ models, far fewer than best subset selection, but is not guaranteed to find the best model among all $2^p$ possibilities. It can be applied even when $p > n$ (unlike backward selection or best subset). [@james2021introductionstatisticallearning, pp. 229--231]

**Backward stepwise selection** begins with the full model (all $p$ predictors) and removes the least useful predictor one at a time. Like forward selection, it searches $1 + p(p+1)/2$ models. It requires $n > p$ (so the full model can be fit). [@james2021introductionstatisticallearning, pp. 231--232]

**$C_p$** (Mallow's $C_p$) estimates the test MSE for a least squares model with $d$ predictors: $C_p = \frac{1}{n}(\text{RSS} + 2d\hat\sigma^2)$, where $\hat\sigma^2$ is an estimate of the error variance. If $\hat\sigma^2$ is unbiased, $C_p$ is an unbiased estimate of test MSE. We select the model with the lowest $C_p$. [@james2021introductionstatisticallearning, pp. 233--234, Eq. 6.2]

**AIC** (Akaike information criterion) is defined for a large class of models fit by maximum likelihood. For least squares models with Gaussian errors, AIC is proportional to $C_p$: $\text{AIC} = \frac{1}{n}(\text{RSS} + 2d\hat\sigma^2)$. [@james2021introductionstatisticallearning, p. 234]

**BIC** (Bayesian information criterion) replaces the $2d\hat\sigma^2$ penalty of $C_p$ with $\log(n) \cdot d\hat\sigma^2$: $\text{BIC} = \frac{1}{n}(\text{RSS} + \log(n) d\hat\sigma^2)$. Since $\log n > 2$ for any $n > 7$, BIC penalizes large models more heavily than $C_p$ and tends to select smaller models. [@james2021introductionstatisticallearning, p. 234, Eq. 6.3]

**Adjusted $R^2$** is calculated as $1 - \frac{\text{RSS}/(n - d - 1)}{\text{TSS}/(n - 1)}$. Unlike $R^2$ (which always increases with more variables), adjusted $R^2$ penalizes unnecessary variables through the $d$ in the denominator of the RSS term. A large adjusted $R^2$ indicates a model with a small test error. [@james2021introductionstatisticallearning, pp. 234--235, Eq. 6.4]

**One-standard-error rule:** when several models have similar estimated test errors, select the smallest model (fewest predictors) for which the estimated test error is within one standard error of the minimum. The rationale is that if a set of models appear equally good, the simplest one is preferable. [@james2021introductionstatisticallearning, p. 237]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $\mathcal{M}_k$ | "script M sub k" | The best model containing exactly $k$ predictors [@james2021introductionstatisticallearning, p. 227] |
| $C_p$ | "C sub p" or "Mallow's C-p" | Estimate of test MSE: $(1/n)(\text{RSS} + 2d\hat\sigma^2)$ [@james2021introductionstatisticallearning, p. 233, Eq. 6.2] |
| $d$ | "d" | The number of predictors in the fitted model [@james2021introductionstatisticallearning, p. 233] |
| $\hat\sigma^2$ | "sigma-hat squared" | Estimate of the error variance $\sigma^2$, typically from the full model [@james2021introductionstatisticallearning, p. 233] |

## Key results & derivations

- **Training RSS and $R^2$ cannot select among models of different sizes** -- RSS decreases monotonically and $R^2$ increases monotonically as more predictors are added, so using them to select among $\mathcal{M}_0, \ldots, \mathcal{M}_p$ will always choose the full model. A low training RSS does not guarantee a low test error. [@james2021introductionstatisticallearning, pp. 228, 232--233]

- **BIC selects smaller models than $C_p$/AIC** -- Because BIC replaces the $2d$ penalty with $\log(n) \cdot d$, and $\log n > 2$ for $n > 7$, BIC places a heavier penalty on model size. On the Credit data, BIC selects a 4-variable model while $C_p$ selects a 6-variable model. [@james2021introductionstatisticallearning, pp. 233--235]

- **$C_p$, AIC, and BIC all have rigorous asymptotic justifications** -- These justifications rely on $n$ being very large. Despite its popularity and intuitive appeal, adjusted $R^2$ is not as well motivated in statistical theory as AIC, BIC, and $C_p$. [@james2021introductionstatisticallearning, p. 235]

- **Cross-validation provides a direct estimate of test error** -- CV has an advantage over AIC, BIC, $C_p$, and adjusted $R^2$ in that it makes fewer assumptions about the true model and can be applied in a wider range of settings. When CV is used for model selection, the best subset is determined separately within each training fold, and the validation errors are averaged to select the best model size $k$. The model $\mathcal{M}_k$ is then refit on the full data. [@james2021introductionstatisticallearning, pp. 235--237]

- **Forward stepwise is not guaranteed to find the global best model** -- With $p = 3$ predictors, if the best one-variable model contains $X_1$ and the best two-variable model contains $X_2$ and $X_3$, forward stepwise will miss it because $\mathcal{M}_2$ must include $X_1$. However, in practice forward stepwise tends to perform well and is the only option when $p \geq n$. [@james2021introductionstatisticallearning, pp. 230--231]

- **Best subset selection suffers from statistical and computational problems with large $p$** -- Beyond computational infeasibility ($2^{20} > 1{,}000{,}000$ models), a huge search space increases the chance of finding models that fit the training data well by chance, leading to overfitting and high variance of coefficient estimates. [@james2021introductionstatisticallearning, pp. 228--229]

## Prerequisites

What you must already understand for this concept to make sense:

- [bias-variance-trade-off](bias-variance-trade-off.md) -- the motivation for model selection is that training error underestimates test error, and more flexible models have lower bias but higher variance.
- [resampling-bootstrap-and-permutation](resampling-bootstrap-and-permutation.md) -- cross-validation is one of the two main approaches to model selection (the other being information criteria).

## Misconceptions & learner traps

- **"The model with the best training RSS is the best model"** -- Training RSS always decreases (and $R^2$ always increases) as more variables are added. This tells you about training fit, not test performance. Selecting the model with the lowest RSS among models of different sizes will always choose the full model, which may overfit badly. [@james2021introductionstatisticallearning, pp. 228, 232]

- **"Forward and backward stepwise selection give the same answer"** -- The two methods explore different paths through model space and generally give similar but not identical results. On the Credit data, the first three models match but the four-variable models differ. [@james2021introductionstatisticallearning, pp. 231--232]

- **"The model that minimizes estimated test error is clearly the best"** -- Estimated test error curves are often quite flat past a certain model size. The one-standard-error rule addresses this: if several models have similar test errors, prefer the simplest. [@james2021introductionstatisticallearning, pp. 236--237]

- **"Adjusted $R^2$ is just as rigorous as AIC and BIC"** -- Despite its popularity and intuitive appeal, adjusted $R^2$ has weaker theoretical justification than AIC, BIC, and $C_p$, which all have rigorous asymptotic derivations. [@james2021introductionstatisticallearning, p. 235]

## Teaching insights & analogies

- **The Credit data as a running example** -- ISL uses the Credit data set (10 predictors, one three-level factor expanded to 11 variables) throughout Section 6.1 to illustrate best subset selection, stepwise methods, and all four information criteria. Figure 6.1 shows the RSS/R^2 frontier; Figure 6.2 shows $C_p$, BIC, and adjusted $R^2$; Figure 6.3 compares BIC, validation set, and 10-fold CV error curves. This consistent example makes the differences between criteria concrete. [@james2021introductionstatisticallearning, pp. 228--237]

- **Two approaches framing** -- ISL frames model selection as a two-approach problem: (1) indirectly estimate test error by adjusting training error (information criteria), or (2) directly estimate test error (cross-validation). This clean dichotomy helps learners organize the many available methods. [@james2021introductionstatisticallearning, p. 232]

- **Algorithm boxes for each method** -- ISL presents best subset (Algorithm 6.1), forward stepwise (Algorithm 6.2), and backward stepwise (Algorithm 6.3) in formal algorithm boxes with identical three-step structures, making the differences visible at a glance. [@james2021introductionstatisticallearning, pp. 227--231]

## How the field talks about it

When a paper says "we used BIC for model selection," it means the model with the lowest BIC was chosen from a set of candidates. "Forward selection" or "stepwise regression" typically refers to forward stepwise selection; "backward elimination" is backward stepwise. When a paper reports "the AIC-best model," it means the model minimizing AIC. The one-standard-error rule is common in papers using cross-validation for tuning parameter selection (e.g., choosing $\lambda$ for the lasso), not just for subset selection. [@james2021introductionstatisticallearning, pp. 232--237]
