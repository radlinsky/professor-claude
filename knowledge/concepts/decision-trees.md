---
title: "Decision trees"
topic: statistical-learning
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

A supervised learning method that segments the predictor space into a set of non-overlapping regions using a sequence of binary splits, then predicts the response for each region using the mean (regression) or the most common class (classification) of the training observations in that region. [@james2021introductionstatisticallearning, pp. 327--328]

**Also known as:** classification and regression trees (CART), recursive partitioning

## Definition(s)

**Regression trees** predict a quantitative response. The predictor space is divided into $J$ distinct, non-overlapping regions $R_1, \ldots, R_J$ (high-dimensional rectangles, or boxes). For each observation falling in region $R_j$, the prediction is the mean of the training responses in $R_j$. The goal is to find regions that minimize the residual sum of squares $\sum_{j=1}^{J} \sum_{i \in R_j} (y_i - \hat{y}_{R_j})^2$, where $\hat{y}_{R_j}$ is the mean response for region $R_j$. [@james2021introductionstatisticallearning, pp. 330--331, Eq. 8.1]

**Classification trees** are identical to regression trees except that the response is qualitative. Each terminal node predicts the most commonly occurring class among the training observations in that region. The class proportions $\hat{p}_{mk}$ (the proportion of training observations in the $m$th region that are from class $k$) are also of interest. [@james2021introductionstatisticallearning, pp. 335--336]

**Tree terminology:** The regions $R_1, \ldots, R_J$ are called *terminal nodes* or *leaves*. The points where the predictor space is split are *internal nodes*. The segments connecting the nodes are *branches*. Decision trees are drawn upside down: the root is at the top and the leaves are at the bottom. [@james2021introductionstatisticallearning, p. 329]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $R_j$ | "R-j" | The $j$th region (terminal node) of the tree's partition of the predictor space [@james2021introductionstatisticallearning, p. 330] |
| $\hat{y}_{R_j}$ | "y-hat R-j" | The predicted response for region $R_j$: the mean of training $y_i$ in that region (regression) [@james2021introductionstatisticallearning, p. 330] |
| $\hat{p}_{mk}$ | "p-hat m-k" | The proportion of training observations in the $m$th terminal node that belong to class $k$ [@james2021introductionstatisticallearning, p. 335] |
| $\lvert T \rvert$ | "size of T" | The number of terminal nodes in subtree $T$ [@james2021introductionstatisticallearning, p. 332] |
| $\alpha$ | "alpha" | The cost-complexity tuning parameter; larger $\alpha$ penalizes larger trees, favoring simpler subtrees [@james2021introductionstatisticallearning, p. 332] |
| $G$ | "Gini index" | $\sum_{k=1}^{K} \hat{p}_{mk}(1 - \hat{p}_{mk})$, a measure of node impurity for classification trees [@james2021introductionstatisticallearning, p. 336, Eq. 8.6] |
| $D$ | "entropy" or "deviance" | $-\sum_{k=1}^{K} \hat{p}_{mk} \log \hat{p}_{mk}$, an alternative measure of node impurity [@james2021introductionstatisticallearning, p. 336, Eq. 8.7] |

## Key results & derivations

- **Recursive binary splitting is top-down and greedy** -- The tree is built from the top, starting with all observations in one region. At each step, the algorithm selects the predictor $X_j$ and cutpoint $s$ that split the current region into two half-spaces $R_1(j,s) = \{X \mid X_j < s\}$ and $R_2(j,s) = \{X \mid X_j \geq s\}$ to minimize $\sum_{i: x_i \in R_1} (y_i - \hat{y}_{R_1})^2 + \sum_{i: x_i \in R_2} (y_i - \hat{y}_{R_2})^2$. The approach is greedy because the best split is chosen at each step without looking ahead to future splits. [@james2021introductionstatisticallearning, pp. 330--331, Eqs. 8.2--8.3]

- **Cost complexity pruning controls overfitting** -- Rather than using a threshold on RSS reduction (which is short-sighted), the standard approach grows a large tree $T_0$ and then prunes it. For each nonnegative $\alpha$, find the subtree $T \subset T_0$ that minimizes $\sum_{m=1}^{|T|} \sum_{i: x_i \in R_m} (y_i - \hat{y}_{R_m})^2 + \alpha |T|$. When $\alpha = 0$, the full tree is optimal (minimizes training error). As $\alpha$ increases, the penalty for tree size grows, and the best subtree shrinks. The parameter $\alpha$ is selected by cross-validation. This is analogous to the lasso penalty for linear models. [@james2021introductionstatisticallearning, pp. 331--333, Eq. 8.4]

- **Algorithm for building a regression tree** -- (1) Grow a large tree using recursive binary splitting, stopping only when each terminal node has fewer than some minimum number of observations. (2) Apply cost complexity pruning to obtain a sequence of best subtrees as a function of $\alpha$. (3) Use $K$-fold cross-validation to choose $\alpha$: for each fold, repeat steps 1--2, evaluate the mean squared prediction error on the held-out fold, average across folds, and pick the $\alpha$ that minimizes the average error. (4) Return the subtree from step 2 corresponding to the chosen $\alpha$. [@james2021introductionstatisticallearning, p. 333, Algorithm 8.1]

