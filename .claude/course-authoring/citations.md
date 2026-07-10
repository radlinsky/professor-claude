# Citations

Goal: every factual claim in the knowledge base — and any sourced result reused in a
lesson — is traceable to a specific place in a specific work. One BibTeX file, one
key convention, one citation form. (Enforced by `scripts/check-indexes.R` check 8
and audited by content-review-checklist check 22.)

## The one bibliography

- **File:** `knowledge/references.bib` — the ONLY `.bib` in the repo. Never create
  a per-course or per-page bibliography.
- **Wiring:** the root `_quarto.yml` sets `bibliography: knowledge/references.bib`
  project-wide. Pages with no citations render unchanged; pages that cite get a
  References section appended automatically (default Chicago author–date; no CSL
  file). If that section is ever unwanted on a specific lesson, the per-page
  escape hatch is `suppress-bibliography: true` in its YAML header — do not use it
  pre-emptively.
- **Organization:** by source, not by topic — one entry per work, alphabetized by
  key. Topic→source mapping is NOT the .bib's job; it lives in the concept pages
  and glossary rows that cite the keys, and the generated index in
  `knowledge/README.md` shows each concept's sources.
- **Entry quality:** use the correct entry type (`@book`, `@article`, `@misc` for
  preprints/web). Required fields: author, title, year, plus publisher (books) or
  journal (articles), plus `url`/`doi` when one exists. Verify bibliographic
  details against the work itself or its DOI page — never from memory.

## Key convention

`<firstauthor><year><shortname>`, all lowercase, no separators — the deterministic
transform of the source slug used for the PDF and the source record:

| Source slug (PDF / `knowledge/sources/`) | BibTeX key |
|---|---|
| `2018-boyd-vmls` | `boyd2018vmls` |
| `2024-smith-mixedmodels` | `smith2024mixedmodels` |

Author-first means keys never start with a digit (strict-BibTeX safe), and CI can
mechanically check that a source record's declared key matches its filename.
Works cited that are NOT ingested sources (no PDF, no source record — e.g. a
textbook a paper quotes a result from) use the same `<firstauthor><year><shortname>`
shape, minting the shortname from the title.

## Citation form

Bracketed citations ONLY — never bare `@key` in prose (keeps pages readable and
the CI check exact):

```markdown
[@boyd2018vmls]                 — whole work
[@boyd2018vmls, p. 214]         — single page
[@boyd2018vmls, pp. 210-214]    — page range
[@boyd2018vmls, §3.2]           — section
[@boyd2018vmls, ch. 5]          — chapter
[@boyd2018vmls, §3.2; @smith2024mixedmodels, p. 4]  — multiple works
```

Prefer the tightest pinpoint you actually verified: a page you read beats a
chapter you skimmed. A claim synthesized across a whole chapter may cite the
chapter.

## Where citations appear

- **`knowledge/concepts/*.md` and `knowledge/glossary.md`** — required on every
  claim. See `.claude/course-authoring/knowledge-base.md` for the every-claim-cited
  rule and the `*(synthesis)*` marker for uncited connective statements.
- **Course lessons and practice pages** — allowed and encouraged wherever a
  specific result, number, or dataset is drawn from a source. Foundations stay
  paper-agnostic in *prose* (per `course-structure.md`); a citation bracket after a
  standard result is fine and does not break genericity.
- **Module-check quizzes** — never. Quiz items are self-contained
  (`quiz-authoring.md`).

## Relationship to the other source conventions

- **`source-licensing.md`** — licensing is about *permission*, citation is about
  *provenance*; you always need both. The license verdict for an ingested source
  lives in its `knowledge/sources/<slug>.md` record (same `**Source license:**`
  line format, checked by `license-check.yml`). Quoting text or a formula
  *verbatim* requires an OK or human-confirmed verdict; **paraphrased claims are
  cited too** — a citation is not only for quotes.
- **`resource-curation.md`** — `resources.md` files are learner-facing curated
  links ("watch this video"); `references.bib` is scholarly provenance ("this
  claim comes from here"). One work may legitimately appear in both.

## CI enforcement

- `scripts/check-indexes.R` check 8: every `[@key ...]` under `knowledge/`,
  `courses/`, `foundations/` (code blocks excluded) resolves to an entry in
  `knowledge/references.bib`, and every source record's `**Bib key:**` line
  matches both the .bib and the filename transform.
- `.github/workflows/license-check.yml`: every `knowledge/sources/*.md` carries a
  `**Source license:**` line.
