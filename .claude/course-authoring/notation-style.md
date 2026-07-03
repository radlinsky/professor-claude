# Notation & pronunciation style guide

The learner's core blocker is that formulas are unreadable walls. Your job is to make
every formula *speakable*. This file sets the conventions; keep them identical across
every module so pronunciations become habits.

## The prime rule

**Never introduce a symbol without a row in the lesson's pronunciation table.**
Columns, always in this order:

| Symbol | How to say it | What it means | In our toy example |
|---|---|---|---|

The last column anchors the symbol to that lesson's toy numbers ("$\bar{x}$ → 4, the
average of 2, 4, 6"). If a symbol has no sensible toy value (e.g., $\forall$), write
how it's used instead.

## Speaking whole formulas

After showing any formula, add a "Reading it aloud:" line that speaks the ENTIRE
formula in words, e.g. for $\bar{x} = \frac{1}{n}\sum_{i=1}^{n} x_i$:

> "x-bar equals one over n, times the sum, from i equals 1 to n, of x-sub-i" —
> or in everyday words: "the mean is: add up all the x values and divide by how
> many there are."

Give BOTH the symbol-by-symbol reading and the everyday-words version.

## Standard glossary (copy rows from here — keep pronunciations consistent)

| Symbol | How to say it | What it means |
|---|---|---|
| $x_i$ | "ex sub eye" | the i-th value of x (in R: `x[i]`) |
| $n$ | "en" | the number of data points (in R: `length(x)`) |
| $\sum_{i=1}^{n}$ | "the sum from i equals 1 to n" | add up the expression to its right, once for each i (in R: `sum(...)`) |
| $\prod_{i=1}^{n}$ | "the product from i equals 1 to n" | multiply instead of add (in R: `prod(...)`) |
| $\bar{x}$ | "ex bar" | the mean (average) of the x values (in R: `mean(x)`) |
| $\hat{\beta}$ | "beta hat" | our estimate of β from data — the hat always means "estimated from data" |
| $\beta_0, \beta_1$ | "beta zero, beta one" | unknown true parameters (here: intercept and slope) |
| $\varepsilon_i$ | "epsilon sub eye" | the i-th error/noise term — what the model doesn't explain |
| $\hat{y}_i$ | "why hat sub eye" | the model's predicted value for observation i |
| $e_i$ or $r_i$ | "ee sub eye" / "residual" | observed minus predicted: $y_i - \hat{y}_i$ |
| $s^2$ | "ess squared" | sample variance (in R: `var(x)`) |
| $s$ or $\sigma$ | "ess" / "sigma (lowercase)" | standard deviation; σ is the true one, s the estimate (in R: `sd(x)`) |
| $\sigma^2$ | "sigma squared" | the true (population) variance |
| $\mu$ | "mew" | the true (population) mean |
| $\mathbb{E}[X]$ | "the expected value of X" | the long-run average of the random quantity X |
| $\mathrm{Var}(X)$ | "the variance of X" | the long-run spread of X |
| $\mathrm{Cov}(X, Y)$ | "the covariance of X and Y" | how X and Y move together (in R: `cov(x, y)`) |
| $\rho$, $r$ | "rho" / "little r" | correlation: covariance rescaled to [-1, 1] (in R: `cor(x, y)`) |
| $P(A)$ | "the probability of A" | how likely event A is |
| $P(A \mid B)$ | "the probability of A given B" | probability of A once you know B happened |
| $X \sim N(\mu, \sigma^2)$ | "X is distributed normal with mean mew and variance sigma squared" | X follows a bell curve centered at μ with spread σ² |
| $\in$ | "is in" / "is an element of" | belongs to a set: $i \in \{1,2,3\}$ |
| $\forall$ | "for all" | the statement holds for every element |
| $\approx$ | "is approximately" | nearly equal |
| $\propto$ | "is proportional to" | equal up to a constant multiplier |
| $\arg\min_b f(b)$ | "arg min over b of f of b" | the VALUE of b that makes f(b) smallest (not the smallest f itself) |
| $\arg\max$ | "arg max" | the value that maximizes |
| $\frac{d}{dx} f(x)$, $f'(x)$ | "the derivative of f with respect to x" / "f prime" | the slope of f at x |
| $\frac{\partial}{\partial b} f$ | "the partial derivative of f with respect to b" | slope of f when only b moves and everything else is held still |
| $\int_a^b f(x)\,dx$ | "the integral from a to b of f of x dee-ex" | area under f between a and b |
| $\mathbf{x}$ (bold) | "the vector ex" | a whole column of numbers at once (an R vector!) |
| $\mathbf{X}$ (bold capital) | "the matrix ex" | a table of numbers (rows = observations, columns = variables) |
| $\mathbf{X}^\top$ or $\mathbf{X}'$ | "ex transpose" | the matrix flipped: rows become columns (in R: `t(X)`) |
| $\mathbf{X}^{-1}$ | "ex inverse" | the matrix that undoes X (in R: `solve(X)`) |
| $\|\mathbf{x}\|$ | "the norm of ex" | the length of the vector (in R: `sqrt(sum(x^2))`) |
| $\log$ | "log" | natural log (base e) unless the paper says otherwise (in R: `log(x)`) |
| iid | "eye-eye-dee" | "independent and identically distributed" — each data point is a fresh, unrelated draw from the same source |

When a paper uses a symbol differently (e.g., $r$ for something else), say so
explicitly in the lesson: "this paper's $r$ is NOT the correlation r".

## LaTeX-in-Quarto rules

- Inline math: `$\bar{x}$`. Display math: `$$ ... $$` on its own lines.
- Multi-step derivations: one step per line in an `aligned` block, then a bulleted
  trick-annotation list immediately after:

  ```markdown
  $$
  \begin{aligned}
  \sum (x_i + c) &= \sum x_i + \sum c \\
                 &= \sum x_i + n\,c
  \end{aligned}
  $$

  - Line 1: a sum can be split into two sums (taught in *vectors-and-summation*).
  - Line 2: adding the constant c, n times, is n·c.
  ```

- Every derivation line gets exactly one annotation naming its trick, and the trick
  must already have been taught (earlier module or earlier in the lesson).
- Prefer $\varepsilon$ over $\epsilon$, $^\top$ over $'$ for transpose (but SHOW the
  paper's own variant in the pronunciation table when reading a specific paper).
- Don't use unicode math (∑, β) in prose where a `$...$` form exists — consistent
  LaTeX rendering beats mixed styles. Unicode is fine inside tables' "Symbol" column
  only if LaTeX fails to render there (it usually renders fine; try LaTeX first).

## Bridging to R (use constantly)

The learner thinks in R. Every notation concept should get its R equivalent stated
right next to it, like the glossary above does (`sum(x)`, `x[i]`, `t(X) %*% X`).
"New notation = R function you already know" is the fastest path to fluency.
