---
title: "Ridge regression and the lasso"
topic: regression-and-models
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

Shrinkage methods that fit a linear model with all $p$ predictors but constrain or regularize the coefficient estimates, shrinking them toward zero to reduce variance at the cost of a small increase in bias, often yielding better prediction accuracy than ordinary least squares. [@james2021introductionstatisticallearning, pp. 237--238]

**Also known as:** regularization, penalized regression, shrinkage methods, $\ell_2$ regularization (ridge), $\ell_1$ regularization (lasso)

## Definition(s)

**Ridge regression** estimates coefficients $\hat\beta^R_\lambda$ by minimizing $\text{RSS} + \lambda \sum_{j=1}^{p} \beta_j^2$, where $\lambda \geq 0$ is a tuning parameter. When $\lambda = 0$, ridge produces the least squares estimates; as $\lambda \to \infty$, all coefficient estimates approach zero. The penalty $\lambda \sum \beta_j^2$ is called the shrinkage penalty. The intercept $\beta_0$ is not penalized. [@james2021introductionstatisticallearning, pp. 237--238, Eq. 6.5]

**The lasso** estimates coefficients $\hat\beta^L_\lambda$ by minimizing $\text{RSS} + \lambda \sum_{j=1}^{p} |\beta_j|$. The only difference from ridge is that $\beta_j^2$ is replaced by $|\beta_j|$. This $\ell_1$ penalty has the effect of forcing some coefficients to be exactly zero when $\lambda$ is sufficiently large, thereby performing variable selection. The lasso yields sparse models -- models that involve only a subset of the variables. [@james2021introductionstatisticallearning, pp. 241--242, Eq. 6.7]

**Constraint-form equivalence:** Ridge regression is equivalent to minimizing RSS subject to $\sum \beta_j^2 \leq s$; the lasso is equivalent to minimizing RSS subject to $\sum |\beta_j| \leq s$. For every $\lambda$ there is a corresponding $s$ that gives the same coefficient estimates. [@james2021introductionstatisticallearning, pp. 243--244, Eqs. 6.8--6.9]

**Principal components regression (PCR)** constructs $M < p$ principal components $Z_1, \ldots, Z_M$ (linear combinations of the original predictors that capture the most variance) and uses them as predictors in a least squares regression. It is a dimension reduction method, not a feature selection method, because each component is a linear combination of all $p$ original features. PCR is closely related to ridge regression -- ridge can be thought of as a continuous version of PCR. [@james2021introductionstatisticallearning, pp. 253, 256--259]

**Partial least squares (PLS)** is a supervised alternative to PCR that identifies new features $Z_1, \ldots, Z_M$ using both the predictors and the response (unlike PCR, which ignores the response). In practice, PLS often performs no better than ridge regression or PCR because the supervised dimension reduction can increase variance. [@james2021introductionstatisticallearning, pp. 260--261]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $\lambda$ | "lambda" | The tuning parameter controlling the strength of the shrinkage penalty; larger $\lambda$ means more shrinkage [@james2021introductionstatisticallearning, p. 237] |
| $\hat\beta^R_\lambda$ | "beta-hat R lambda" | The ridge regression coefficient estimates for a given $\lambda$ [@james2021introductionstatisticallearning, p. 237] |
| $\hat\beta^L_\lambda$ | "beta-hat L lambda" | The lasso coefficient estimates for a given $\lambda$ [@james2021introductionstatisticallearning, p. 242] |
| $\|\beta\|_2$ | "ell-two norm of beta" | $\sqrt{\sum_{j=1}^{p} \beta_j^2}$; the Euclidean norm of the coefficient vector [@james2021introductionstatisticallearning, p. 239] |
| $\|\beta\|_1$ | "ell-one norm of beta" | $\sum_{j=1}^{p} |\beta_j|$; used in the lasso penalty [@james2021introductionstatisticallearning, p. 242] |
| $s$ | "s" | The budget in the constraint form: $\sum |\beta_j| \leq s$ (lasso) or $\sum \beta_j^2 \leq s$ (ridge) [@james2021introductionstatisticallearning, pp. 243--244] |
| $\boldsymbol{W}_\lambda$ | "W-lambda" | $(\boldsymbol{X}^\top\!\boldsymbol{X} + \lambda\boldsymbol{I})^{-1}\boldsymbol{X}^\top\!\boldsymbol{X}$; the shrinkage matrix relating the ridge estimate's expectation to the true parameter: $\mathbb{E}[\hat{\boldsymbol{\theta}}_\lambda] = \boldsymbol{W}_\lambda\boldsymbol{\theta}$ [@chan2021probabilitydatascience, p. 447] |
| $F(\hat{\boldsymbol{\theta}}_\lambda)$ vs $R(\hat{\boldsymbol{\theta}}_\lambda)$ | "data fidelity vs regularization" | $F = \lVert\boldsymbol{X}\hat{\boldsymbol{\theta}}_\lambda - \boldsymbol{y}\rVert^2$ and $R = \lVert\hat{\boldsymbol{\theta}}_\lambda\rVert^2$; plotting $F$ vs $R$ as $\lambda$ varies gives the L-curve used to find the elbow point for choosing $\lambda$ [@chan2021probabilitydatascience, pp. 445--446] |

