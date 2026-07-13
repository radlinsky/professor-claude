---
title: "LDA, QDA, and naive Bayes"
topic: statistical-learning
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

Generative classification methods that model the distribution of predictors within each class and then use Bayes' theorem to compute posterior class probabilities; they differ in how they estimate the class-conditional densities $f_k(x)$. [@james2021introductionstatisticallearning, pp. 141--142]

**Also known as:** generative classifiers, Bayes classifiers (loosely), discriminant analysis (LDA/QDA)

## Definition(s)

**Bayes' theorem for classification** provides the foundation for all three methods. Given $K$ classes, the posterior probability that an observation with predictor vector $x$ belongs to class $k$ is $p_k(x) = \Pr(Y = k \mid X = x) = \pi_k f_k(x) / \sum_{l=1}^{K} \pi_l f_l(x)$, where $\pi_k = \Pr(Y = k)$ is the prior probability and $f_k(x) = \Pr(X = x \mid Y = k)$ is the class-conditional density. The classifier assigns to the class with the highest $p_k(x)$. [@james2021introductionstatisticallearning, pp. 141--142, Eq. 4.15]

**Linear discriminant analysis (LDA)** assumes the class-conditional density $f_k(x)$ is multivariate Gaussian with a class-specific mean vector $\boldsymbol{\mu}_k$ but a common covariance matrix $\boldsymbol{\Sigma}$ shared across all $K$ classes. The discriminant function is $\delta_k(x) = x^\top \boldsymbol{\Sigma}^{-1} \boldsymbol{\mu}_k - \frac{1}{2} \boldsymbol{\mu}_k^\top \boldsymbol{\Sigma}^{-1} \boldsymbol{\mu}_k + \log \pi_k$, which is linear in $x$. The decision boundary between any two classes is the set of points where $\delta_k(x) = \delta_l(x)$, which is a linear equation in $x$. Parameters are estimated from training data: $\hat{\mu}_k = (1/n_k) \sum_{i: y_i = k} x_i$, $\hat{\boldsymbol{\Sigma}}$ is the pooled sample covariance matrix, and $\hat{\pi}_k = n_k / n$. [@james2021introductionstatisticallearning, pp. 142--148, Eqs. 4.18--4.24]

**Quadratic discriminant analysis (QDA)** is identical to LDA except that each class has its own covariance matrix $\boldsymbol{\Sigma}_k$. The discriminant function becomes $\delta_k(x) = -\frac{1}{2} x^\top \boldsymbol{\Sigma}_k^{-1} x + x^\top \boldsymbol{\Sigma}_k^{-1} \boldsymbol{\mu}_k - \frac{1}{2} \boldsymbol{\mu}_k^\top \boldsymbol{\Sigma}_k^{-1} \boldsymbol{\mu}_k - \frac{1}{2} \log |\boldsymbol{\Sigma}_k| + \log \pi_k$, which is quadratic in $x$ (hence the name). QDA produces curved decision boundaries. It estimates $Kp(p+1)/2$ covariance parameters versus LDA's $p(p+1)/2$. [@james2021introductionstatisticallearning, pp. 152--154, Eq. 4.28]

