---
title: "Bagging, random forests, and boosting"
topic: statistical-learning
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

Ensemble methods that combine many decision trees to produce a single prediction with substantially better accuracy than a single tree, at the cost of interpretability. [@james2021introductionstatisticallearning, pp. 327, 340]

**Also known as:** tree ensembles, ensemble learning (general), bootstrap aggregation (bagging)

## Definition(s)

**Bagging** (bootstrap aggregation) reduces the variance of a statistical learning method by averaging predictions from models trained on $B$ bootstrap samples. For regression, the bagged prediction is $\hat{f}_{\text{bag}}(x) = \frac{1}{B} \sum_{b=1}^{B} \hat{f}^{*b}(x)$, where $\hat{f}^{*b}$ is the model trained on the $b$th bootstrap sample. For classification, the bagged prediction uses a majority vote among the $B$ predictions. When applied to decision trees, each tree is grown deep (not pruned), so individual trees have high variance but low bias; averaging reduces the variance. [@james2021introductionstatisticallearning, pp. 340--341]

**Out-of-bag (OOB) error** provides a free estimate of test error for bagged models. On average, each bootstrap sample uses about two-thirds of the observations; the remaining one-third are called out-of-bag observations. For each observation $i$, predict using only the trees for which observation $i$ was OOB (roughly $B/3$ trees), then compute the overall OOB MSE (regression) or classification error. With $B$ sufficiently large, OOB error is virtually equivalent to leave-one-out cross-validation error. [@james2021introductionstatisticallearning, pp. 342--343]

**Random forests** improve on bagging by decorrelating the trees. At each split, a random sample of $m$ predictors is chosen as candidates from the full set of $p$ predictors (a fresh sample at each split). Typically $m \approx \sqrt{p}$. When $m = p$, random forests reduce to bagging. The rationale: if one predictor is very strong, bagged trees will all use it for the top split, making the trees highly correlated. Averaging correlated quantities does not reduce variance as much as averaging uncorrelated ones. By restricting each split to a random subset, random forests decorrelate the trees, yielding a more reliable average. [@james2021introductionstatisticallearning, pp. 343--345]

**Boosting** builds trees sequentially: each new tree is fit to the residuals of the current model, then added in shrunken form. For regression trees, the boosting algorithm initializes $\hat{f}(x) = 0$ and residuals $r_i = y_i$, then for $b = 1, \ldots, B$: (a) fit a tree $\hat{f}^b$ with $d$ splits to the data $(X, r)$, (b) update $\hat{f}(x) \leftarrow \hat{f}(x) + \lambda \hat{f}^b(x)$, and (c) update residuals $r_i \leftarrow r_i - \lambda \hat{f}^b(x_i)$. The output is $\hat{f}(x) = \sum_{b=1}^{B} \lambda \hat{f}^b(x)$. Unlike bagging and random forests, boosting trees are typically small (few splits), and each tree depends on the previous trees. [@james2021introductionstatisticallearning, pp. 345--347, Algorithm 8.2, Eqs. 8.10--8.12]

**Bayesian additive regression trees (BART)** are an ensemble method that combines elements of bagging/random forests (random construction) and boosting (sequential fitting to residuals). BART maintains $K$ trees and iteratively perturbs each tree to better fit the current partial residuals, using a Bayesian prior that favors small trees. The final prediction averages the ensemble across $B$ iterations (after discarding $L$ burn-in iterations). BART has been shown to have very good out-of-box performance with minimal tuning. [@james2021introductionstatisticallearning, pp. 348--352, Algorithm 8.3]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $B$ | "B" | The number of trees in the ensemble (bagging, RF) or the number of boosting iterations [@james2021introductionstatisticallearning, pp. 341, 347] |
| $\hat{f}^{*b}(x)$ | "f-hat star b of x" | Prediction from the tree trained on the $b$th bootstrap sample [@james2021introductionstatisticallearning, p. 341] |
| $m$ | "m" | The number of predictors randomly selected as split candidates at each node in a random forest; typically $m \approx \sqrt{p}$ [@james2021introductionstatisticallearning, p. 343] |
| $\lambda$ | "lambda" (shrinkage) | The shrinkage parameter in boosting, controlling the learning rate; typical values are 0.01 or 0.001 [@james2021introductionstatisticallearning, p. 347] |
| $d$ | "d" (interaction depth) | The number of splits in each tree in boosting, controlling the interaction order of the model; $d = 1$ (stumps) gives an additive model [@james2021introductionstatisticallearning, p. 347] |
| $K$ | "K" (BART) | The number of regression trees maintained by BART [@james2021introductionstatisticallearning, p. 348] |

