# Resources — The false discovery rate

Verified external explanations, if you want another angle. (Every link below was checked this
session.)

- 📖 [R-bloggers: The Benjamini–Hochberg procedure (FDR) and p-value adjustment, explained](https://www.r-bloggers.com/2023/07/the-benjamini-hochberg-procedure-fdr-and-p-value-adjusted-explained/)
  (R tutorial) — walks BH from scratch on a small set of p-values, first by hand (sort, rank,
  scale by $m/i$) and then with `p.adjust(p, method = "BH")`, verifying the two agree. Exactly
  this lesson's shape, in R — do it after the lesson to see `p.adjust` from the inside.
- 📖 [Wikipedia: False discovery rate](https://en.wikipedia.org/wiki/False_discovery_rate)
  (reference) — good for the family-wise-error-vs-FDR contrast this lesson draws: it states FDR
  procedures "have greater power, at the cost of increased numbers of Type I errors," and gives
  the step-by-step BH algorithm. Read the lead and the "Benjamini–Hochberg procedure" section.
