# Resources: Loss functions, and finding their bottom

All links verified 2026-07-04.

- 📺 [StatQuest — Gradient Descent, Step-by-Step](https://youtu.be/sDv4f4s2SB8)
  (video, ~24 min) — Josh Starmer walks the exact loop of this lesson on tiny numeric
  examples: write a loss (sum of squared residuals), then *find the setting that makes
  it smallest*. Watch after "Getting a feel for it." It goes one step past us — it
  *searches* downhill by hand rather than solving "slope = 0" — which is precisely the
  "when the algebra is messy, the computer searches" idea at the end of the lesson (and
  the gradient-descent course ahead). Ignore the multi-parameter middle on a first pass;
  the single-knob opening is our module.
- 📖 [3Blue1Brown — The paradox of the derivative (Essence of Calculus, Ch. 2)](https://www.3blue1brown.com/lessons/derivatives)
  (article + video, ~17 min) — the clearest visual of the one fact this lesson leans on:
  the slope of a curve at a point, shrunk from a secant to a tangent (the speedometer
  picture). Watch it if "slope is zero at the bottom" still feels shaky before the
  "differentiate, set to zero, solve" recipe.
- 📖 [3Blue1Brown — Essence of Calculus (series home)](https://www.3blue1brown.com/lessons/essence-of-calculus)
  (article + video series) — the visuals-first calculus series; the early chapters build
  the derivative-as-slope intuition our recipe rides on, and later chapters show
  *derivative formulas* (like the derivative of a squared term) built from pictures
  rather than memorized rules. Dip into a chapter whenever a step here feels like a rule
  pulled from nowhere.
