# Foundations library

Shared, **reusable** building-block modules. Courses link here instead of re-teaching
the same prerequisite.

**Genericity rule:** a module belongs here if it would appear essentially unchanged in
a course about a *different* paper or method (e.g., summation notation, variance,
matrix multiplication, the chain rule). Method-specific material stays in its course.

**Source license:** foundation modules are paper-agnostic and have no `syllabus.md`, so
they carry no source-license verdict — `n/a` by construction (see
`.claude/course-authoring/source-licensing.md`).

Claude: **check this table before writing any prerequisite module.** If a module
already covers the concept, link to it from the new course and add that course to its
*Used by* column. The *Status* column belongs to the learner (`not started` /
`in progress` / `done`) — never overwrite it.

| Module | Concepts covered | Used by | Status |
|---|---|---|---|
| [reading-math-notation](reading-math-notation/lesson.qmd) | The unwritten reading conventions: accents as operators ($\bar{x}$, $\hat{\beta}$, $\tilde{x}$), Greek-vs-Latin (parameter vs statistic), subscript-vs-superscript roles, implied multiplication, the relation zoo ($=$, $:=$, $\approx$, $\propto$, $\in$), operators ($\mathbb{E}$, $\mathrm{Var}$, $P(\cdot\mid\cdot)$, $\arg\min$), and overloaded $\lvert\cdot\rvert$ | all courses (entry-point grammar) | not started |
| [vectors-and-summation](vectors-and-summation/lesson.qmd) | What a vector is (an R vector!), subscript/index notation ($x_i$), summation notation ($\Sigma$), rules for manipulating sums | [simple-linear-regression](../courses/simple-linear-regression/syllabus.md), [gradient-descent](../courses/gradient-descent/syllabus.md), [logistic-regression](../courses/logistic-regression/syllabus.md) | not started |
| [mean-variance-covariance](mean-variance-covariance/lesson.qmd) | The mean ($\bar{x}$), deviations from the mean, variance ($s^2$), standard deviation, covariance, correlation | [simple-linear-regression](../courses/simple-linear-regression/syllabus.md) | not started |
| [derivative-as-slope](derivative-as-slope/lesson.qmd) | The derivative as the slope of a curve; measuring it numerically (central difference); rate of change; reading a slope's sign and steepness | [gradient-descent](../courses/gradient-descent/syllabus.md), [logistic-regression](../courses/logistic-regression/syllabus.md) | not started |
| [exponentials-and-logs](exponentials-and-logs/lesson.qmd) | The constant $e$ and $e^x$, the natural log ($\log$), the undo pair ($\log(e^x)=x$, $e^{\log y}=y$), and the log rules (product→sum, quotient→difference, power→multiplier) | [logistic-regression](../courses/logistic-regression/syllabus.md) | not started |
| [probability-and-odds](probability-and-odds/lesson.qmd) | Probability as a number in $[0,1]$, odds ($p/(1-p)$), log-odds (the logit), and converting between all three | [logistic-regression](../courses/logistic-regression/syllabus.md) | not started |
