# Resources: The multivariate normal distribution

All links verified 2026-07-11.

- 📖 [Multivariate Normal Primer](https://peterroelants.github.io/posts/multivariate-normal-primer/)
  (interactive blog post with Python code and plots) — builds from the univariate
  normal through affine transformations, sampling via Cholesky decomposition, and
  marginal/conditional distributions with visualizations at every step. The code is
  Python, not R, but the math and pictures are exactly this lesson's content. Read
  after finishing the lesson to see the same ideas from a second angle.

- 📖 [Multivariate Normal Distribution in R](https://r-statistics.co/Multivariate-Normal-Distribution-in-R.html)
  (interactive R tutorial) — walks through simulating correlated multivariate data
  with `MASS::mvrnorm()`, building and reading covariance matrices, contour plots,
  and confidence ellipses, all in R with runnable code blocks. Covers the same
  ground as this lesson but with larger, more realistic examples. Work through it
  after the practice set for extra reps.

- 📺 [Mahalanobis Distance Explainer](https://www.youtube.com/watch?v=AYe81YiSNMo)
  (video) — a visual walk-through of what Mahalanobis distance measures and why it
  beats Euclidean distance for elliptical data. Watch after the lesson's Mahalanobis
  section to reinforce the intuition of "distance that respects the shape."

- 📖 [Probability and Statistics for Data Science](https://probability4datascience.com/)
  (free online textbook by Stanley Chan) — Chapter 5 covers joint distributions,
  marginals, conditional distributions, covariance, and the multivariate Gaussian
  density, all with worked examples and figures. The lesson cites this book
  throughout; reading the matching sections gives you the full derivations behind
  the results presented here.