## Key results & derivations

- **Averaging reduces variance** -- For $n$ independent observations each with variance $\sigma^2$, the variance of the mean is $\sigma^2/n$. Bagging exploits this principle: averaging $B$ trees reduces the variance of the prediction. However, bootstrap samples are not independent (they are drawn from the same training set), so the reduction is not as large as $1/B$. This is why decorrelating the trees (random forests) helps further. [@james2021introductionstatisticallearning, pp. 340--341]

- **Random forests reduce both test error and OOB error compared to bagging** -- On the Heart data, using $m = \sqrt{p}$ (4 out of 13 predictors) reduces both test error and OOB error compared to bagging ($m = p$). The improvement is more pronounced when there are strong predictors that dominate the top splits in bagged trees. [@james2021introductionstatisticallearning, pp. 342, 345]

- **Smaller $m$ is more helpful with many correlated predictors** -- When the number of predictors is large and many are correlated, using a small $m$ in random forests is especially beneficial. On a gene expression dataset with $p = 500$ predictors, $m = \sqrt{p}$ gave a small improvement in test error over bagging ($m = p$). [@james2021introductionstatisticallearning, p. 345]

- **Boosting can overfit if $B$ is too large** -- Unlike bagging and random forests, where increasing $B$ does not lead to overfitting, boosting can overfit if the number of trees $B$ is too large. Cross-validation is used to select $B$. [@james2021introductionstatisticallearning, p. 347]

- **Boosting's three tuning parameters** -- (1) The number of trees $B$ (selected by CV); (2) the shrinkage parameter $\lambda$ (small values like 0.01 or 0.001 require large $B$); (3) the number of splits $d$ per tree, which controls the interaction depth. When $d = 1$, each tree is a stump and the boosted model is additive (no interactions). [@james2021introductionstatisticallearning, p. 347]

- **Variable importance measures** -- For bagged or random forest models, variable importance for each predictor is computed by totaling the amount that the RSS (regression) or Gini index (classification) decreases due to splits on that predictor, averaged over all $B$ trees. A large value indicates an important predictor. [@james2021introductionstatisticallearning, p. 343]

- **Boosting with stumps gives an additive model** -- When each boosted tree has $d = 1$ split, each term in the ensemble involves only a single variable. The resulting model is $\hat{f}(x) = \sum_b \lambda \hat{f}^b(x)$ where each $\hat{f}^b$ depends on only one predictor, making it an additive model. More generally, $d$ splits can involve at most $d$ variables, so $d$ controls the interaction order. [@james2021introductionstatisticallearning, p. 347]

- **Summary of ensemble approaches** -- In bagging, trees are grown independently on random samples; trees tend to be similar (correlated). In random forests, trees are grown independently on random samples with random predictor subsets at each split; the decorrelation leads to a more thorough exploration of model space. In boosting, trees are grown sequentially, each fitting the residuals of the current model with a slow learning rate. In BART, trees are grown sequentially, each perturbing the previous iteration's tree to better fit partial residuals. [@james2021introductionstatisticallearning, pp. 351--352]

## Prerequisites

What you must already understand for this concept to make sense:

