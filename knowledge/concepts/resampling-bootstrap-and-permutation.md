---
title: "Resampling, bootstrap, and permutation"
topic: statistical-inference
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

Methods that repeatedly draw samples from a training data set and refit a model on each sample in order to obtain information that would not be available from fitting the model only once -- primarily estimates of test error (cross-validation) and measures of statistical accuracy such as standard errors (bootstrap). [@james2021introductionstatisticallearning, pp. 197--198]

**Also known as:** resampling methods, resampling-based inference

## Definition(s)

**Cross-validation** is a family of resampling methods that estimate the test error rate by holding out a subset of training observations from the fitting process and then evaluating the fitted model on the held-out observations. The three main variants are the validation set approach, leave-one-out cross-validation (LOOCV), and $k$-fold cross-validation. [@james2021introductionstatisticallearning, pp. 198--203]

**Validation set approach:** randomly divide the available observations into two parts -- a training set and a validation set (also called a hold-out set). The model is fit on the training set, and the fitted model is used to predict the responses for the validation set. The resulting validation set error rate (typically MSE for regression) provides an estimate of the test error rate. [@james2021introductionstatisticallearning, pp. 198--200]

**Leave-one-out cross-validation (LOOCV):** a single observation $(x_1, y_1)$ is used for validation and the remaining $n - 1$ observations form the training set. This is repeated $n$ times, each time holding out a different observation, and the LOOCV estimate is the average of the $n$ test error estimates. [@james2021introductionstatisticallearning, pp. 200--202]

**$k$-fold cross-validation:** the observations are randomly divided into $k$ groups (folds) of approximately equal size. Each fold is used in turn as a validation set while the remaining $k - 1$ folds form the training set. The $k$-fold CV estimate is the average of the $k$ resulting test error estimates. LOOCV is the special case where $k = n$. In practice, $k = 5$ or $k = 10$ is typical. [@james2021introductionstatisticallearning, pp. 203--206]

**The bootstrap** is a method for quantifying the uncertainty associated with a given estimator or statistical learning method. It works by repeatedly sampling $n$ observations with replacement from the original data set to create $B$ bootstrap data sets $Z^{*1}, Z^{*2}, \ldots, Z^{*B}$, computing the statistic of interest on each, and then using the variability across the $B$ estimates to approximate the standard error. [@james2021introductionstatisticallearning, pp. 209--212]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $\text{CV}_{(n)}$ | "CV sub n" | The LOOCV estimate of test error: $(1/n) \sum_{i=1}^{n} \text{MSE}_i$ [@james2021introductionstatisticallearning, p. 201, Eq. 5.1] |
| $\text{CV}_{(k)}$ | "CV sub k" | The $k$-fold CV estimate of test error: $(1/k) \sum_{i=1}^{k} \text{MSE}_i$ [@james2021introductionstatisticallearning, p. 203, Eq. 5.3] |
| $h_i$ | "h sub i" | The leverage of the $i$th observation in the LOOCV shortcut formula for least squares [@james2021introductionstatisticallearning, p. 202, Eq. 5.2] |
| $Z^{*r}$ | "Z star r" | The $r$th bootstrap data set, obtained by sampling $n$ observations with replacement from the original data [@james2021introductionstatisticallearning, p. 211] |
| $\text{SE}_B(\hat\alpha)$ | "bootstrap standard error of alpha-hat" | Standard deviation of $B$ bootstrap estimates of $\alpha$: $\sqrt{\frac{1}{B-1}\sum_{r=1}^{B}\left(\hat\alpha^{*r} - \frac{1}{B}\sum_{r'=1}^{B}\hat\alpha^{*r'}\right)^2}$ [@james2021introductionstatisticallearning, p. 211, Eq. 5.8] |
| $\mathbb{V}_\text{boot}(\hat{\Theta})$ | "bootstrapped variance" | $(1/K)\sum_{k=1}^{K}(\hat{\Theta}_\text{boot}^{(k)} - \mathbb{M}_\text{boot}(\hat{\Theta}))^2$; the sample variance of $K$ bootstrap estimates [@chan2021probabilitydatascience, p. 565, Eq. 9.21] |
| $\widehat{\text{se}}_\text{boot}$ | "bootstrapped standard error" | $\sqrt{\mathbb{V}_\text{boot}(\hat{\Theta})}$; used to construct the bootstrap CI [@chan2021probabilitydatascience, p. 567, Eq. 9.22] |

## Key results & derivations

