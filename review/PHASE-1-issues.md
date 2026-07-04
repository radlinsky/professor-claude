# Phase 1 — Authoring pipeline logic & `.claude` coherence: filed issues

Fable deep-dive review, Phase 1 of 5 (see `docs/fable-review-phase-1.md`). Filed 2026-07-04.

**Method:** 5 read-only sub-agents (2 Sonnet extraction/inventory, 3 Opus logic traces) gathered
evidence over every skill, agent, and course-authoring asset; Fable spot-checked every load-bearing
quote against the real files (12 targeted reads/greps) before drafting. Sub-agent claims that failed
spot-checks were dropped (see the not-issues list).

**Dedup:** `review/` was empty at Phase-1 start — these are the first review issues; no prior-phase
issues were touched, merged, or narrowed. (GitHub items #1–#8 predate this review and were not
review-generated.)

**Labels used:** `phase-1`, `mission:new-learner-course`, `mission:forkability`.

| # | Title | Labels |
|---|---|---|
| [#9](https://github.com/radlinsky/professor-claude/issues/9) | Resolve the {r} vs {webr} practice-starter contradiction (one engine owner) | phase-1, mission:new-learner-course |
| [#10](https://github.com/radlinsky/professor-claude/issues/10) | Close the add-problems quality loop: gates, explicit auditor dispatch, URL rule | phase-1, mission:new-learner-course |
| [#11](https://github.com/radlinsky/professor-claude/issues/11) | Make create-course GATE 4 actually equal the lesson-relevant TEACHING §Self-check | phase-1, mission:new-learner-course |
| [#12](https://github.com/radlinsky/professor-claude/issues/12) | Replace "Preferred:" auditor-dispatch framing with dispatch-when-available in create-course & update-course | phase-1, mission:new-learner-course |
| [#13](https://github.com/radlinsky/professor-claude/issues/13) | update-course: add missing "update links" classification, fix Step-4 guard/GATE contradiction, add Used-by rule, de-restate TEACHING rules | phase-1, mission:new-learner-course |
| [#14](https://github.com/radlinsky/professor-claude/issues/14) | CLAUDE.md: complete the repo map and stop paraphrasing the golden order | phase-1, mission:new-learner-course, mission:forkability |
| [#15](https://github.com/radlinsky/professor-claude/issues/15) | Make skill routing decidable: port-vs-create rule, add-vs-improve problems, skill-vs-agent criterion | phase-1, mission:new-learner-course |
| [#16](https://github.com/radlinsky/professor-claude/issues/16) | port-library: make P4's create-course execution explicit, align fixture-meta line, give equivalence/README's target count an owner | phase-1, mission:new-learner-course, mission:forkability |
| [#17](https://github.com/radlinsky/professor-claude/issues/17) | Remove the format: html line from course-structure.md's roadmap example | phase-1, mission:new-learner-course |
| [#18](https://github.com/radlinsky/professor-claude/issues/18) | Add the "this file is an example — replace it when you fork" note to learner-profile.md | phase-1, mission:forkability |
| [#19](https://github.com/radlinsky/professor-claude/issues/19) | TEACHING.md: state explicitly which golden-order steps are per-lesson vs per-concept | phase-1, mission:new-learner-course |

Severity order as filed: #9 and #10 highest (a live five-file contradiction on the practice-starter
engine, and a quality loop that never independently closes), then routing/gate completeness
(#15, #11, #13, #14, #16, #12), then surgical fixes (#17, #18, #19).

**Non-overlap map:** #9 owns all starter-ENGINE wording (incl. problem-creator.md:37); #10 owns
add-problems/problem-creator gates+dispatch; #11 owns create-course GATE 4 + Phase 5; #12 owns the
two "Preferred:" dispatch paragraphs; #13 owns update-course Steps 1/3/4; #14 owns CLAUDE.md
map+paraphrase (NOT the decision table); #15 owns the decision table + all four skill frontmatters'
tie-breakers + create-course Phase-1 redirect; #16 owns port-library body P1–P4 + equivalence/README;
#17–#19 are single-file surgical edits.

---

## Issue bodies (as filed)

### #9 — Resolve the {r} vs {webr} practice-starter contradiction (one engine owner)

**Problem:** Five pipeline docs disagree on what engine a practice/check-yourself **starter chunk** uses.

Saying `{r}`:
- `.claude/course-authoring/problem-authoring.md:55-57` — "MUST open with a small `{r}` starter chunk" — and its example at :66-71 (```` ```{r p2-starter} ````). The file contains **zero** occurrences of "webr".
- `.claude/course-authoring/content-review-checklist.md:53` — check 5: "must open with a `{r}` starter chunk".
- `.claude/agents/problem-creator.md:37` — "opens with a copy-able `{r}` starter chunk".

Saying `{webr}`:
- `.claude/course-authoring/interactive-webr.md:61` — starter row: `{webr}`, `autorun: false`.
- `.claude/skills/add-problems/SKILL.md:43-44` — "write each starter as a live `{webr}` cell (`#| autorun: false`)".
- `.claude/skills/create-course/SKILL.md:153-155` — "any solve-it starters are live `{webr}` cells".
- `content-review-checklist.md:106-109` — check 12: "A practice starter left as `{r}` … is a defect".

**The checklist self-contradicts (check 5 vs check 12).** Both `add-problems:15-17` and `problem-creator:22` call problem-authoring.md the "single source of truth" — and it prescribes the engine the rest of the pipeline (and the auditor) treats as a defect.

**Why it matters (mission 1):** a course built by a model that read problem-authoring.md / check 5 last ships non-interactive starters; the auditor then flags them under check 12 — or worse, passes them under check 5.

**Exact scope:** problem-authoring.md §"Copy-able data" (engine statement + example → `{webr}` `#| autorun: false`, one ownership sentence pointing at interactive-webr.md, label paragraph aligned with add-problems:52-53); checklist check 5 (drop engine word, point at check 12); problem-creator.md:37 (done-item → live `{webr}` starter, baked `{r}` answer).

**Acceptance:** no doc states starters are `{r}`; example starter is `{webr}` data-only; checks 5/12 non-conflicting; interactive-webr.md named as engine owner exactly once; exemptions and answer-callout rules unchanged.

**Out of scope:** add-problems gates & dispatch (#10); checklist coverage vs TEACHING §Self-check (Phase 4); course content.
**Implementer:** Sonnet, no sub-agents.

### #10 — Close the add-problems quality loop: gates, explicit auditor dispatch, URL rule

**Problem:** `course-auditor.md:5-6` claims create-course/update-course/**add-problems** "final phases dispatch it", but neither `add-problems/SKILL.md` nor `problem-creator.md` contains any dispatch instruction (grep = 0 hits). add-problems is the only pipeline skill with **zero GATE checkboxes** (siblings have 8/6/4); its verify step (:57-62) relies transitively on the checklist header (:18-19) for the fix→re-render→re-check cycle. No URL-verification rule (contrast update-course:130-131). Minor: :37 "its prerequisites" unenumerable.

**Why it matters (mission 1):** problems are authored, rendered, and reviewed by the same author with no blocking checklist and no fresh-eyes pass, while the auditor's description advertises a handoff that never happens.

**Exact scope:** add-problems/SKILL.md — final GATE checklist (render green / review clean / cycle until clean / indexes untouched); step-5 dispatch rule (checklist:11-13 semantics); step-5 URL rule (resource-curation.md); step-2 "prerequisites" defined as "the modules its warm-up and syllabus/roadmap declare". problem-creator.md — done-item "course-auditor dispatched and reporting PASS"; "What you do" names the dispatch.

**Acceptance:** GATE present; dispatch-when-available in both files, self-review fallback-only+disclosed; course-auditor.md:5-6 claim now true with no edit to it; URL rule present; "Do NOT touch indexes" rule unchanged.

**Out of scope:** starter-engine wording (#9); "Preferred:" wording in the two big skills (#12); checklist content (Phase 4).
**Implementer:** Sonnet, no sub-agents.

### #11 — Make create-course GATE 4 actually equal the lesson-relevant TEACHING §Self-check

**Problem:** `create-course/SKILL.md:184-185` introduces GATE 4 as "the lesson-relevant items of `TEACHING.md` §Self-check, i.e.: …" but omits five lesson-relevant §Self-check items (TEACHING.md:203-220): pencil-followability (:205), terms defined at first use (:211), the own-words prompt (:214), Optional-marking (:219), quoted numbers re-verified (:220). Adjacent: Phase 5 forbids re-deriving problem-authoring rules (:200-203) then re-lists the ramp stage names (:206-212).

**Why it matters (mission 1):** GATE 4 is the per-lesson quality gate; an incomplete gate claiming completeness ("i.e.") licenses skipping.

**Exact scope:** create-course/SKILL.md only — GATE 4 covers ALL lesson-relevant §Self-check items (keep `set.seed(42)`); "i.e." only if complete, else "at minimum" + pointer; Phase 5 ramp enumeration → single pointer to problem-authoring.md.

**Acceptance:** every applicable TEACHING:205-220 item maps to a GATE 4 checkbox (ramp stays GATE 5); no under-claiming; no stage-name list in Phase 5; no other phase/gate text changed.

**Out of scope:** Phase 8 dispatch wording (#12); content-review-checklist.md (Phase 4); TEACHING.md (#19 touches a different section).
**Implementer:** Opus, no sub-agents.

### #12 — Replace "Preferred:" auditor-dispatch framing with dispatch-when-available

**Problem:** create-course:280 and update-course:143 frame the independent audit as "**Preferred:**" with self-review fallbacks (:285-288, :145-147), while checklist:11-13 requires dispatch "instead of self-reviewing" when a Task/Agent tool exists. A literal skill-follower with the tool may self-review and still pass GATE 8 / GATE 6.

**Why it matters (mission 1):** independence is the audit's entire value (course-auditor.md:12-14).

**Exact scope:** create-course Phase 8 (:280-288) + update-course Step 6 (:143-147) only; reword to checklist semantics; keep fix→re-render→re-dispatch loops verbatim; GATE items may keep "(auditor, or self + disclosed)".

**Acceptance:** no "Preferred" for the dispatch decision; wording matches checklist:11-13 semantics; loops/gates otherwise byte-identical.

**Out of scope:** add-problems/problem-creator (#10); checklist:11-13; course-auditor.md.
**Implementer:** Sonnet, no sub-agents.

### #13 — update-course: classifier, Step-4 guard/GATE contradiction, Used-by rule, de-restatement

**Problem:** (1) description (:4-9) advertises 7 change types but Step 1.3 (:33-40) classifies 5 — "update links" has no bucket, "restructure" unadvertised (retrofit IS handled at :36-37). (2) Step 4 header (:107) "Only when files were added/renamed/removed:" contradicts GATE 4 (:118-119) "skip-checked even for edits that 'shouldn't' need it". (3) Step 4 (:112-114) never mentions the foundations *Used by* column (CLAUDE.md hard rule; create-course:265-266 has it). (4) :92 restates TEACHING.md:199 verbatim; :96 restates the Optional rule minus its anchor — TEACHING.md:3-6 forbids restating.

**Why it matters (mission 1):** the only sanctioned change path mis-routes requests, can skip registration checks, and silently rots the foundations index.

**Exact scope:** update-course/SKILL.md only — add "link/reference update" class + advertise restructure; Step 4 header → "Check on every change; act when files were added/renamed/removed" + *Used by* bullet; :92/:96 → pointers to TEACHING §Revising / §Depth control.

**Acceptance:** description↔classifier bijection; header/gate agree; *Used by* rule present and consistent with create-course:265-266; TEACHING:199 sentence no longer verbatim here; GATE structure otherwise unchanged.

**Out of scope:** Step 6 dispatch wording (#12); CLAUDE.md table row (#15); TEACHING.md.
**Implementer:** Sonnet, no sub-agents.

### #14 — CLAUDE.md: complete the repo map and stop paraphrasing the golden order

**Problem:** (a) repo-map omits `.claude/skills/port-library/` (in the decision table but not the tree), `equivalence/` (never mentioned anywhere despite the port-library row citing "equivalence fixtures"), `.github/workflows/`, `docs/` (only webr-decision.md cited); course-authoring gloss omits resource-curation.md and source-licensing.md. (b) The golden-order parenthetical lists 10 stops; TEACHING.md:23-61 has 11 — step 11 "Where this goes next" silently dropped, violating CLAUDE.md's own "Do not restate its rules elsewhere — link to it."

**Why it matters (missions 1+2):** CLAUDE.md is the first file a forker or fresh model reads.

**Exact scope:** CLAUDE.md only — add the four missing map entries + extend the course-authoring parenthetical; replace the golden-order enumeration with a pointer ("the 11-step lesson spine defined in TEACHING.md") or complete it (pointer preferred).

**Acceptance:** every skill-referenced top-level dir in the map; all four skills in the tree; no incomplete golden-order enumeration remains; decision-table rows byte-unchanged (#15 owns them).

**Out of scope:** the decision table (#15); TEACHING.md; README.md.
**Implementer:** Sonnet, no sub-agents.

### #15 — Make skill routing decidable

**Problem:** (1) Formulas-only input routable to BOTH port-library ("formulas-only" frontmatter :4-5) and create-course (port's own tiebreaker :11-12 "NO real implementation to validate against"); the real rule — any validation reference (code / reported numbers / closed form, per equivalence/README.md:33-44 tiers) → port — is stated nowhere; create-course never mentions libraries/repos, so no redirect happens. (2) "Improve the practice problems" matches add-problems triggers but is update-course work; no add-vs-change tie-breaker exists. (3) create-course skill vs course-creator agent: the one-shot/autonomous criterion (course-creator.md:12) is absent from CLAUDE.md's table.

**Why it matters (mission 1):** each ambiguity sends a whole course down the wrong pipeline (no equivalence proof, or no impact scan).

**Exact scope:** CLAUDE.md decision table (one tie-breaker clause per affected row); port-library frontmatter :11-12 (validation-reference rule); create-course frontmatter + Phase 1 (redirect); add-problems + update-course frontmatter (mirror tie-breaker).

**Acceptance:** for paper+code / formulas-only paper / R package / repo w-o data / bare concept, exactly one skill derivable from table alone AND frontmatters alone; "formulas-only" never appears without the rule beside it; create-course Phase-1 redirect present, GATE 1 otherwise unchanged; add-vs-update tie-breaker identically worded everywhere.

**Out of scope:** CLAUDE.md map/paraphrase (#14); port-library body (#16); update-course Step 1.3 buckets (#13).
**Implementer:** Opus, no sub-agents.

### #16 — port-library: explicit P4 execution, fixture-meta alignment, README count owner

**Problem:** (1) P4 (:129-132) "Run create-course phases 3–8 … Apply these port-specific deltas" — the run instruction is prose before five eye-catching delta bullets; nothing forces opening create-course/SKILL.md (GATE P4 :153 names inherited gates but not the read). (2) :107-108 fixture `meta` list is a subset of the owning spec equivalence/README.md:60-62 (missing tolerance/seed/generator-path). (3) equivalence/README.md:67 hardcodes "# 4/4 targets should pass"; P3 never says to update the README — the count goes stale with the first port; no owner.

**Why it matters (missions 1+2):** skipping the inherited pipeline drops render/audit/golden-order enforcement; a stale README misleads the forker.

**Exact scope:** port-library/SKILL.md — P4 explicit first step ("Open create-course/SKILL.md and execute phases 3–8 with their GATEs; deltas modify, don't replace"); meta line defers to README §Fixture format; P3 step 3 gains "update equivalence/README (count + tier examples)"; optional: tier bullets cite README §Validation tiers, static-fallback delta cites interactive-webr.md without restating. equivalence/README.md:67 → count-free comment + one §Add-a-new-target line.

**Acceptance:** P4 first line imperative; meta text defers to/matches README; after change, a 5th port leaves no stale count (grep "4/4" = 0); GATE checkbox structure unchanged.

**Out of scope:** port-library frontmatter/tiebreaker (#15); create-course phases (#11/#12); harness code.
**Implementer:** Opus, no sub-agents.

### #17 — Remove the format: html line from course-structure.md's roadmap example

**Problem:** course-structure.md:182-186 — the prescribed `00-roadmap.qmd` YAML example contains `format: html`, contradicting the same file's rule at :121-126 and CLAUDE.md's "Never give a page its own `format:`". Only `format:` occurrence in any course-authoring file; no real page has copied it yet (grep `^format:` over courses/foundations qmd = 0).

**Why it matters (mission 1):** this is the spec authors copy verbatim.

**Exact scope:** delete the `format: html` line from the example (keep `title:`); no other edits.
**Acceptance:** grep "format:" in the file matches only the :121-126 rule prose; example still valid YAML.
**Out of scope:** everything else; real course pages.
**Implementer:** Sonnet, no sub-agents.

### #18 — Add the "example — replace when you fork" note to learner-profile.md

**Problem:** CLAUDE.md promises the profile "ships as an example — forkers edit it", but learner-profile.md contains zero mention of forking/example/replacement (case-insensitive grep = 0). Every skill/agent sends readers there directly; a forker gets no signal the file is meant to be overwritten.

**Why it matters (mission 2):** the one file every fork MUST change doesn't say so.

**Exact scope:** add a 2-3 line note at top: "This file describes ONE specific learner and ships as an example. Forking this repo? Replace everything below with YOUR learner — see README §Make it yours. Every skill and agent teaches to whoever is described here." Nothing else changes.
**Acceptance:** note ≤4 lines, mentions README §Make it yours; profile content otherwise untouched; CLAUDE.md's claim now true of the file.
**Out of scope:** README.md, CLAUDE.md.
**Implementer:** Sonnet, no sub-agents.

### #19 — TEACHING.md: per-lesson vs per-concept step scoping

**Problem:** TEACHING.md:25-26 — "Within it, every new CONCEPT gets steps 2–7 in order" is the only signal that steps 1, 8-11 are once-per-lesson while 2-7 repeat per concept. A weak model can misread either way (repeat warm-up/recap per concept, or not repeat 2-7 for a second concept). Multi-concept lessons are explicitly allowed (create-course:85 "1–3 tightly related concepts each").

**Exact scope:** add one sentence after :26: "Steps 1 and 8–11 appear **once per lesson**; steps 2–7 form a sub-spine repeated **for each new concept** the lesson introduces." Touch nothing else.
**Acceptance:** one added sentence; steps byte-identical otherwise; the distinction explicit.
**Out of scope:** the 11 steps; all other sections; lesson-template.qmd (already correct).
**Implementer:** Sonnet, no sub-agents (exact wording supplied).

---

## Findings NOT turned into issues

1. **Checklist coverage gaps vs TEACHING §Self-check** (no checklist item for own-words prompt, Optional-marking, terms-defined-at-first-use, pencil-followability; auditor never audits resource-curation compliance) — audit-depth territory, **deferred to Phase 4**.
2. **lesson-template.qmd renames 4 golden-order headings** + adds a "Where we're going" orientation section — content/order match TEACHING 1:1; template = implementation; works as designed.
3. **practice-template splits ramp stage 3 into Problems 3+4** — presentational; stage names verbatim-consistent across all three files.
4. **"Aim for 3–8 modules" vs hard GATE 2; resource-curation "Aim for 2–4" vs GATE 6 "minimum 2"** — soft phrasing + hard gate coexist; numbers agree.
5. **"Task/Agent tool" phrasing** — compound covers both harness namings; fine.
6. **TEACHING.md deliberate judgment latitude** ("a picture when one exists" :44; "when compression buys nothing" :79-80; no worked example for "say where the analogy breaks" :97; "what the course goal actually needs" :166-167) — arguably intentional author latitude in the contract; owner's call whether to tighten.
7. **update-course:78-80 already summarizes create-course Phase 4-6 inline** — sub-agent claimed otherwise; spot-check disproved.
8. **port-library "set the knob" sentence** — names both dials explicitly; sub-agent overstated.
9. **Generator language ellipsis "{R,py,c,…}"** — matches README's own ellipsis; check side is R+jsonlite regardless.
10. **source-materials/ has no live COURSE-REQUEST.md example** — pattern reference, not a broken link; example-coverage belongs to a later phase.
11. **course-creator.md:30 inlines the 8 phase names** — cosmetic duplication, currently exact; the agent already forbids substituting summaries.
12. **2–4 "teachable pieces" (port P2) vs 3–8 modules** — pieces feed create-course Phase 2, which adds foundation modules; coherent.
