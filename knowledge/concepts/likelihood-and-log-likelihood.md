---
title: "Likelihood and log-likelihood"
topic: statistical-inference
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

The likelihood function $\mathcal{L}(\boldsymbol{\theta} \mid \boldsymbol{x})$ is the joint PDF (or PMF) of the observed data viewed as a function of the unknown parameter $\boldsymbol{\theta}$, not a function of the data. Maximizing the likelihood -- or equivalently its logarithm, the log-likelihood -- yields the maximum-likelihood estimate (MLE), one of the most widely used parameter estimation methods in statistics and data science. [@chan2021probabilitydatascience, pp. 468--472]

**Also known as:** MLE (maximum-likelihood estimation); ML estimation; ML estimate

## Definition(s)

Given i.i.d. random variables $X_1, \ldots, X_N$ that all have the same PDF $f_{X_n}(x_n; \boldsymbol{\theta})$, the **likelihood function** is

$$\mathcal{L}(\boldsymbol{\theta} \mid \boldsymbol{x}) \stackrel{\text{def}}{=} \prod_{n=1}^{N} f_{X_n}(x_n;\, \boldsymbol{\theta}).$$

The likelihood is *not* a conditional PDF because $\boldsymbol{\theta}$ is not a random variable; the correct interpretation is that $\mathcal{L}$ is a function of $\boldsymbol{\theta}$ whose shape changes according to the observed data $\boldsymbol{x}$. [@chan2021probabilitydatascience, pp. 468--469, Def. 8.2]

The **log-likelihood** is

$$\log \mathcal{L}(\boldsymbol{\theta} \mid \boldsymbol{x}) = \sum_{n=1}^{N} \log f_{X_n}(x_n;\, \boldsymbol{\theta}).$$

The product-to-sum conversion makes computation easier and avoids numerical underflow. [@chan2021probabilitydatascience, pp. 469--470, Def. 8.3]

The **maximum-likelihood estimate** (MLE) is the parameter value that maximizes the likelihood:

$$\hat{\boldsymbol{\theta}}_{\text{ML}} \stackrel{\text{def}}{=} \operatorname*{argmax}_{\boldsymbol{\theta}}\; \mathcal{L}(\boldsymbol{\theta} \mid \boldsymbol{x}).$$

Because the logarithm is monotonically increasing, maximizing $\mathcal{L}$ is equivalent to maximizing $\log \mathcal{L}$. [@chan2021probabilitydatascience, p. 472, Def. 8.4]

**Estimator vs. estimate:** The MLE $\hat{\theta}_{\text{ML}}(\boldsymbol{x})$ is a number (a function of observed data $\boldsymbol{x}$); the corresponding *estimator* $\hat{\Theta}_{\text{ML}}(X_1, \ldots, X_N) = (1/N)\sum X_n$ (for the Gaussian mean case) is a random variable. The estimator is the function that maps data to an estimate; each realization of the data produces a different estimate. [@chan2021probabilitydatascience, pp. 491--492]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $\mathcal{L}(\boldsymbol{\theta} \mid \boldsymbol{x})$ | "the likelihood of theta given x" | The joint PDF evaluated at the observed data, viewed as a function of $\boldsymbol{\theta}$ [@chan2021probabilitydatascience, p. 469] |
| $\log \mathcal{L}(\boldsymbol{\theta} \mid \boldsymbol{x})$ | "the log-likelihood" | The logarithm of the likelihood; turns the product into a sum [@chan2021probabilitydatascience, p. 470] |
| $\hat{\boldsymbol{\theta}}_{\text{ML}}$ | "theta-hat ML" | The maximum-likelihood estimate: the $\boldsymbol{\theta}$ that maximizes $\mathcal{L}$ [@chan2021probabilitydatascience, p. 472] |
| $\hat{\Theta}_{\text{ML}}$ | "Theta-hat ML" (capital) | The ML *estimator*: the random variable version obtained by replacing the observed data $\boldsymbol{x}$ with random variables $X_1, \ldots, X_N$ [@chan2021probabilitydatascience, p. 491] |
| $S = \sum_{n=1}^{N} x_n$ | "the sufficient statistic S" | For Bernoulli data, the log-likelihood depends on $\boldsymbol{x}$ only through $S$; plotting $\mathcal{L}(\theta \mid S)$ gives the cross section of the likelihood surface at a fixed data summary [@chan2021probabilitydatascience, pp. 471--472] |

## Key results & derivations

- **MLE for Bernoulli** -- For $X_n \sim \text{Bernoulli}(\theta)$, the log-likelihood is $S \log \theta + (N - S) \log(1 - \theta)$ where $S = \sum x_n$. Setting the derivative to zero gives $\hat{\theta}_{\text{ML}} = S/N = (1/N)\sum x_n$, the sample proportion. [@chan2021probabilitydatascience, pp. 472--473, Example 8.4]

