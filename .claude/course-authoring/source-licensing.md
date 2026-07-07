# Source licensing check

Goal: before source material is analyzed, quoted, or re-implemented into a course,
detect its license/copyright status and **flag anything that isn't clearly open for a
human to confirm.** This is a flag for a human, not legal advice — it never decides
compatibility, it stops and asks.

## When to run

At source intake, **before** you quote any formula, read any implementation to
rebuild it, or clone/analyze any repo:

- `create-course` Phase 1 (Intake) — for the paper/excerpt/concept/COURSE-REQUEST.
- `port-library` Phase P1 — for the library/paper/repo being rebuilt (highest risk:
  it re-implements real code). Resolve the upstream license *before* extracting the
  algorithm.

A concept with no external artifact (e.g. "teach me the Kalman filter" from general
knowledge) has no source to license — record `n/a — no external source` and proceed.

## Scope & enforcement

- **Foundations** (`foundations/*`) are paper-agnostic building blocks with no
  `syllabus.md`, so they have **no verdict slot — `n/a` by construction.** Nothing to
  record; CI does not check them.
- **How this is enforced:** the skill intake gate (a human confirms every FLAG) plus the
  CI backstop (`license-check.yml`) are the mechanism — deliberately **no programmatic
  intake hook** (decided for issue #1: a hook is unwarranted machinery for a single
  operator; the gate + CI cover it).

## How to detect, per input kind

- **`source-papers/*.pdf`** — check the first + last page and the page footers for a
  copyright line. `©` / "Copyright" / "All rights reserved" → FLAG. "Creative
  Commons" / "CC BY" / "open access" / "distributed under the terms of" → note the
  exact terms. arXiv/preprint → check the stated license (arXiv default license is
  **not** open reuse).
- **`source-materials/**` and any ported repo** — look, in this order, for:
  - a `LICENSE` / `LICENSE.md` / `COPYING` file,
  - SPDX headers in source files (`SPDX-License-Identifier: ...`),
  - a license field in the package metadata:
    - R: `License:` in `DESCRIPTION`
    - JS: `"license"` in `package.json`
    - Python: `license` / classifiers in `pyproject.toml` or `setup.cfg`
  - a "License" section in the README.
- **A `port-library` target given as a repo URL or library name** — resolve upstream
  *before* rebuilding:
  - GitHub: `gh api repos/{owner}/{repo}/license --jq .license.spdx_id`
  - CRAN: read the package `DESCRIPTION` `License:` field
  - PyPI: the project metadata `license` / classifiers

## Classify

- **OK — permissive / public domain** → proceed:
  MIT, BSD (2-/3-clause), Apache-2.0, ISC, Unlicense, CC0, public domain, CC-BY.
  (CC-BY and Apache-2.0 still require an **attribution note** — record it.)
- **FLAG — copyleft** → stop and confirm:
  GPL / LGPL / AGPL, MPL, CC-BY-SA. These are "open" but restrict how re-implemented
  or derived code may be reused, so per issue #12 they are a flag, not auto-OK.
- **FLAG — restrictive / all-rights-reserved / no license / unknown** → stop and
  confirm: proprietary, "all rights reserved", CC-BY-NC / CC-BY-ND (Creative Commons
  is not automatically open — NonCommercial and NoDerivatives restrict reuse; only
  CC0/CC-BY are in the OK list), any paper with a plain copyright line, or a repo
  with no license file at all (no license = default all-rights-reserved).

## Blocking rule

For any **FLAG**, do not proceed silently. Present a clear warning that names the file
and the detected license, e.g.:

> ⚠️ `source-papers/2024-smith-method.pdf` shows "© 2024 Elsevier — all rights
> reserved". This is not an open license. Re-implementing or quoting it into a
> published course may not be cleared. Confirm you have the right to use it before I
> continue.

Wait for explicit human confirmation before continuing.

## Record the verdict

So a cleared source is not re-prompted on the next build, write one line into the
course `syllabus.md`, right after the `**Source:**` line:

```markdown
**Source license:** <SPDX id or short description> — <OK | flagged, confirmed by human YYYY-MM-DD | n/a — no external source>
```

Examples:

```markdown
**Source license:** CC-BY-4.0 (open access) — OK; attribute the paper in resources.md
**Source license:** GPL-3.0 — flagged, confirmed by human 2026-07-03
**Source license:** n/a — no external source
```

A CI check (`.github/workflows/license-check.yml`) fails a PR whose course syllabus
is missing this line, so it cannot be silently skipped.