## Key results & derivations

- **Ridge regression improves over least squares via the bias-variance trade-off** -- As $\lambda$ increases, the flexibility of the fit decreases, leading to decreased variance but increased bias. The test MSE (variance + squared bias) often has a minimum at an intermediate $\lambda$, well below the least squares MSE ($\lambda = 0$). In a simulation with $p = 45$ predictors and $n = 50$ observations, the minimum MSE at $\lambda \approx 30$ is substantially below the MSE of least squares. [@james2021introductionstatisticallearning, pp. 240--241]

- **Ridge regression requires standardized predictors** -- Unlike least squares, ridge regression is not scale equivariant: multiplying a predictor by a constant $c$ changes the ridge coefficient estimate in a way that depends on $\lambda$ and the scaling of other predictors. Therefore, predictors should be standardized (each divided by its standard deviation) before fitting ridge regression. [@james2021introductionstatisticallearning, pp. 239--240, Eq. 6.6]

- **The lasso produces sparse models; ridge does not** -- The $\ell_1$ penalty forces some coefficients to be exactly zero. In the simple orthogonal case ($n = p$, $\mathbf{X}$ diagonal), ridge shrinks each coefficient proportionally: $\hat\beta^R_j = y_j / (1 + \lambda)$, while the lasso applies soft-thresholding: $\hat\beta^L_j = \text{sign}(y_j)(|y_j| - \lambda/2)_+$, setting coefficients to exactly zero when $|y_j| \leq \lambda/2$. [@james2021introductionstatisticallearning, pp. 247--248, Eqs. 6.14--6.15]

- **Geometric explanation of lasso sparsity** -- In the constraint formulation, ridge has a circular constraint region ($\beta_1^2 + \beta_2^2 \leq s$) while the lasso has a diamond constraint region ($|\beta_1| + |\beta_2| \leq s$). The RSS contours (ellipses) are likely to first touch the diamond at a corner (an axis), setting one coefficient to zero. The circle has no corners, so the intersection will not generally occur on an axis. [@james2021introductionstatisticallearning, pp. 244--245]

- **Neither ridge nor lasso universally dominates** -- The lasso tends to perform better when a relatively small number of predictors have substantial coefficients and the rest are near zero (sparse true model). Ridge tends to perform better when the response is a function of many predictors, all with coefficients of roughly equal size. In practice, the number of relevant predictors is unknown, so cross-validation should be used to determine which approach works better on a given data set. [@james2021introductionstatisticallearning, pp. 246--247]

- **Bayesian interpretation** -- Ridge regression corresponds to the posterior mode of $\beta$ under a Gaussian prior with mean zero and standard deviation a function of $\lambda$. The lasso corresponds to the posterior mode under a double-exponential (Laplace) prior. The lasso prior is steeply peaked at zero, encoding the prior belief that many coefficients are exactly zero; the Gaussian prior is flatter and fatter, encoding the belief that coefficients are distributed around zero. [@james2021introductionstatisticallearning, pp. 249--250]

- **Tuning parameter selection via cross-validation** -- Choose a grid of $\lambda$ values, compute the cross-validation error for each, and select the $\lambda$ with the smallest error. Refit the model on the full data using the selected $\lambda$. On the Credit data, LOOCV for ridge regression selects a relatively small $\lambda$, indicating only modest shrinkage is needed. [@james2021introductionstatisticallearning, pp. 250--251]

- **PCR is not a feature selection method** -- Even though PCR uses fewer predictors ($M < p$), each principal component is a linear combination of all $p$ original features. It does not identify a small set of the original predictors. In this sense, PCR is more closely related to ridge regression than to the lasso. [@james2021introductionstatisticallearning, pp. 258--259]

