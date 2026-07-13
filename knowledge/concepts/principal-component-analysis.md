---
title: "Principal component analysis"
topic: linear-algebra
---

<!-- Copy of .claude/course-authoring/kb-concept-template.md. Rules:
     knowledge-base.md (structure, merge protocol) + citations.md (citation form).
     Keep prose paper-agnostic; every claim gets a bracketed citation.
     Omit a section entirely if it has nothing yet — do not leave placeholders. -->

Principal component analysis (PCA) is a technique for reducing the dimension of a dataset by projecting it onto the subspace that retains the most variance. The principal components are the eigenvectors of the covariance matrix, ordered by decreasing eigenvalue, and each eigenvalue equals the variance in that eigenvector's direction. [@austin2022understandinglinearalgebra, pp. 446--447]

**Also known as:** PCA; Karhunen-Loeve transform (signal processing)

## Definition(s)

Given a demeaned data matrix $A$ (columns are data points), the **covariance matrix** is $C = \frac{1}{N}AA^T$. The **principal components** are the eigenvectors $\mathbf{u}_1, \mathbf{u}_2, \ldots, \mathbf{u}_m$ of $C$, ordered so that their eigenvalues satisfy $\lambda_1 \ge \lambda_2 \ge \cdots \ge \lambda_m \ge 0$. [@austin2022understandinglinearalgebra, p. 447]

In ISL's notation, the first **principal component loading vector** $\phi_1 = (\phi_{11}, \phi_{21}, \ldots, \phi_{p1})^T$ is the unit vector in feature space that defines a direction along which the data vary the most. The **principal component scores** $z_{11}, z_{21}, \ldots, z_{n1}$ are the projections of each observation onto this direction: $z_{i1} = \sum_{j=1}^{p} \phi_{j1} x_{ij}$. The loading vector solves $\max_\phi \frac{1}{n} \sum_{i=1}^{n} z_{i1}^2$ subject to $\|\phi\|_2 = 1$. Subsequent components maximize variance subject to being uncorrelated with (orthogonal to) all previous components. [@james2021introductionstatisticallearning, pp. 497--501, Eqs. 12.1--12.3]

**Two equivalent interpretations of PCA:** (1) PCA finds the directions of maximum variance -- each successive loading vector maximizes the variance of the projected data subject to orthogonality; (2) PCA finds the closest $M$-dimensional hyperplane to the data in the sense of minimizing the sum of squared perpendicular distances. These two formulations give the same loading vectors and scores. [@james2021introductionstatisticallearning, pp. 497--503; @austin2022understandinglinearalgebra, pp. 447--448]

**Probabilistic formulation:** Treating the data as realizations of a random
vector $\boldsymbol{X}$ with covariance $\boldsymbol{\Sigma} =
\mathbb{E}[\boldsymbol{X}\boldsymbol{X}^T]$ (assuming zero mean), the leading
principal component is the unit vector that maximizes the projected variance:
$\hat{\boldsymbol{v}} = \arg\max_{\|\boldsymbol{v}\|_2 = 1}
\boldsymbol{v}^T \boldsymbol{\Sigma}\boldsymbol{v}$. The solution is the
eigenvector of $\boldsymbol{\Sigma}$ with the largest eigenvalue (Theorem
5.21). The proof uses Lagrange multipliers and reduces to
$\boldsymbol{\Sigma}\boldsymbol{v} = \lambda\boldsymbol{v}$.
[@chan2021probabilitydatascience, pp. 305--306]

## Notation

| Symbol | How to say it | What it means |
|---|---|---|
| $\mathbf{u}_i$ | "the i-th principal component" | The eigenvector of $C$ associated with the $i$th largest eigenvalue. Defines a direction of variance in the data. [@austin2022understandinglinearalgebra, p. 447] |
| $W_n$ | "the subspace spanned by the first n principal components" | The $n$-dimensional subspace onto which the data is projected. [@austin2022understandinglinearalgebra, p. 447] |
| $Q^TA$ | "Q transpose A" | When $Q = [\mathbf{u}_1 \; \cdots \; \mathbf{u}_n]$, $Q^TA$ gives the coordinates of each data point projected onto the subspace $W_n$. [@austin2022understandinglinearalgebra, p. 450] |
| $\phi_m$ | "phi sub m" | The $m$th principal component loading vector (a unit vector in $\mathbb{R}^p$); columns of the "rotation" matrix in R's `prcomp()`. [@james2021introductionstatisticallearning, pp. 497--498] |
| $z_{im}$ | "z sub i m" | The $m$th principal component score for observation $i$: $z_{im} = \sum_{j=1}^{p} \phi_{jm} x_{ij}$. [@james2021introductionstatisticallearning, p. 498] |
| PVE | "proportion of variance explained" | The fraction of total data variance captured by the $m$th component: $\text{PVE}_m = \sum_{i=1}^{n} z_{im}^2 \big/ \sum_{j=1}^{p} \sum_{i=1}^{n} x_{ij}^2$. Cumulative PVE of the first $M$ components can be interpreted as the $R^2$ of the $M$-dimensional PCA approximation. [@james2021introductionstatisticallearning, pp. 503--504, Eqs. 12.8--12.10] |

