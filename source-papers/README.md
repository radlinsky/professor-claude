# Source papers

Drop academic papers or textbooks (PDFs) here, then ask Claude to build a course
from one:

> Create a course for the methods section of `source-papers/2024-smith-mixedmodels.pdf`

or to extract it into the knowledge base without building a course:

> Extract `source-papers/2018-boyd-vmls.pdf` into the knowledge base

(Extraction is resumable — a big textbook is ingested chapter by chapter across
sessions, and "resume extraction of 2018-boyd-vmls" picks up where it left off.
Afterwards, "run a gap check" reports which existing courses could use the new
knowledge.)

## Naming convention

`YYYY-firstauthor-shortname.pdf` — e.g. `2024-smith-mixedmodels.pdf`,
`2019-athey-causalforests.pdf`.

## Tips

- You can point Claude at a specific section ("just the hierarchical model in
  section 3.2") — smaller targets make tighter courses.
- No PDF? A pasted excerpt, a link, or just the method's name works too.