- **LOOCV shortcut for least squares** -- For linear or polynomial regression fit by least squares, LOOCV can be computed from a single model fit: $\text{CV}_{(n)} = \frac{1}{n}\sum_{i=1}^{n}\left(\frac{y_i - \hat{y}_i}{1 - h_i}\right)^2$, where $\hat{y}_i$ is the $i$th fitted value and $h_i$ is the leverage. This makes LOOCV no more expensive than a single model fit. The formula does not hold in general for non-linear models. [@james2021introductionstatisticallearning, p. 202, Eq. 5.2]

- **Bias-variance trade-off in choosing $k$** -- LOOCV gives approximately unbiased estimates of the test error (each training set has $n-1$ observations), but has high variance because the $n$ fitted models are trained on nearly identical data and their outputs are highly positively correlated. $k$-fold CV with $k < n$ has slightly more bias (each training set has $(k-1)n/k$ observations) but substantially lower variance because the $k$ training sets overlap less. Empirically, $k = 5$ or $k = 10$ strikes a good balance. [@james2021introductionstatisticallearning, pp. 205--206]

- **Validation set approach drawbacks** -- Two problems: (1) the estimated test error rate is highly variable because it depends on the random split; (2) only a subset of observations is used for training, so the method tends to overestimate the test error rate for a model fit on the full data set. [@james2021introductionstatisticallearning, p. 200]

- **CV for classification** -- In the classification setting, MSE is replaced by the misclassification rate: $\text{CV}_{(n)} = \frac{1}{n}\sum_{i=1}^{n}\text{Err}_i$, where $\text{Err}_i = I(y_i \neq \hat{y}_i)$. The $k$-fold CV and validation set error rates are defined analogously. [@james2021introductionstatisticallearning, p. 206, Eq. 5.4]

- **Bootstrap standard error approximates repeated-sampling SE** -- In a simulation where the true SE is known (0.083 from 1,000 simulated data sets), the bootstrap estimate from a single data set of 100 observations is 0.087, demonstrating that the bootstrap can effectively estimate the variability of a statistic without access to additional samples from the population. [@james2021introductionstatisticallearning, pp. 210--212]

- **Three approximations underlying bootstrapping** -- The bootstrap rests on three approximations: (a) the hypothetical (brute-force) approximation $\text{Var}_F(\hat{\Theta}) \approx \mathbb{V}_\text{full}(\hat{\Theta})$, where $\mathbb{V}_\text{full}$ is the sample variance from $K$ hypothetical datasets drawn from the true CDF $F$; (b) replacing the unknown $F$ with the empirical CDF $\hat{F}$ of the observed data $\mathcal{X}$; (c) approximating the theoretical bootstrapped variance $\text{Var}_{\hat{F}}(\hat{\Theta})$ by the finite-sample bootstrapped variance $\mathbb{V}_\text{boot}(\hat{\Theta})$. Approximation (b) is the main source of error and improves as $N$ grows; (c) can be made arbitrarily small by increasing $K$. [@chan2021probabilitydatascience, pp. 565--566]

- **Bootstrapped confidence interval** -- From the bootstrapped variance $\mathbb{V}_\text{boot}(\hat{\Theta})$, the bootstrapped standard error is $\widehat{\text{se}}_\text{boot} = \sqrt{\mathbb{V}_\text{boot}(\hat{\Theta})}$, and the bootstrapped CI is $\mathcal{I} = [\hat{\Theta} - z_\alpha\,\widehat{\text{se}}_\text{boot},\; \hat{\Theta} + z_\alpha\,\widehat{\text{se}}_\text{boot}]$. This CI is valid insofar as $\hat{\Theta}$ is approximately Gaussian (justified by CLT for sample averages); for non-Gaussian estimators, advanced methods beyond $z_\alpha$ are needed. [@chan2021probabilitydatascience, pp. 567--568, Eqs. 9.22--9.23]

- **Sampling with replacement preserves the empirical distribution** -- Sampling with replacement from $\mathcal{X} = \{X_1, \ldots, X_N\}$ is equivalent to drawing from the empirical CDF $\hat{F}$. Each $Y_n$ drawn from $\mathcal{X}$ has probability $1/N$ of being each $X_n$, so the PDF of $Y_n$ matches the empirical frequencies of the data. Sampling without replacement (permutation) preserves the mean and variance but destroys the distributional information because each $X_n$ appears exactly once. [@chan2021probabilitydatascience, p. 566]

## Prerequisites

What you must already understand for this concept to make sense:

- [bias-variance-trade-off](bias-variance-trade-off.md) -- the bias-variance trade-off motivates why we need test error estimation (training error misleads), and it reappears in the choice of $k$ for $k$-fold CV.
- [mean-variance-covariance](../../foundations/mean-variance-covariance/lesson.qmd) -- standard errors and the bootstrap SE formula require understanding of variance and standard deviation.