## Key results & derivations

- **Eigenvalue equals directional variance.** If $\mathbf{u}$ is a unit eigenvector of $C$ with eigenvalue $\lambda$, then the variance of the data projected onto the line defined by $\mathbf{u}$ is $V_\mathbf{u} = \lambda$. [@austin2022understandinglinearalgebra, p. 431]
- **Optimal variance retention.** The first $n$ principal components span the $n$-dimensional subspace $W_n$ that retains more variance than any other $n$-dimensional subspace. The variance retained is $\lambda_1 + \lambda_2 + \cdots + \lambda_n$. [@austin2022understandinglinearalgebra, pp. 447--448]
- **Fraction of variance explained.** The fraction of total variance retained by the first $n$ principal components is $(\lambda_1 + \cdots + \lambda_n) / (\lambda_1 + \cdots + \lambda_m)$. [@austin2022understandinglinearalgebra, p. 447]
- **Projection coordinates.** Given the matrix $Q = [\mathbf{u}_1 \; \cdots \; \mathbf{u}_n]$ of the first $n$ principal components, the projection of a data point $\mathbf{x}$ onto $W_n$ has coordinates $Q^T\mathbf{x}$ in the principal component basis. Applying this to all columns of $A$ gives the reduced-dimension representation $Q^TA$. [@austin2022understandinglinearalgebra, pp. 449--450]
- **PCA via SVD.** If $A = U\Sigma V^T$ is the SVD of the demeaned data matrix, then $C = \frac{1}{N}AA^T = U\left(\frac{1}{N}\Sigma\Sigma^T\right)U^T$, so the principal components are the columns of $U$ (left singular vectors) and $V_{\mathbf{u}_i} = \sigma_i^2/N$. [@austin2022understandinglinearalgebra, p. 478]
- **Projected coordinates via SVD.** The coordinates of the projected data points in the subspace of the first $k$ principal components are given by $\Gamma_k = \Sigma_k V_k^T$, which avoids forming $C$ altogether. [@austin2022understandinglinearalgebra, p. 480]
- **Standardization for mixed-scale data.** When features have different scales (e.g., body mass in grams vs. beak length in mm), data should be standardized (demean then divide by standard deviation) before PCA so that the covariance matrix is actually the correlation matrix. [@austin2022understandinglinearalgebra, p. 457; @james2021introductionstatisticallearning, pp. 505--506]
- **Variance decomposition identity.** The total variance of the data decomposes as the variance of the first $M$ principal components plus the MSE of the $M$-dimensional approximation. Maximizing the variance of the first $M$ PCs is equivalent to minimizing the approximation error. [@james2021introductionstatisticallearning, pp. 503--504, Eq. 12.11]
- **PVE as R-squared.** The cumulative PVE of the first $M$ components equals $1 - \text{RSS}/\text{TSS}$, where RSS is the residual sum of squares of the $M$-dimensional approximation and TSS is the total sum of squared data elements. This is the $R^2$ of the PCA approximation. [@james2021introductionstatisticallearning, pp. 504--505]
- **Uniqueness up to sign.** In practice, PCA loading vectors are unique up to a sign flip: flipping the sign of a loading vector simply flips the sign of the corresponding scores, but the direction (line in $p$-space) is unchanged. Different software packages may report opposite signs. [@james2021introductionstatisticallearning, p. 507; @austin2022understandinglinearalgebra, p. 447]
- **No single rule for choosing the number of components.** For visualization, the scree plot (PVE per component) and its elbow heuristic are standard but inherently subjective. For supervised use (e.g., PCR), the number of components can be selected by cross-validation -- an objective criterion. [@james2021introductionstatisticallearning, pp. 507--508]
- **Matrix completion via PCA.** When some observations $x_{ij}$ are missing, a modified optimization (Eq. 12.12) simultaneously imputes the missing values and recovers approximate loading vectors and scores. An iterative algorithm (Algorithm 12.1, "Hard-Impute") alternates between computing PCA on the completed matrix and re-imputing missing entries from the low-rank approximation. [@james2021introductionstatisticallearning, pp. 508--511]
- **PCA as eigendecomposition of $\boldsymbol{\Sigma}$ (probabilistic view).** The covariance matrix $\hat{\boldsymbol{\Sigma}} = \frac{1}{N}\sum_{n=1}^{N}(\boldsymbol{x}^{(n)} - \hat{\boldsymbol{\mu}})(\boldsymbol{x}^{(n)} - \hat{\boldsymbol{\mu}})^T$ is estimated from data, then eigendecomposed as $[\boldsymbol{U}, \boldsymbol{S}] = \text{eig}(\hat{\boldsymbol{\Sigma}})$. The columns of $\boldsymbol{U}$ are the principal components and the diagonal entries of $\boldsymbol{S}$ are the eigenvalues (variances). [@chan2021probabilitydatascience, pp. 306--307]