- **Ridge regression closed-form solution** -- Taking the gradient of $\lVert\boldsymbol{X}\boldsymbol{\theta} - \boldsymbol{y}\rVert^2 + \lambda\lVert\boldsymbol{\theta}\rVert^2$ and setting it to zero gives $2\boldsymbol{X}^\top(\boldsymbol{X}\boldsymbol{\theta} - \boldsymbol{y}) + 2\lambda\boldsymbol{\theta} = 0$, yielding $\hat{\boldsymbol{\theta}}_{\text{ridge}}(\lambda) = (\boldsymbol{X}^\top\!\boldsymbol{X} + \lambda\boldsymbol{I})^{-1}\boldsymbol{X}^\top\!\boldsymbol{y}$. When $\lambda \to 0$ this recovers the vanilla OLS solution; when $\lambda \to \infty$ the solution approaches $\boldsymbol{0}$. [@chan2021probabilitydatascience, pp. 440--441, Eq. 7.36]

- **Eigenvalue stabilization** -- The eigendecomposition of $\boldsymbol{X}^\top\!\boldsymbol{X} = \boldsymbol{U}\boldsymbol{S}\boldsymbol{U}^\top$ gives $\boldsymbol{X}^\top\!\boldsymbol{X} + \lambda\boldsymbol{I} = \boldsymbol{U}(\boldsymbol{S} + \lambda\boldsymbol{I})\boldsymbol{U}^\top$. Even if $\boldsymbol{X}^\top\!\boldsymbol{X}$ has a zero eigenvalue (rank-deficient), adding $\lambda > 0$ offsets all eigenvalues by $\lambda$, guaranteeing invertibility. Since $\boldsymbol{X}^\top\!\boldsymbol{X}$ is positive semidefinite (its quadratic form $\boldsymbol{v}^\top\!\boldsymbol{X}^\top\!\boldsymbol{X}\boldsymbol{v} = \lVert\boldsymbol{X}\boldsymbol{v}\rVert^2 \geq 0$), all eigenvalues are non-negative. [@chan2021probabilitydatascience, pp. 441--442]

- **Ridge MSE decomposition** -- For $\boldsymbol{y} = \boldsymbol{X}\boldsymbol{\theta} + \boldsymbol{e}$ with zero-mean noise of covariance $\sigma^2\boldsymbol{I}$, the ridge estimator has $\text{MSE}(\hat{\boldsymbol{\theta}}_\lambda, \boldsymbol{\theta}) = \sigma^2\text{Tr}\!\bigl\{\boldsymbol{W}_\lambda(\boldsymbol{X}^\top\!\boldsymbol{X})^{-1}\boldsymbol{W}_\lambda^\top\bigr\} + \boldsymbol{\theta}^\top(\boldsymbol{W}_\lambda - \boldsymbol{I})^\top(\boldsymbol{W}_\lambda - \boldsymbol{I})\boldsymbol{\theta}$, where $\boldsymbol{W}_\lambda = (\boldsymbol{X}^\top\!\boldsymbol{X} + \lambda\boldsymbol{I})^{-1}\boldsymbol{X}^\top\!\boldsymbol{X}$. The first term is the variance (decreases as $\lambda$ increases) and the second is the squared bias (increases as $\lambda$ increases). The MSE achieves a minimum at an intermediate $\lambda$. [@chan2021probabilitydatascience, pp. 447--448, Thm 7.7]

- **Ridge MSE is lower than vanilla MSE for small $\lambda$** -- For $\lambda < 2\sigma^2\lVert\boldsymbol{\theta}\rVert^{-2}$, the ridge regression MSE is strictly less than the vanilla OLS MSE: $\text{MSE}(\hat{\boldsymbol{\theta}}_{\text{ridge}}(\lambda), \boldsymbol{\theta}) < \text{MSE}(\hat{\boldsymbol{\theta}}_{\text{vanilla}}, \boldsymbol{\theta})$. This result (due to C. M. Theobald, 1974) means that ridge regression is almost always helpful -- the optimal $\lambda$ is not provided by the theorem, only an upper bound below which ridge wins. [@chan2021probabilitydatascience, p. 448, Thm 7.8]

- **Ridge implementation via augmented system** -- Ridge regression can be implemented without forming $(\boldsymbol{X}^\top\!\boldsymbol{X} + \lambda\boldsymbol{I})^{-1}$ explicitly: concatenate $\boldsymbol{X}$ with $\sqrt{\lambda}\boldsymbol{I}_{d \times d}$ and $\boldsymbol{y}$ with a zero vector, then solve the ordinary least squares problem on the augmented system. [@chan2021probabilitydatascience, p. 442]