- **MLE for Gaussian mean (known variance)** -- For $X_n \sim \text{Gaussian}(\theta, \sigma^2)$ with $\sigma^2$ known, the log-likelihood is $-(N/2)\log(2\pi\sigma^2) - (1/2\sigma^2)\sum(x_n - \theta)^2$. The MLE is $\hat{\theta}_{\text{ML}} = (1/N)\sum x_n$, the sample mean. [@chan2021probabilitydatascience, pp. 474--477]

- **MLE for Gaussian mean and variance** -- With both $\mu$ and $\sigma^2$ unknown, taking partial derivatives of the log-likelihood with respect to $\mu$ and $\sigma^2$ and setting them to zero gives $\hat{\mu}_{\text{ML}} = (1/N)\sum x_n$ and $\hat{\sigma}^2_{\text{ML}} = (1/N)\sum(x_n - \hat{\mu}_{\text{ML}})^2$. [@chan2021probabilitydatascience, pp. 484--485, Eq. 8.14]

- **MLE for Poisson** -- For $X_n \sim \text{Poisson}(\lambda)$, the MLE is $\hat{\lambda}_{\text{ML}} = (1/N)\sum x_n$, the sample mean. [@chan2021probabilitydatascience, pp. 485--486, Eq. 8.16]

- **MLE for high-dimensional Gaussian mean** -- For $\boldsymbol{X}_n \sim \text{Gaussian}(\boldsymbol{\mu}, \boldsymbol{\Sigma})$ with known $\boldsymbol{\Sigma}$, the MLE is $\hat{\boldsymbol{\mu}}_{\text{ML}} = (1/N)\sum \boldsymbol{x}_n$. If both $\boldsymbol{\mu}$ and $\boldsymbol{\Sigma}$ are unknown, $\hat{\boldsymbol{\Sigma}}_{\text{ML}} = (1/N)\sum(\boldsymbol{x}_n - \hat{\boldsymbol{\mu}}_{\text{ML}})(\boldsymbol{x}_n - \hat{\boldsymbol{\mu}}_{\text{ML}})^\top$. [@chan2021probabilitydatascience, pp. 486--487, Eqs. 8.17--8.18]

- **Regression as MLE** -- Under the assumption $\boldsymbol{e} \sim \text{Gaussian}(\boldsymbol{0}, \sigma^2\boldsymbol{I})$, the linear model $\boldsymbol{y} = \boldsymbol{X}\boldsymbol{\theta} + \boldsymbol{e}$ has log-likelihood $-(N/2)\log(2\pi\sigma^2) - (1/2\sigma^2)\lVert\boldsymbol{y} - \boldsymbol{X}\boldsymbol{\theta}\rVert^2$. Maximizing this is equivalent to minimizing $\lVert\boldsymbol{y} - \boldsymbol{X}\boldsymbol{\theta}\rVert^2$, yielding $\hat{\boldsymbol{\theta}}_{\text{ML}} = (\boldsymbol{X}^\top\boldsymbol{X})^{-1}\boldsymbol{X}^\top\boldsymbol{y}$, the OLS solution. The critical distinction: regression makes no distributional assumption (it minimizes squared error because it is differentiable), while MLE obtains the same formula by assuming Gaussian noise. If the noise is not Gaussian, OLS still returns a result but it will not maximize the likelihood. [@chan2021probabilitydatascience, pp. 488--490, Eq. 8.21]

- **Unbiasedness** -- An estimator $\hat{\Theta}$ is *unbiased* if $\mathbb{E}[\hat{\Theta}] = \theta$. The ML estimator for the Gaussian mean, $(1/N)\sum X_n$, is unbiased. [@chan2021probabilitydatascience, pp. 492--493, Def. 8.5]

