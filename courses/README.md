# Courses

Index of all generated courses. Claude: register every new course here (Phase 7 of
the `create-course` skill). Status values: `not started` / `in progress` / `done` —
the **Status** column belongs to the learner; never overwrite it.

| Course | Teaches | Source | Foundation prerequisites | Status |
|---|---|---|---|---|
| [simple-linear-regression](simple-linear-regression/syllabus.md) | Fitting a line by least squares, deriving the OLS formulas, reading `lm()` output & regression tables in papers, and a capstone that decodes a real regression end-to-end | Demo course (no paper) | [vectors-and-summation](../foundations/vectors-and-summation/lesson.qmd), [mean-variance-covariance](../foundations/mean-variance-covariance/lesson.qmd) | not started |
| [gradient-descent](gradient-descent/syllabus.md) | Rebuilding gradient descent from scratch (1-D descent, the gradient, fitting a line by descent), validating it against a real optimizer, and a capstone that decodes `optim()` / `scipy.minimize` output | Concept — port of `scipy.optimize` L-BFGS-B / R `optim()` (via the `port-library` skill) | [derivative-as-slope](../foundations/derivative-as-slope/lesson.qmd), [vectors-and-summation](../foundations/vectors-and-summation/lesson.qmd) | not started |
| [logistic-regression](logistic-regression/syllabus.md) | Bending a line into a probability with the sigmoid, modeling the log-odds (the logit link), reading coefficients as odds ratios, fitting by maximizing the log-likelihood with gradient ascent, and a capstone that decodes a real `glm(..., family = binomial)` end-to-end | Concept (no paper) — builds on `simple-linear-regression` and `gradient-descent` | [exponentials-and-logs](../foundations/exponentials-and-logs/lesson.qmd), [probability-and-odds](../foundations/probability-and-odds/lesson.qmd), [vectors-and-summation](../foundations/vectors-and-summation/lesson.qmd), [derivative-as-slope](../foundations/derivative-as-slope/lesson.qmd) | not started |