- **LASSO promotes sparsity via $\ell_1$ penalty** -- A vector $\boldsymbol{\theta}$ is called *sparse* if it has only a few non-zero elements. The $\ell_1$ constraint region $\{\boldsymbol{\theta} : \lVert\boldsymbol{\theta}\rVert_1 \leq \tau\}$ forms a diamond (in 2-D) whose vertices lie on the axes; the ellipsoidal contours of $\lVert\boldsymbol{X}\boldsymbol{\theta} - \boldsymbol{y}\rVert^2$ are likely to touch the diamond at a vertex, setting one or more coordinates to exactly zero. [@chan2021probabilitydatascience, pp. 449--450, Def. 7.1]

- **LASSO coefficient path vs ridge** -- As $\lambda$ varies, the LASSO trajectory $\hat{\boldsymbol{\theta}}_1(\lambda)$ has abrupt changes (features enter and exit the model at specific $\lambda$ values), whereas the ridge trajectory $\hat{\boldsymbol{\theta}}_2(\lambda)$ is smooth. This is because $\lVert\boldsymbol{\theta}\rVert_1$ is not differentiable at 0, while $\lVert\boldsymbol{\theta}\rVert^2$ is everywhere differentiable. [@chan2021probabilitydatascience, p. 453]

- **MAP derivation of ridge** -- In a linear model with Gaussian noise $\boldsymbol{e} \sim \text{Gaussian}(\boldsymbol{0}, \sigma^2\boldsymbol{I})$, if the prior on $\boldsymbol{\theta}$ is $f_\Theta(\boldsymbol{\theta}) = \exp\{-\lVert\boldsymbol{\theta}\rVert^2/(2\sigma_0^2)\}$, the MAP objective is $\operatorname*{argmin}_{\boldsymbol{\theta}} (1/2\sigma^2)\lVert\boldsymbol{y} - \boldsymbol{X}\boldsymbol{\theta}\rVert^2 + \lVert\boldsymbol{\theta}\rVert^2/(2\sigma_0^2)$, which is ridge regression with $\lambda = \sigma^2/\sigma_0^2$. This derivation is the formal justification for the Bayesian interpretation: the ridge penalty is exactly the negative log of a zero-mean Gaussian prior. [@chan2021probabilitydatascience, pp. 518--519, Eq. 8.53]

- **MAP derivation of LASSO** -- Replacing the Gaussian prior with a Laplace prior $f_\Theta(\boldsymbol{\theta}) = \exp\{-\lVert\boldsymbol{\theta}\rVert_1/\alpha\}$ gives $\operatorname*{argmin}_{\boldsymbol{\theta}} (1/2)\lVert\boldsymbol{y} - \boldsymbol{X}\boldsymbol{\theta}\rVert^2 + (\sigma^2/\alpha)\lVert\boldsymbol{\theta}\rVert_1$, i.e., LASSO with $\lambda = \sigma^2/\alpha$. The Laplace prior's sharp peak at zero explains the LASSO's sparsity-inducing property: it assigns much higher prior probability to parameters near zero. [@chan2021probabilitydatascience, pp. 519--520, Eq. 8.54]

## Prerequisites

What you must already understand for this concept to make sense:

- [bias-variance-trade-off](bias-variance-trade-off.md) -- ridge and lasso improve over least squares precisely by trading increased bias for decreased variance.
- [model-selection-and-information-criteria](model-selection-and-information-criteria.md) -- subset selection methods are the alternative to shrinkage; the lasso can be seen as a computationally feasible approximation to best subset selection.
- [resampling-bootstrap-and-permutation](resampling-bootstrap-and-permutation.md) -- cross-validation is used to select the tuning parameter $\lambda$.
- [norm-and-distance](norm-and-distance.md) -- the $\ell_1$ and $\ell_2$ norms define the ridge and lasso penalties.

## Misconceptions & learner traps

- **"Ridge regression always improves over least squares"** -- When $n \gg p$ and the relationship is close to linear, least squares estimates have low variance and ridge regression provides little benefit. Ridge is most useful when $p$ is close to $n$ or when the least squares estimates have high variance. [@james2021introductionstatisticallearning, pp. 240--241]

- **"The lasso always outperforms ridge because it does variable selection"** -- The lasso's advantage (sparsity) is also its assumption: it implicitly assumes many coefficients are zero. When all predictors are truly related to the response with similar-sized coefficients, ridge regression outperforms the lasso because the lasso's sparsity assumption is wrong. [@james2021introductionstatisticallearning, pp. 246--247]

- **"You don't need to standardize for ridge regression"** -- Ridge regression is not scale equivariant: changing the units of a predictor (e.g., income in dollars vs. thousands of dollars) will change the ridge coefficient estimate, the penalty contribution, and potentially the estimates of other coefficients. Standardizing predictors before fitting is essential. [@james2021introductionstatisticallearning, pp. 239--240]