## Prerequisites

- [spectral-theorem-and-symmetric-matrices](spectral-theorem-and-symmetric-matrices.md) -- PCA depends on orthogonal diagonalization of the symmetric covariance matrix.
- [quadratic-forms](quadratic-forms.md) -- variance in a direction is the quadratic form $V_\mathbf{u} = \mathbf{u} \cdot (C\mathbf{u})$; max/min results from eigenvalues give the optimality of principal components.
- [orthogonal-projection](orthogonal-projection.md) -- projecting data onto the subspace spanned by principal components uses orthogonal projection.
- [bias-variance-trade-off](bias-variance-trade-off.md) -- PCA as an unsupervised method does not have a supervised test error to minimize; the trade-off manifests in choosing how many components to retain (more components = less bias in approximation, but potentially more noise). [@james2021introductionstatisticallearning, pp. 495--496, 508]

## Misconceptions & learner traps

- **"PCA always lets you reduce to 2D without losing information."** PCA always loses information when reducing dimension (unless the data truly lies in a lower-dimensional subspace). The question is how much variance is retained -- if the first 2 eigenvalues dominate, very little is lost. [@austin2022understandinglinearalgebra, p. 448]
- **"The principal components are unique."** The eigenvectors are unique only up to sign (and up to arbitrary rotation within eigenspaces of repeated eigenvalues). The eigenvalues, and hence the variances, are unique. [@austin2022understandinglinearalgebra, p. 447]
- **"Zero eigenvalue means a data error."** A zero eigenvalue of $C$ means the data has no variance in that direction -- the data lies in a lower-dimensional subspace. This is a property of the data, not an error. [@austin2022understandinglinearalgebra, p. 447]
- **"You don't need to scale the variables before PCA."** PCA results depend on the scale of the variables. If variables are measured in different units (e.g., crime rates per 100,000 vs. percentage urban population), the variable with the largest variance will dominate the first principal component. Scaling each variable to have standard deviation one before PCA avoids this. The exception is when all variables are measured in the same units and comparable magnitudes (e.g., gene expression levels), where unscaled PCA may be preferred. [@james2021introductionstatisticallearning, pp. 505--506]
- **"There is an objective rule for how many components to keep."** For unsupervised applications, choosing the number of components is inherently subjective (scree plot, elbow heuristic). There is no well-accepted objective criterion. For supervised applications like PCR, cross-validation provides an objective answer. [@james2021introductionstatisticallearning, pp. 507--508]
- **"PCA fails on nonlinear structure."** PCA finds the best *linear* subspace. If the data lie on a nonlinear manifold -- for example, points distributed along a circle embedded in 3D -- PCA can project from 3D to a 2D plane, but it cannot recover the intrinsic 1D angular coordinate because that coordinate is a nonlinear function of the ambient coordinates. Kernel PCA applies a nonlinear transformation before running standard PCA. [@chan2021probabilitydatascience, p. 311]
- **"PCA basis vectors are interpretable features."** The eigenvectors of the covariance matrix are purely mathematical constructs with no guarantee of semantic meaning. A principal component may mix all original features. For interpretable features, methods like non-negative matrix factorization or sparse PCA are preferred. [@chan2021probabilitydatascience, p. 311]
- **"The leading principal component is the most important risk factor."** PCA finds directions of maximum variance, not maximum predictive power. The leading PC may simply capture the variable with the highest variance (often a scale artifact). Identifying important predictors requires supervised methods like LASSO or variable selection. [@chan2021probabilitydatascience, p. 311]

