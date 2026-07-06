# Resources — Bayesian Colocalisation

External explanations to pair with each module. Watch/read the video *after* the lesson's
toy example, then use the written references when you want the real-tool detail.

The course's source paper is open access (CC-BY 4.0): **Giambartolomei, C. et al. (2014).
"Bayesian test for colocalisation between pairs of genetic association studies using summary
statistics." *PLoS Genetics* 10(5):e1004383.**
[Read it here](https://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1004383).

## Module 01 — The colocalisation question

- 📖 [GWAS–eQTL Colocalization Analysis Workflow (Hanrui Zhang)](https://hanruizhang.github.io/GWAS-eQTL-Colocalization/)
  (written workflow with R code) — a concrete, step-by-step walkthrough of running `coloc.abf`
  on a real GWAS + eQTL pair, including the biological "do they share a variant?" framing this
  module sets up. Skim the intro after the lesson to see the question in a real analysis.
- 📖 [The coloc package documentation (Chris Wallace)](https://chr1swallace.github.io/coloc/)
  (docs site) — the home of the real `coloc` package this course rebuilds. Read the landing
  page's "what colocalisation asks" section; it states the two-trait, one-region setup in the
  method authors' own words.

## Module 02 — Five hypotheses

- 📖 [coloc vignette: colocalisation by enumeration](https://chr1swallace.github.io/coloc/articles/a03_enumeration.html)
  (written vignette) — spells out H0–H4 exactly as this module does ("H3: both traits are
  associated, but with different causal variants; H4: … share a single causal variant") and
  shows the five PPs from a real run. The best confirmation that your mental model of the five
  stories matches the package.
- 📺 [Bayes' Theorem, Clearly Explained (StatQuest)](https://www.youtube.com/watch?v=9wCnvr7Xw4E)
  (video) — Josh Starmer's plain-English, small-numbers walk through Bayes' theorem. Watch it
  to firm up the "prior × evidence, then normalise" idea before the priors $p_1, p_2, p_{12}$
  make an appearance.

## Module 03 — Combining ABFs with priors

- 📺 [The Medical Test Paradox, and Redesigning Bayes' Rule (3Blue1Brown)](https://www.youtube.com/watch?v=lG4VkPoG3ko)
  (video, ~21 min) — Grant Sanderson builds intuition for Bayes factors / likelihood ratios and
  updating with them — exactly the quantity you're summing and normalising in this module. The
  visual "odds form" of Bayes' rule pairs well with the log-space combination.
- 📖 [coloc vignette: colocalisation by enumeration](https://chr1swallace.github.io/coloc/articles/a03_enumeration.html)
  (written vignette) — re-read the "posterior probabilities" section here alongside your
  `coloc_abf()`; it shows the same five-support-then-normalise pipeline you implemented, on the
  package's own example data.

## Module 04 — Capstone: reading coloc.abf

- 📖 [Giambartolomei et al. (2014), PLoS Genetics (open access)](https://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1004383)
  (paper) — the source itself. Read the Methods and the "Results / power" sections; the capstone
  decodes exactly these, and the paper's own sample-size simulation is where the ~2%-of-variance
  power note comes from.
- 📖 [GWAS–eQTL Colocalization Analysis Workflow (Hanrui Zhang)](https://hanruizhang.github.io/GWAS-eQTL-Colocalization/)
  (written workflow) — end-to-end `coloc.abf` on real data, including reading `PP.H4.abf` and
  the usual PP4 > 0.8 threshold. A good template for how a real colocalisation result is
  reported once you can decode every field.
- 📖 [The coloc package documentation (Chris Wallace)](https://chr1swallace.github.io/coloc/)
  (docs site) — for "what you still can't read yet": the SuSiE (`coloc.susie`) and
  variant-specific-prior vignettes here are the natural next steps beyond the single-causal
  `coloc.abf` you rebuilt.