## Misconceptions & learner traps

- **"LOOCV is always the best form of cross-validation because it is the least biased"** -- While LOOCV has lower bias than $k$-fold CV (the training sets are larger), it has higher variance. The $n$ fitted models in LOOCV are highly correlated because their training sets overlap almost completely, and the mean of many highly correlated quantities has higher variance than the mean of less correlated ones. In practice, $k = 5$ or $k = 10$ often gives more accurate test error estimates because the reduction in variance more than compensates for the slight increase in bias. [@james2021introductionstatisticallearning, pp. 205--206]

- **"The validation set approach gives a stable estimate of test error"** -- Ten different random splits of the Auto data produce ten different validation set MSE curves, with substantial disagreement about which polynomial degree is best. The estimate is highly variable because it depends on which observations happen to fall in the training set versus the validation set. [@james2021introductionstatisticallearning, pp. 199--200]

- **"Cross-validation tells you the exact test error"** -- Cross-validation estimates the test error, not the exact value. Sometimes the goal is not the absolute value of the estimated test MSE but simply finding the minimum point -- the flexibility level that produces the lowest test error. Even when CV curves underestimate the true test MSE, they often correctly identify the flexibility level corresponding to the minimum test MSE. [@james2021introductionstatisticallearning, pp. 204--205]

- **"The bootstrap generates new data"** -- The bootstrap does not generate new observations from the population; it resamples from the original data set with replacement. Each bootstrap sample is the same size as the original data set but will typically contain some observations more than once and omit others entirely. [@james2021introductionstatisticallearning, pp. 211--212]

## Teaching insights & analogies

- **The Auto data polynomial progression** -- ISL uses polynomial regression of mpg on horsepower (degrees 1 through 10) as a running example throughout the cross-validation sections. The validation set approach shows that the quadratic fit is consistently better than linear, but the ten random splits disagree on whether higher-order polynomials help. LOOCV and 10-fold CV give much more stable answers: the minimum is around degree 2, with little benefit beyond that. This progression makes the advantages of $k$-fold CV over simple validation concrete. [@james2021introductionstatisticallearning, pp. 199--204]

- **Three schematic diagrams (Figures 5.1, 5.3, 5.5)** -- ISL presents simple block diagrams showing how observations are divided: one split (validation set), $n$ splits with one held out (LOOCV), and $k$ equal-sized folds ($k$-fold CV). These visuals make the structural differences between the three approaches immediately clear. [@james2021introductionstatisticallearning, pp. 199--203]

- **The investment allocation example for bootstrap** -- The bootstrap is introduced through a toy portfolio optimization: choosing the fraction $\alpha$ to invest in asset $X$ versus asset $Y$ to minimize total risk. Because the true $\alpha$ and $\text{SE}(\hat\alpha)$ are known from simulation, the bootstrap estimate can be directly compared against the ground truth, making the logic of the method transparent before applying it to harder problems. [@james2021introductionstatisticallearning, pp. 209--212]

- **CV on classification using polynomial logistic regression (Figure 5.7/5.8)** -- ISL fits logistic regression with polynomial predictors (degrees 1 through 4) on simulated classification data. On simulated data the true test error rates are known (0.201, 0.197, 0.160, 0.162), and the 10-fold CV error curve correctly identifies that cubic polynomials are needed -- it reaches its minimum at degree 4, very close to the true test curve minimum at degree 3. This example shows that CV works for model selection in classification as well as regression. [@james2021introductionstatisticallearning, pp. 206--208]

- **Estimation hierarchy tree** -- Chan organizes all estimation techniques in a tree: point estimation (MLE, MAP, MMSE) on the left, confidence interval on the right. Under confidence interval: sample mean with known variance (Gaussian CI), sample mean with unknown variance (Student's $t$-CI), and other estimators (bootstrap). This tree makes clear that bootstrapping is the CI method for estimators that are not the sample mean (e.g., the median), where the Gaussian and $t$-based CIs do not apply because the variance of the estimator has no simple closed-form expression. [@chan2021probabilitydatascience, pp. 561--562, Fig. 9.8]

## How the field talks about it

When a paper says results were obtained using "10-fold cross-validation," it means the data were randomly split into 10 folds, each fold was held out once for evaluation, and the 10 error estimates were averaged. "Leave-one-out" or "LOOCV" means $k = n$. When a paper reports "bootstrap standard errors" or "bootstrap confidence intervals," it means the bootstrap was used to estimate the sampling variability of the reported statistic. The terms "model assessment" (evaluating a model's performance) and "model selection" (choosing the right level of flexibility) are the two main uses of cross-validation. [@james2021introductionstatisticallearning, pp. 197--198, 206]