**Naive Bayes** assumes that the $p$ predictors are independent within each class, so the class-conditional density factors as $f_k(x) = \prod_{j=1}^{p} f_{kj}(x_j)$. This dramatically reduces the number of parameters: instead of estimating a $p \times p$ covariance matrix, each $f_{kj}$ is a one-dimensional density. For quantitative predictors, $f_{kj}$ can be modeled as Gaussian (univariate, class-specific mean and variance) or estimated nonparametrically using a kernel density estimator. For qualitative predictors, $f_{kj}$ is simply the histogram of the predictor's values within class $k$. [@james2021introductionstatisticallearning, pp. 154--158, Eqs. 4.29--4.30]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $\pi_k$ | "pi-k" | Prior probability that an observation belongs to class $k$; estimated as $\hat{\pi}_k = n_k/n$ [@james2021introductionstatisticallearning, p. 142] |
| $f_k(x)$ | "f-k of x" | Class-conditional density of the predictors for class $k$; the form of this density distinguishes LDA, QDA, and naive Bayes [@james2021introductionstatisticallearning, p. 142] |
| $p_k(x)$ | "p-k of x" | Posterior probability $\Pr(Y = k \mid X = x)$, computed via Bayes' theorem [@james2021introductionstatisticallearning, p. 142] |
| $\delta_k(x)$ | "delta-k of x" | The discriminant function for class $k$; an observation is classified to the class with the largest $\delta_k(x)$ [@james2021introductionstatisticallearning, p. 143] |
| $\boldsymbol{\mu}_k$ | "mu-k" | Mean vector of the predictors for class $k$ [@james2021introductionstatisticallearning, p. 142] |
| $\boldsymbol{\Sigma}$ | "sigma" (matrix) | Common covariance matrix in LDA; in QDA, each class has its own $\boldsymbol{\Sigma}_k$ [@james2021introductionstatisticallearning, pp. 146, 152] |

## Key results & derivations

- **LDA decision boundaries are linear** -- Because LDA uses a common covariance matrix, the quadratic terms in the Gaussian exponent cancel when comparing any two classes, leaving a linear function of $x$. This is why the method is called "linear" discriminant analysis. [@james2021introductionstatisticallearning, pp. 146--147]

- **QDA decision boundaries are quadratic** -- With class-specific covariance matrices $\boldsymbol{\Sigma}_k$, the quadratic terms no longer cancel, producing decision boundaries that are quadratic (curved) in $x$. [@james2021introductionstatisticallearning, pp. 152--153]

- **LDA is a special case of QDA (and of naive Bayes)** -- LDA is the special case of QDA where $\boldsymbol{\Sigma}_1 = \cdots = \boldsymbol{\Sigma}_K$. LDA is also a special case of naive Bayes with a Gaussian model for each $f_{kj}$, further constrained so that all predictors within a class share the same variance and are uncorrelated (which is what the independence assumption plus equal covariance gives). [@james2021introductionstatisticallearning, pp. 164--165]

- **Log-odds forms reveal the analytical relationships** -- For a two-class problem, the log-odds $\log(p_1(x)/p_K(x))$ is linear in $x$ for LDA (Eq. 4.32), quadratic in $x$ for QDA (Eq. 4.33), and a sum of univariate functions $\sum_j a_{kj}(x_j)$ (a generalized additive form) for naive Bayes (Eq. 4.34). Logistic regression also produces log-odds that are linear in $x$, so LDA and logistic regression produce the same functional form but estimate parameters differently (generative vs. discriminative). [@james2021introductionstatisticallearning, pp. 163--165, Eqs. 4.32--4.34]

- **The bias-variance trade-off governs the choice among methods** -- LDA estimates $Kp$ linear coefficients from the common covariance, QDA estimates $Kp(p+1)/2$ parameters from per-class covariances, and naive Bayes estimates $Kp$ parameters by assuming independence. With $n$ training observations: LDA can have high bias (if the common-covariance assumption is wrong) but low variance; QDA can have low bias but high variance when $n$ is small relative to $p$; naive Bayes has different bias (independence assumption may be wrong) but very low variance. [@james2021introductionstatisticallearning, pp. 153--154, 156--158]

- **No single method dominates empirically** -- In six simulated scenarios, the best classifier varies: (1) when Bayes boundaries are linear, LDA and logistic regression are best; (2) with moderate nonlinearity, QDA and naive Bayes do well; (3) with highly nonlinear boundaries, KNN works best (but only when $n$ is large enough relative to $p$). The takeaway is that the best method depends on the true decision boundary shape, the sample size, and the number of predictors. [@james2021introductionstatisticallearning, pp. 166--170]

