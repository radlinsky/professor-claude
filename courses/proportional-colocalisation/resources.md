# Resources — Proportional Colocalisation

External explanations for each module, if you want another angle. Every link below was
WebFetch-verified this session. The course's **source paper** — Wallace, Robins & Johnson (2025),
bioRxiv 2025.09.08.674910 (CC-BY 4.0; all authors GSK employees) — is cited in full on the
[syllabus](syllabus.md); read the paper's Results and Methods, which the capstone decodes.
(The bioRxiv site blocks automated fetching, so its URL is given via the DOI in the syllabus
citation rather than linked here unverified.)

## Module 01 — When fine-mapping breaks

- 📖 [GWASTutorial: Colocalization](https://cloufield.github.io/GWASTutorial/17_colocalization/)
  (tutorial) — a compact overview of how fine-mapping produces per-variant posterior probabilities
  and credible sets, and how colocalisation is built on top; useful for grounding "what a credible
  set is" before you watch it break. Overview-level, not a full hands-on lab.

## Module 02 — How it corrupts coloc

- 📖 [GWASTutorial: Colocalization](https://cloufield.github.io/GWASTutorial/17_colocalization/)
  (tutorial) — the coloc section states coloc's "0 or 1 causal variant per trait" assumption and
  defines the H0–H4 posteriors (with `PP.H4.abf` = shared); read it to see the exact
  fine-mapping-based machinery this module shows being corrupted.

## Module 03 — Proportionality is colocalisation

- 📖 [Wikipedia: Chi-squared distribution](https://en.wikipedia.org/wiki/Chi-squared_distribution)
  (reference) — the geometry here (points on a line, measured against error bars) leads directly to
  the chi-square statistic of Module 4; skim the lead to recall what "chi-square distributed" means.
- *(For the covariance-matrix construction $V = (\sigma\sigma^\top)\odot\Sigma$, see the
  [variance-structure-and-standardization](../../foundations/variance-structure-and-standardization/resources.md)
  foundation's resources.)*

## Module 04 — The proportional test statistic

- 📖 [Wikipedia: Fieller's theorem](https://en.wikipedia.org/wiki/Fieller's_theorem)
  (reference) — Fieller's statistic is the engine of the proportional test; this page gives the
  ratio-of-two-estimates confidence interval it comes from. Read the lead; the formula section is
  denser than the lesson needs.
- 📖 [MetricGate: Fieller's ratio confidence interval](https://metricgate.com/docs/fieller-ratio-confidence/)
  (article) — a more intuition-first take on Fieller: why the interval can be unbounded, and a
  worked `mtcars` ratio example. Good for the "ratio of two noisy estimates" intuition behind the
  statistic.

## Module 05 — The pairwise correction

- *(This module's multiple-testing machinery is the
  [false-discovery-rate](../../foundations/false-discovery-rate/resources.md) foundation — see its
  resources for the Benjamini–Hochberg / `p.adjust` / Holm explanations. The pairwise adaptation
  itself is specific to this paper; read the paper's "three challenges" passage, cited on the
  [syllabus](syllabus.md).)*
- 📖 [R-bloggers: The Benjamini–Hochberg procedure (FDR) and p-value adjustment, explained](https://www.r-bloggers.com/2023/07/the-benjamini-hochberg-procedure-fdr-and-p-value-adjusted-explained/)
  (R tutorial) — walks the correction with `p.adjust` from scratch; useful for seeing what the
  `p.adjust(p, n = ntests)` step does, and how Holm (the package's default) differs from BH.

## Module 06 — Capstone: reading colocPropTest

- 📄 [colocPropTest on CRAN](https://cran.r-project.org/web/packages/colocPropTest/index.html)
  (package page) — the real reference package this capstone decodes and validates against
  (`run_proptests`, `estprop`, `marg_with_V`), version 0.9.3, GPL (≥ 3). We rebuilt the method from
  the paper's equations rather than copying its source.
- 📖 [Wikipedia: Fieller's theorem](https://en.wikipedia.org/wiki/Fieller's_theorem)
  (reference) — revisit now that you've assembled the whole pipeline; the ratio-CI framing is what
  `estprop`'s profiled statistic generalises to two SNPs at once.
