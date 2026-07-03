# Resources — Logistic Regression

External videos and readings, one section per module. Every link was verified to
resolve and to be about the module's topic. Prerequisite foundations have their own
resource lists ([exponentials-and-logs](../../foundations/exponentials-and-logs/resources.md),
[probability-and-odds](../../foundations/probability-and-odds/resources.md)).

## Module 01 — From a line to a probability (the sigmoid)

- 📺 [StatQuest: Logistic Regression](https://www.youtube.com/watch?v=yIYKR4sgzI8)
  (video, Josh Starmer) — the big-picture overview: instead of a line, fit an S-shaped
  logistic curve to 0/1 data. Plain English with tiny examples; watch after this module's
  toy example to see the whole method in one sitting (it previews the later modules too).
- 🎮 [Google ML Crash Course: Calculating a probability with the sigmoid function](https://developers.google.com/machine-learning/crash-course/logistic-regression/sigmoid-function)
  (interactive article) — walks the exact formula $\sigma(z) = 1/(1+e^{-z})$, with a graph,
  a table of outputs, and two practice questions. Beginner-friendly; use it to drill "score
  in, probability out" and to see why the output is trapped in $(0,1)$.

## Module 02 — Odds, log-odds, and the logit link

- 📺 [StatQuest: Odds and Log(Odds), Clearly Explained!!!](https://www.youtube.com/watch?v=ARfXDSkQf1Y)
  (video, Josh Starmer) — builds odds and log-odds from scratch and shows why the log-odds
  scale is the symmetric, well-ranged one a line can live on — the exact motivation behind
  the logit link. Watch alongside this lesson's "why model the log-odds" section.
- 📺 [StatQuest: Logistic Regression Details Pt1: Coefficients](https://www.youtube.com/watch?v=vN5cNN2-HWE)
  (video, Josh Starmer) — the payoff match for this module: how to read a fitted
  coefficient as a change in log-odds and as an odds ratio, worked through examples. Watch
  after the "reading a coefficient two ways" section to cement it.

## Module 03 — Likelihood and fitting by gradient ascent

- 📺 [StatQuest: Maximum Likelihood, clearly explained!!!](https://www.youtube.com/watch?v=XepXtl9YKwc)
  (video, Josh Starmer) — the core idea of this module in general form: choose the
  parameters that make the observed data most probable. Watch after the "which dial setting
  best explains the crime" intuition to see maximum likelihood beyond just logistic
  regression.
- 📺 [StatQuest: Gradient Descent, Step-by-Step](https://www.youtube.com/watch?v=sDv4f4s2SB8)
  (video, ~24 min, Josh Starmer) — a thorough walk through descent (and, by the sign flip,
  ascent): loss surface, gradient, step, repeat. A companion to this repo's own
  [gradient-descent course](../gradient-descent/syllabus.md); watch if the "climb the
  log-likelihood" machinery feels shaky.

## Module 04 — Capstone: reading a real logistic regression

- 📺 [StatQuest: Logistic Regression in R, Clearly Explained!!!](https://www.youtube.com/watch?v=C4N3_XJJ-jU)
  (video, Josh Starmer) — fits and reads a `glm(..., family = binomial)` in R, the same
  tool this capstone decodes. Watch alongside the capstone to see someone narrate the
  output on different data.
- 📺 [StatQuest: Logistic Regression](https://www.youtube.com/watch?v=yIYKR4sgzI8)
  (video, Josh Starmer) — worth a second pass now that you've built every piece: everything
  in it should read as familiar, which is the whole point of the capstone. A good
  end-of-course consolidation.
