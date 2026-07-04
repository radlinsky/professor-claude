# Resources: Resampling — the bootstrap & permutation tests

All links verified 2026-07-04.

- 📺 [StatQuest: Bootstrapping Main Ideas!!!](https://www.youtube.com/watch?v=Xz0x-8-cgaQ)
  (video, ~9 min) — plain-English, small-numbers walk through the exact bootstrap recipe
  in this lesson: resample with replacement, recompute the statistic, repeat, and read off
  a standard error or CI — including the "works for any statistic, even without a formula"
  point. Watch right after the lesson's "Explore it" bootstrap histogram.
- 🎮 [Seeing Theory: Frequentist Inference](https://seeing-theory.brown.edu/frequentist-inference/index.html)
  (interactive) — draw a sample, then hit **Resample** (with replacement) and watch the
  sampling distribution of the mean build up, and generate many confidence intervals to see
  how often they cover the truth. The bootstrap idea made draggable. Use after the
  bootstrap section.
- 📖 [Applied Biostats — Shuffling labels to generate a null](https://bookdown.org/ybrandvain/Applied-Biostats/perm1.html)
  (free book chapter, with R) — a beginner-friendly written treatment of the permutation
  test: shuffle the group labels to build the "no effect" distribution by hand, then locate
  the observed statistic in it, with runnable R. Read after the lesson's permutation
  section to see the same recipe on a worked example.