- **Classification error rate is not sensitive enough for tree growing** -- The classification error rate $E = 1 - \max_k(\hat{p}_{mk})$ is a natural criterion but is not sufficiently sensitive to node purity. Two alternative measures are preferred: the Gini index $G = \sum_{k=1}^{K} \hat{p}_{mk}(1 - \hat{p}_{mk})$, which measures total variance across classes and is small when a node is pure, and the entropy $D = -\sum_{k=1}^{K} \hat{p}_{mk} \log \hat{p}_{mk}$, which is similarly small for pure nodes. The Gini index and entropy are more sensitive to node purity than the classification error rate, making them better split criteria for growing the tree. The classification error rate may be preferred when pruning the final tree if prediction accuracy is the goal. [@james2021introductionstatisticallearning, pp. 335--336, Eqs. 8.5--8.7]

- **Trees handle qualitative predictors naturally** -- A split on a qualitative predictor assigns some of its levels to the left branch and the remaining levels to the right branch, without requiring dummy variable encoding. [@james2021introductionstatisticallearning, pp. 336--337]

- **Trees versus linear models** -- Linear regression assumes $f(X) = \beta_0 + \sum X_j \beta_j$ (Eq. 8.8), while regression trees assume $f(X) = \sum_{m=1}^{M} c_m \cdot \mathbf{1}(X \in R_m)$ (Eq. 8.9). If the true relationship is approximately linear, linear regression will outperform trees. If the true relationship involves complex interactions and nonlinearities, trees may outperform linear approaches. [@james2021introductionstatisticallearning, pp. 338--339, Eqs. 8.8--8.9]

## Prerequisites

What you must already understand for this concept to make sense:

- [bias-variance-trade-off](bias-variance-trade-off.md) -- pruning and cost complexity control the bias-variance trade-off: a large tree has low bias but high variance; a small tree has higher bias but lower variance.
- [resampling-bootstrap-and-permutation](resampling-bootstrap-and-permutation.md) -- cross-validation is used to select the pruning parameter $\alpha$.

## Misconceptions & learner traps

- **"A split that doesn't reduce the classification error rate is useless"** -- A split can increase node purity (reduce Gini index or entropy) without changing the majority class prediction. This is valuable because purer nodes produce more confident (and generally more accurate) predictions. [@james2021introductionstatisticallearning, pp. 337--338]

- **"Stopping early (not splitting if RSS gain is small) is a good pruning strategy"** -- A seemingly worthless split early on might be followed by a very good split later. The cost-complexity pruning approach avoids this problem by growing the full tree first and then pruning back. [@james2021introductionstatisticallearning, p. 331]

- **"Decision trees are as accurate as other methods"** -- Single decision trees generally do not have the same level of predictive accuracy as linear regression, logistic regression, or other methods covered in a typical introductory course. Their main advantages are interpretability, graphical representation, and the ability to handle qualitative predictors without dummy variables. Ensemble methods (bagging, random forests, boosting) dramatically improve tree prediction accuracy at the expense of interpretability. [@james2021introductionstatisticallearning, pp. 339--340]

- **"Trees are robust to small changes in the data"** -- Trees are non-robust: a small change in the data can produce a very different tree. This high variance is one of their main weaknesses and motivates ensemble methods like bagging. [@james2021introductionstatisticallearning, p. 340]

## Teaching insights & analogies

- **The tree diagram is the model** -- Unlike most statistical methods where the model is a formula, a decision tree can be displayed as a literal tree diagram. Each internal node is a yes/no question about a predictor, and following the branches from root to leaf gives the prediction. This makes trees the most interpretable predictive model for non-experts. [@james2021introductionstatisticallearning, pp. 328--329, 339]

- **The partition picture (Figure 8.3)** -- ISL's side-by-side display of the predictor-space partition and the corresponding tree makes the correspondence between regions and leaves concrete. The left panel shows the partition cannot result from recursive binary splitting (arbitrary shape); the right panel shows what recursive binary splitting actually produces (axis-aligned rectangles). [@james2021introductionstatisticallearning, p. 332]

- **Cost complexity as a tree-world lasso** -- The cost-complexity criterion $\sum \text{RSS}_m + \alpha |T|$ is directly analogous to the lasso criterion $\text{RSS} + \lambda \sum |\beta_j|$: both add a complexity penalty to the training error, and both use cross-validation to select the penalty parameter. This parallel helps learners who already understand regularization. [@james2021introductionstatisticallearning, pp. 332--333]

- **The Hitters data example** -- ISL uses the Hitters salary data (predicting log salary from Years and Hits) to build a concrete three-node regression tree, then shows the unpruned tree and CV error plot. Walking through this example step by step grounds the abstract algorithm in tangible numbers. [@james2021introductionstatisticallearning, pp. 328--335]

## How the field talks about it

When a paper says "we fit a classification tree" or "CART model," it means a single decision tree built by recursive binary splitting with pruning. "Tree depth" or "tree size" refers to the number of terminal nodes. "Pruning" always means reducing tree size by removing branches. "Split criterion" means the measure used to evaluate splits (Gini, entropy, or RSS). A "stump" is a tree with a single split ($d = 1$). When a paper uses trees as building blocks for ensembles (bagging, random forests, boosting), the individual trees are called "base learners" or "weak learners." [@james2021introductionstatisticallearning, pp. 327--340, 347]