- [decision-trees](decision-trees.md) -- ensemble methods use decision trees as building blocks; understanding recursive binary splitting, pruning, and split criteria is essential.
- [resampling-bootstrap-and-permutation](resampling-bootstrap-and-permutation.md) -- bagging is built on the bootstrap; OOB error is a resampling-based estimate of test error; cross-validation selects boosting's tuning parameters.
- [bias-variance-trade-off](bias-variance-trade-off.md) -- the motivation for bagging is variance reduction; boosting reduces bias by fitting residuals; the trade-offs between the methods are bias-variance arguments.

## Misconceptions & learner traps

- **"Increasing $B$ in bagging or random forests leads to overfitting"** -- Unlike boosting, increasing the number of trees $B$ in bagging or random forests does not cause overfitting. More trees simply give a more stable average. In practice, choose $B$ large enough that the error has settled down. [@james2021introductionstatisticallearning, pp. 341, 345]

- **"Random forests only work when there are many predictors"** -- Random forests can improve over bagging even with a moderate number of predictors. The key is whether any predictors are much stronger than others: if so, bagged trees become correlated and random forests' decorrelation helps. [@james2021introductionstatisticallearning, pp. 343--345]

- **"Boosting just fits the training data harder than bagging"** -- Boosting learns slowly by fitting small trees to residuals; the shrinkage parameter $\lambda$ controls how much each tree contributes. Methods that learn slowly tend to generalize better. Boosting does not necessarily fit the training data harder -- in fact, individual boosted trees are much smaller than bagged trees. [@james2021introductionstatisticallearning, pp. 346--347]

- **"You can interpret a random forest the same way as a single tree"** -- The interpretability of a single tree is lost when hundreds or thousands of trees are combined. Variable importance plots partially compensate, but the clear "follow the branches" interpretation is gone. This is the fundamental trade-off: ensembles improve accuracy at the cost of interpretability. [@james2021introductionstatisticallearning, p. 343]

## Teaching insights & analogies

- **Bagging as "wisdom of crowds"** -- Each bootstrap tree is like one expert's opinion: noisy on its own, but averaging many opinions (even imperfect ones) reduces errors. The key insight is that the noise cancels out, as long as the experts are not all making the same mistake. [@james2021introductionstatisticallearning, pp. 340--341]

- **Random forests fix bagging's "groupthink" problem** -- When all bagged trees use the same strong predictor at the top, they are like a panel of experts who all read the same news source. Random forests force each tree to consider only a random subset of predictors, analogous to giving each expert different information. This produces more diverse opinions, and diverse averages are more reliable. [@james2021introductionstatisticallearning, pp. 343--344]

- **Boosting as iterative refinement** -- Instead of building many full-size trees and averaging, boosting builds many tiny trees and adds them up. Each tiny tree fixes the mistakes of the current ensemble. The analogy: instead of asking many experts for a full answer, ask each expert to correct the errors in the current best answer. The shrinkage parameter is like saying "only partially trust each correction." [@james2021introductionstatisticallearning, pp. 345--347]

- **The Heart data comparison (Figure 8.8)** -- ISL plots test error as a function of the number of trees for both bagging and random forests, along with OOB error. This single figure shows that: (1) more trees help (error decreases), (2) error stabilizes (no overfitting), (3) random forests beat bagging, and (4) OOB error tracks test error well. [@james2021introductionstatisticallearning, p. 342]

## How the field talks about it

"Bagging" always means bootstrap aggregation with $m = p$ at each split. "Random forest" always means $m < p$ (usually $m = \sqrt{p}$ for classification, $m = p/3$ for regression). "Gradient boosting" is the general framework; "GBM" (gradient boosting machine) and "XGBoost" are popular implementations. "Ensemble" is the general term for combining multiple models. "Base learner" or "weak learner" refers to the individual trees in an ensemble. "OOB error" is universally understood as the out-of-bag estimate. "Variable importance" (or "feature importance") refers to the RSS/Gini-based ranking from bagging or random forests. "Learning rate" is synonymous with the shrinkage parameter $\lambda$ in boosting. "BART" (Bayesian additive regression trees) is a more recent ensemble method with good default performance. [@james2021introductionstatisticallearning, pp. 340--352]