## Prerequisites

What you must already understand for this concept to make sense:

- [classification-evaluation](classification-evaluation.md) -- confusion matrices, sensitivity/specificity, and ROC curves are needed to compare classifiers.
- [bias-variance-trade-off](bias-variance-trade-off.md) -- the choice among LDA, QDA, and naive Bayes is a bias-variance trade-off in the number of parameters estimated.

## Misconceptions & learner traps

- **"LDA and logistic regression are the same thing"** -- They produce the same functional form (linear log-odds), but LDA is a generative method (models $\Pr(X \mid Y)$ and uses Bayes' theorem) while logistic regression is discriminative (models $\Pr(Y \mid X)$ directly). LDA uses the Gaussian assumption to estimate parameters, while logistic regression uses maximum likelihood without distributional assumptions on $X$. When the Gaussian assumption is approximately correct, LDA can outperform logistic regression, especially with small $n$. [@james2021introductionstatisticallearning, pp. 163--165]

- **"The naive Bayes independence assumption means it only works when predictors are independent"** -- Naive Bayes often performs surprisingly well even when the independence assumption is violated. The bias from the wrong independence assumption can be offset by the variance reduction from estimating far fewer parameters ($Kp$ instead of $Kp(p+1)/2$). [@james2021introductionstatisticallearning, pp. 156--158]

- **"QDA is always better than LDA because it is more flexible"** -- QDA estimates many more parameters and can overfit when the training set is small. If the classes truly share a common covariance structure, LDA will outperform QDA because the extra parameters in QDA add variance without reducing bias. [@james2021introductionstatisticallearning, pp. 153--154]

- **"You should always pick the classifier with the lowest overall error rate"** -- A classifier with a low overall error rate can still be useless for the rare class. In the Default data example, LDA with a 50% threshold correctly classifies 97.25% of all observations but catches only 24.3% of defaulters (75.7% false negative rate for the class of interest). Adjusting the classification threshold trades overall error for better sensitivity. [@james2021introductionstatisticallearning, pp. 148--150]

## Teaching insights & analogies

- **The three methods as a flexibility dial** -- LDA (shared covariance), naive Bayes (diagonal covariance per class), and QDA (full covariance per class) form a flexibility sequence. LDA is most constrained, QDA is least constrained, and naive Bayes sits in a different direction (uncorrelated but class-specific variances). The user's job is to match the method's flexibility to the data's complexity, just like choosing polynomial degree in regression. [@james2021introductionstatisticallearning, pp. 153--154, 156--158]

- **The plug-in approach to Bayes' theorem** -- All three methods follow the same recipe: (1) estimate the prior $\pi_k$, (2) estimate the class-conditional density $f_k(x)$, (3) plug into Bayes' theorem to get the posterior. They differ only in step 2. This makes it easy to teach them as variants of one idea rather than three separate methods. [@james2021introductionstatisticallearning, pp. 141--142]

- **The six-scenario comparison (Section 4.5.2)** -- ISL's comparison of KNN, LDA, logistic regression, QDA, and naive Bayes across six simulated settings is an effective teaching tool. It concretely demonstrates that no method dominates and that the best choice depends on the true boundary shape and the $n/p$ ratio. [@james2021introductionstatisticallearning, pp. 166--170]

## How the field talks about it

When a paper says "we used LDA" it means linear discriminant analysis with a shared covariance matrix. "Discriminant analysis" without qualification usually means LDA. "QDA" always means per-class covariance matrices. "Naive Bayes" always signals the conditional independence assumption. "Generative classifier" means the method models the class-conditional distribution $f_k(x)$ (LDA, QDA, naive Bayes), as opposed to "discriminative classifiers" (logistic regression, SVMs) that model $\Pr(Y \mid X)$ directly. [@james2021introductionstatisticallearning, pp. 141--142, 163--165]