- **"Ridge and lasso shrink coefficients in the same way"** -- Ridge shrinks all coefficients proportionally toward zero (none reach exactly zero). The lasso applies soft-thresholding: it shifts each coefficient toward zero by a fixed amount ($\lambda/2$ in the orthogonal case), and sets it to exactly zero if it is small enough. These are fundamentally different shrinkage behaviors. [@james2021introductionstatisticallearning, pp. 247--248]

## Teaching insights & analogies

- **The diamond-versus-circle picture (Figure 6.7)** -- ISL's most famous figure for this chapter: in two dimensions, the lasso constraint region is a diamond with corners on the axes and the ridge constraint region is a circle. The elliptical RSS contours are likely to touch the diamond at a corner (setting one coefficient to zero) but touch the circle at a smooth point (both coefficients nonzero). This single picture explains why the lasso does feature selection and ridge does not. [@james2021introductionstatisticallearning, pp. 244--245]

- **The simple special case ($n = p$, orthogonal X)** -- ISL derives closed-form solutions for ridge ($\hat\beta^R_j = y_j/(1+\lambda)$, proportional shrinkage) and lasso ($\hat\beta^L_j$, soft-thresholding) in this idealized setting. The resulting Figure 6.10 shows two fundamentally different shrinkage behaviors: one line through the origin for ridge, a shifted and truncated line for lasso. This makes the general behavior concrete. [@james2021introductionstatisticallearning, pp. 247--248]

- **The Credit data coefficient path plots (Figures 6.4 and 6.6)** -- ISL plots the ridge and lasso coefficient estimates as functions of $\lambda$ (left panels) and the shrinkage ratio $\|\hat\beta\|/\|\hat\beta_{\text{LS}}\|$ (right panels). For ridge, all curves approach zero smoothly; for the lasso, predictors enter and leave the model at specific $\lambda$ values. Comparing the two sets of plots side by side makes the structural difference between ridge and lasso immediately visible. [@james2021introductionstatisticallearning, pp. 238--243]

- **Gaussian vs. Laplace prior plots (Figure 6.11)** -- ISL displays the Gaussian (ridge) and double-exponential/Laplace (lasso) prior densities side by side. The Laplace prior is steeply peaked at zero, encoding the belief that many coefficients are exactly zero; the Gaussian is flatter and fatter, putting more prior probability on nonzero values. This Bayesian framing gives an additional lens on why the lasso produces sparse solutions. [@james2021introductionstatisticallearning, pp. 249--250]

- **Data fidelity + regularization framework** -- Chan frames ridge and LASSO as adding a regularization function $R(\boldsymbol{\theta})$ to the data fidelity term $F(\boldsymbol{\theta}) = \lVert\boldsymbol{X}\boldsymbol{\theta} - \boldsymbol{y}\rVert^2$: the modified training loss is $\mathcal{E}_{\text{train}}(\boldsymbol{\theta}) = F(\boldsymbol{\theta}) + \lambda \cdot R(\boldsymbol{\theta})$. Ridge uses $R(\boldsymbol{\theta}) = \lVert\boldsymbol{\theta}\rVert^2$; LASSO uses $R(\boldsymbol{\theta}) = \lVert\boldsymbol{\theta}\rVert_1$. The parameter $\lambda$ balances data fit against coefficient size. [@chan2021probabilitydatascience, pp. 440--441, Eqs. 7.32--7.34]

- **Noise injection equivalence** -- If the training data inputs are corrupted by i.i.d. Gaussian noise $\boldsymbol{e}_n \sim \text{Gaussian}(\boldsymbol{0}, \sigma^2\boldsymbol{I}_d)$, so that the training set becomes $\{(\boldsymbol{x}_n + \boldsymbol{e}_n, y_n)\}$, then the expected vanilla least squares problem on the corrupted data is equivalent to a ridge regression on the original data. This provides a data-augmentation interpretation of ridge. [@chan2021probabilitydatascience, p. 464, Exercise 10]

## How the field talks about it

When a paper says "we applied ridge regression with $\lambda$ chosen by 10-fold CV," it means the tuning parameter was selected by cross-validation. "L1 regularization" or "L1 penalty" means the lasso; "L2 regularization" means ridge. "The lasso selected 5 predictors" means the lasso set the other coefficients to exactly zero. "Regularization path" or "coefficient path" refers to the plot of coefficient estimates as $\lambda$ varies. "Elastic net" is a popular extension that combines the $\ell_1$ and $\ell_2$ penalties. "Penalized regression" is a general term covering ridge, lasso, and elastic net. [@james2021introductionstatisticallearning, pp. 237--251]