- **ML variance estimator is biased** -- The ML estimator for the Gaussian variance, $\hat{\sigma}^2_{\text{ML}} = (1/N)\sum(X_n - \hat{\mu}_{\text{ML}})^2$, satisfies $\mathbb{E}[\hat{\sigma}^2_{\text{ML}}] = ((N-1)/N)\sigma^2 \neq \sigma^2$. Dividing by $N - 1$ instead of $N$ gives the unbiased estimator $\hat{\sigma}^2_{\text{unbias}} = (1/(N-1))\sum(X_n - \hat{\mu}_{\text{ML}})^2$ (Bessel's correction). Maximizing the likelihood and achieving unbiasedness are incompatible objectives for the variance. [@chan2021probabilitydatascience, pp. 493--494, Eq. 8.27]

- **Consistency** -- An estimator $\hat{\Theta}_N$ is *consistent* if $\hat{\Theta}_N \xrightarrow{p} \theta$ as $N \to \infty$, i.e., $\lim_{N \to \infty} \mathbb{P}[|\hat{\Theta}_N - \theta| \geq \epsilon] = 0$ for every $\epsilon > 0$. Convergence in mean squared error ($\lim \mathbb{E}[(\hat{\Theta}_N - \theta)^2] = 0$) is sufficient for consistency (via Chebyshev's inequality), but not necessary. Consistency and unbiasedness are independent: an estimator can be unbiased but inconsistent (e.g., $\hat{\Theta} = X_1$), or biased but consistent (e.g., $\hat{\sigma}^2_{\text{ML}}$). Under regularity conditions, ML estimators of i.i.d. data are consistent. [@chan2021probabilitydatascience, pp. 494--499, Def. 8.6]

- **Invariance principle** -- If $\hat{\theta}_{\text{ML}}$ is the MLE of $\theta$, then for any one-to-one function $h$, the MLE of $h(\theta)$ is $h(\hat{\theta}_{\text{ML}})$. This is useful when a direct calculation of $\hat{\eta}_{\text{ML}}$ is harder than computing $\hat{\theta}_{\text{ML}}$ and applying $h$. [@chan2021probabilitydatascience, pp. 500--502, Thm. 8.1]

## Prerequisites

- [random-variables-and-distributions](random-variables-and-distributions.md) -- the likelihood is built from the PDF/PMF of the data-generating distribution.
- [joint-distributions](joint-distributions.md) -- the product form of the likelihood requires the i.i.d. assumption and the joint PDF factorization.
- [sample-statistics-and-convergence](sample-statistics-and-convergence.md) -- consistency uses convergence in probability; the WLLN ensures the sample mean converges.

## Misconceptions & learner traps

- **"The likelihood is a probability distribution over $\boldsymbol{\theta}$"** -- No. The likelihood $\mathcal{L}(\boldsymbol{\theta} \mid \boldsymbol{x})$ is a function of $\boldsymbol{\theta}$, but it does not integrate to 1 over $\boldsymbol{\theta}$. It is not a PDF of $\boldsymbol{\theta}$; that requires a prior (Bayesian framework). [@chan2021probabilitydatascience, p. 469]

- **"MLE always gives an unbiased estimator"** -- The ML estimator for the Gaussian variance divides by $N$ instead of $N - 1$ and is biased. Maximizing the likelihood and achieving unbiasedness are different (sometimes incompatible) objectives. [@chan2021probabilitydatascience, pp. 493--494]

- **"Unbiased implies consistent (or vice versa)"** -- Neither implies the other. If $X_n \sim \text{Gaussian}(\mu, \sigma^2)$, the estimator $\hat{\Theta} = X_1$ is unbiased ($\mathbb{E}[X_1] = \mu$) but inconsistent (its variance $\sigma^2$ never shrinks). Conversely, $\hat{\sigma}^2_{\text{ML}}$ is biased but consistent. [@chan2021probabilitydatascience, pp. 496--498]

- **"Regression and MLE are the same thing"** -- They give the same formula $\hat{\boldsymbol{\theta}} = (\boldsymbol{X}^\top\boldsymbol{X})^{-1}\boldsymbol{X}^\top\boldsymbol{y}$ under Gaussian noise, but regression makes no distributional assumption and always returns a result. MLE provides statistical guarantees (consistency, unbiasedness) only if the assumed model is correct. If the noise is non-Gaussian (e.g., Laplace), the regression solution still exists but does not maximize the likelihood. [@chan2021probabilitydatascience, pp. 489--490]

## Teaching insights & analogies

- **Likelihood surface and cross sections** -- Chan visualizes the Bernoulli log-likelihood $\log \mathcal{L}(\theta \mid S) = S \log \theta + (N - S) \log(1 - \theta)$ as a 3D surface over $(\theta, S)$, then takes vertical cross sections at fixed $S$ to show how the MLE shifts as the data change. This makes concrete that the MLE is data-dependent: different observations give different estimates. [@chan2021probabilitydatascience, pp. 471--474, Figs. 8.3--8.5]

- **"Sliding the Gaussian" visualization** -- For Gaussian data with unknown mean, MLE is visualized as sliding a Gaussian PDF left and right to find the center that best explains the data. With $N = 1$, the MLE centers at the single observation; with $N = 2$, at their midpoint; with $N = 100$, at the sample mean. The red curve (estimated PDF) always tries to "cover" as many data points as possible. [@chan2021probabilitydatascience, pp. 475--477, Figs. 8.6--8.8]

- **Two-step MLE recipe** -- (1) Write down $\mathcal{L}(\boldsymbol{\theta} \mid \boldsymbol{x})$. (2) Maximize: $\hat{\boldsymbol{\theta}}_{\text{ML}} = \operatorname*{argmax}_{\boldsymbol{\theta}} \log \mathcal{L}(\boldsymbol{\theta} \mid \boldsymbol{x})$, typically by taking the derivative and setting it to zero. This systematic two-step procedure applies to every MLE problem. [@chan2021probabilitydatascience, p. 484]

## How the field talks about it

"MLE" or "ML estimate" is the standard abbreviation. When a paper says "the MLE of $\theta$ is $\hat{\theta}$," it means the value maximizing the likelihood. "Log-likelihood" almost always means the natural logarithm. The distinction between estimator (random variable, capital $\hat{\Theta}$) and estimate (number, lowercase $\hat{\theta}$) is standard in probability but often blurred in applied statistics. "Sufficient statistic" refers to a data summary through which the likelihood factors, so that no information about $\theta$ is lost; for Bernoulli data, $S = \sum x_n$ is sufficient. [@chan2021probabilitydatascience, pp. 468--472, 491]
