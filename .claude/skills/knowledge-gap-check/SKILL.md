---
name: knowledge-gap-check
description: >
  Report-only audit of existing foundations and courses against the knowledge base
  (knowledge/): where teaching material contradicts a cited source, misses a concept
  the KB now covers, lacks a misconception/trap the KB records, could borrow a better
  analogy, or could mine fresh practice material. Use when the user says "gap check",
  "audit the courses against the knowledge base", "what should we improve now that
  <source> is extracted", or after an extract-knowledge run. Tie-breaker: this skill
  WRITES ONE REPORT FILE AND CHANGES NOTHING ELSE — the fixes it recommends route to
  update-course (content changes), add-problems (new problems), or create-course
  (new courses); grading material against the teaching contract is the
  course-auditor agent, not this.
---

# knowledge-gap-check

You are comparing what the repo TEACHES against what the knowledge base KNOWS, and
reporting the differences for the user to act on. **Before doing anything else,
read, in this order:** `.claude/course-authoring/knowledge-base.md` (how the KB is
organized), `.claude/course-authoring/content-review-checklist.md` (phrase findings
in its vocabulary where one of its checks applies), `foundations/README.md` and
`courses/README.md` (what exists and what it claims to cover).

**The contract: you write exactly ONE new file — the report — and modify nothing.**
No fixes, no "quick wins", no index regeneration, not even a typo. Every finding
names the skill that would fix it; the user decides.

## Procedure

### Step 1 — Scope

Whole repo by default; a single course or foundation module if the user names one.
If the KB is empty (no `knowledge/concepts/` pages), write the report file with
zero findings and an explicit "KB empty — nothing to audit against" status line,
then finish (skip Steps 2–3).

### Step 2 — Coverage diff (what the KB knows that nothing teaches)

1. List every `knowledge/concepts/` page. For each, look for teaching coverage:
   the same slug or concept in `foundations/README.md`'s Concepts column, a course
   module that teaches it (syllabi + module titles), or an explicit lesson section.
2. A KB concept with NO coverage anywhere is a finding only when it plausibly
   serves this learner's goals (the KB may legitimately know things no course
   needs yet) — class **missing coverage**, fixer `create-course` (a course-sized
   hole) or `update-course` (a module-sized hole in an existing course).
3. The reverse — a lesson concept absent from the KB — is NOT a finding. The KB is
   incremental; absence means "not extracted yet", not "wrong".

### Step 3 — Content diff (what the KB contradicts or improves)

For each lesson/practice page in scope whose topic has a KB concept page, compare:

- **Contradiction** — the lesson asserts something a cited KB claim refutes. Quote
  BOTH sides (lesson `path:line`, KB claim with its `[@key, pinpoint]`). Highest
  priority. Fixer: `update-course`. (If you suspect the KB side is wrong, check its
  citation; if the citation doesn't support the claim, report a KB defect finding
  instead — fixer `extract-knowledge` re-verification.)
- **Missing trap** — a misconception the KB records for this concept that the
  lesson's Common-traps section doesn't cover. Fixer: `update-course`.
- **Wording improvement** — the KB records a markedly better analogy, intuition,
  or "how the field talks" phrasing than the lesson uses. Only markedly better —
  taste is not a finding. Fixer: `update-course`.
- **New practice material** — a KB worked result, dataset, or canonical example
  usable as fresh problems for an existing module. Fixer: `add-problems`.

### Step 4 — Report

Write ONE file: `docs/gap-reports/YYYY-MM-DD-<scope>.md` (`<scope>` = `repo` or the
course/foundation slug; create the directory if needed). If the path already exists
(same-day rerun), append a `-N` suffix (`-2`, `-3`, …) — never overwrite a previous
report. Format:

```markdown
# Knowledge gap report — <scope> — YYYY-MM-DD

KB state: <n> concepts, <n> sources, <n> glossary terms.
Scope: <what was compared>.

| # | Priority | Class | Finding | Evidence | Fixer | Files affected |
|---|---|---|---|---|---|---|
```

- Priority order: contradiction > missing coverage > missing trap > wording >
  practice. Number findings in that order.
- Evidence: for content findings, both quotes (lesson `path:line` + KB citation);
  for coverage findings, the KB page and where coverage was looked for.
- Fixer: exactly one of `update-course` / `add-problems` / `create-course` /
  `extract-knowledge`.

End with a **Reviewed, not findings** section: judgment calls you considered and
rejected (e.g. "lesson simplifies X — acceptable at this learner's level"), so the
next run doesn't re-litigate them.

### Step 5 — Deliver

Tell the user: report path, finding counts by class, and the top finding. Do not
offer to apply fixes in the same breath — the user picks.

**GATE (definition of done):** ☐ The report file is the ONLY thing created and
nothing was modified (`git status` shows exactly one untracked file). ☐ Every
finding carries evidence from both sides where applicable. ☐ Every finding names
exactly one fixer skill. ☐ Priority ordering respected. ☐ Reviewed-not-findings
section present.