## Teaching insights & analogies

- **Variance budget.** The total variance is the sum of all eigenvalues (the trace of $C$). PCA asks: if I can only "spend" $n$ directions, which $n$ directions capture the most of this budget? The answer is always the top $n$ eigenvectors. [@austin2022understandinglinearalgebra, pp. 425, 447]
- **UK diet example.** Four nations described by 17 food categories (in $\mathbb{R}^{17}$): projecting onto the first two principal components immediately reveals that Northern Ireland is an outlier. Examining the components of $\mathbf{u}_1$ shows WHICH foods drive the difference. [@austin2022understandinglinearalgebra, pp. 450--452]
- **Iris dataset.** 150 flowers described by 4 measurements: the first two PCs account for >96% of variance, and the 2D projection cleanly separates the three species. This illustrates that PCA can discover structure that raw data tables hide. [@austin2022understandinglinearalgebra, pp. 453--454]
- **SVD as the computational shortcut.** Rather than forming $C = \frac{1}{N}AA^T$ (which squares condition numbers and can lose precision), compute the SVD of $A$ directly. The left singular vectors are the principal components and $V_{\mathbf{u}_i} = \sigma_i^2/N$. [@austin2022understandinglinearalgebra, p. 478]
- **USArrests biplot.** ISL uses a biplot of the USArrests data (50 states, 4 variables: Murder, Assault, UrbanPop, Rape) to show both scores and loadings in one figure. Murder, Assault, and Rape load similarly on PC1 (all negative), while UrbanPop loads heavily on PC2. This reveals that PC1 captures overall crime rate and PC2 captures urbanization. [@james2021introductionstatisticallearning, pp. 498--501]
- **Scaled vs. unscaled comparison (Figure 12.4).** ISL displays side-by-side biplots on the USArrests data with and without scaling. Without scaling, the first PC loading puts almost all weight on Assault (variance = 6945) because it has much higher variance than the other three variables (18.97, 87.73, 209.5). This makes the consequences of not scaling vivid. [@james2021introductionstatisticallearning, pp. 505--506]
- **Scree plot and elbow.** The scree plot (PVE vs. component number) and the cumulative PVE plot are the standard visual tools for deciding how many components to retain. The "elbow" is where the marginal PVE drops sharply. For USArrests, the first two PCs explain 87% of variance; the elbow is after PC2. [@james2021introductionstatisticallearning, pp. 504--505]
- **PCA for recommender systems.** Matrix completion via PCA underlies many recommender systems: for Netflix's customer-movie rating matrix (480,189 customers x 17,770 movies, 99% missing), the $M$ components can be interpreted as "genres" and the scores as each user's affinity for each genre. [@james2021introductionstatisticallearning, pp. 512--514]
- **Eigenface example.** Given $N = 16{,}128$ face images of dimension $d = 32{,}256$ (168 x 192 pixels), PCA computes the covariance matrix and its eigenvectors ("eigenfaces"). Each face image can be approximated as a linear combination $\boldsymbol{x}^{(n)} \approx \sum_{i=1}^{p} \alpha_i \boldsymbol{u}_i$ with $p \ll d$ (e.g., $p = 100$ vs. $d = 32{,}256$), achieving massive dimensionality reduction. The coefficients $\boldsymbol{\alpha}^{(n)} = \boldsymbol{U}_p^T \boldsymbol{x}^{(n)}$ serve as compact feature vectors for downstream tasks like classification. [@chan2021probabilitydatascience, pp. 309--310]

## How the field talks about it

In statistics and machine learning, "run PCA" means: (1) center (and often standardize) the data, (2) compute the covariance (or correlation) matrix, (3) find its eigendecomposition, (4) project onto the top $k$ eigenvectors. Software returns "loadings" (eigenvectors), "scores" (projected coordinates), and "proportion of variance explained" (eigenvalue ratios). A "scree plot" shows eigenvalues in decreasing order, and the "elbow" suggests how many components to retain. [@austin2022understandinglinearalgebra, pp. 446--455] PCA is an unsupervised learning method -- it does not use a response variable. When a paper says "the first two PCs explain 87% of variance," it means the cumulative PVE of PC1 and PC2 is 0.87. "Matrix completion" or "imputation via PCA" refers to the iterative algorithm that exploits low-rank structure to fill in missing entries. In R, `prcomp(X, scale = TRUE)` performs PCA with standardization; the `rotation` matrix contains loadings and the `x` matrix contains scores. [@james2021introductionstatisticallearning, pp. 495--514, 530--533]
