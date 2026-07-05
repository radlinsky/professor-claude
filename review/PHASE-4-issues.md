# Phase 4 — The audit / quality-assurance loop: filed issues

Fable deep-dive review, Phase 4 of 5 (see `docs/fable-review-phase-4.md`). Filed 2026-07-04.

**Method:** 2 Opus sub-agents (checklist↔TEACHING coverage map + auditor blind spots; auditor
invocation trace across all skills/agents). Fable spot-checked every load-bearing quote against
the CURRENT files (course-auditor.md read in full; checklist check 3 + grep; the three skills'
review sections; TEACHING rule lines) before drafting — one sub-agent output carried a
verify-carefully harness flag, so verification was total. The single sharpest finding
(the "re-derives nothing" inversion) is Fable's own, made during spot-checking.

**ALREADY-FIXED reconciliation (per the phase brief):**
- **#10 (add-problems audit GATE)** — CONFIRMED FIXED live: add-problems:63-68 dispatch-when-available
  + :78-80 gate with the tool-unavailable precondition IN the gate. Nothing re-filed.
- **#12 (dispatch-when-available wording)** — CONFIRMED FIXED live in both bodies
  (create-course:312-315, update-course:163-165). The RESIDUE — both GATES still carry an
  unconditioned "(or self + disclosed)" that contradicts their fixed bodies — is new and filed as
  part of #92 (gates only; the bodies #12 fixed are untouched).
- Also checked live: #11 (GATE 4), #50 (Status checkboxes), #51/#76 (index scripts) — all intact,
  no interaction with this phase's issues.

**Labels:** `phase-4`, `mission:new-learner-course`, `mission:forkability` (on #91).

| # | Title | Core defect |
|---|---|---|
| [#89](https://github.com/radlinsky/professor-claude/issues/89) | Check 3 → practice answers | Check 3 is textually "Toy-example" arithmetic only; a wrong number in a practice hidden-answer callout, faded blank, or spot-the-error correct value passes every numbered check — the highest-stakes learner-facing gap |
| [#90](https://github.com/radlinsky/professor-claude/issues/90) | Checklist coverage gaps | Rules outside §Self-check are missed by BOTH the rubric and the auditor's sweep (Procedure step 4 sweeps §Self-check items only, with a 4-example parenthetical that reads as closed): interpretation-question, both-readings/plain-English-beside-formula, compute-both-ways match, forward link, first-use pronunciation; own-words prompt only weakly swept |
| [#91](https://github.com/radlinsky/professor-claude/issues/91) | Mechanical teaching-lint | Banned words (TEACHING:88) and fig-alt (TEACHING:177) are grep-shaped contract rules checked by nothing — new base-R lint script + CI wiring |
| [#92](https://github.com/radlinsky/professor-claude/issues/92) | Tighten audit gates | (a) GATE 8/GATE 6 allow unconditioned "self + disclosed" while their bodies forbid it (add-problems' gate has the right pattern); (b) create-course:313-314 describes the auditor as "it re-derives NOTHING" — the inverse of course-auditor.md:14's "re-derive everything yourself"; (c) single-pass accuracy for brand-new builds → add a second fresh-instance confirmation audit (new-build case only) + derive-first discipline in the auditor Procedure |
| [#93](https://github.com/radlinsky/professor-claude/issues/93) | On-demand audit routing | Standalone audits ("audit <module>") report a FAIL and strand it — no doc routes findings to update-course; auditor report gains a conditional routing line + CLAUDE.md row clause |
| [#94](https://github.com/radlinsky/professor-claude/issues/94) | resources.md into the audit | Auditor Inputs never name resources.md and no check covers resource-curation compliance — the only learner-facing content class with zero review (liveness stays a write-time WebFetch duty; auditor has no network) |

## Findings NOT turned into issues

1. **Trigger coverage is now solid.** All content paths end in an audit: create-course (Phase 8),
   update-course (all six change classes via Step 6 "every changed file"), add-problems (gate),
   port-library (inherits GATES 3-8), and both agents make dispatch mandatory (they always hold the
   Agent tool). The phase brief's "any path that ships unaudited content?" answer: only the
   resources.md class (#94) and the two structural classes below.
2. **equivalence reimplementations (.R) are validated numerically, not pedagogically** — by design:
   the harness IS their correctness gate, and their teaching-facing form (lesson listings/cells) IS
   audited. No issue.
3. **meta.dcf Concepts / README row prose ships unaudited** — structural metadata, validated for
   consistency by index-check; a wrong one-line summary is low-stakes and human-visible. Judgment
   call: not filed.
4. **Read-only integrity is belt-and-suspenders** (frontmatter, tools line without Write/Edit,
   prose down to "one-character typo"). Clean.
5. **Auditor output interface remains the strongest-specified contract in the repo**
   (severity-ordered defect table, minimal-fix column, PASS/FAIL token, "defect the caller can't
   locate and correct in one edit is a report bug"). Clean.
6. **Judgment-level §Self-check sweep** (pencil-followability via Read-first #3, Optional-marking,
   one-name-per-concept, honest analogies) is a deliberate rubric-vs-judgment split, kept — #90 only
   makes the sweep's wording exhaustive rather than promoting everything to numbered checks.
7. **One-module-per-sitting pacing (TEACHING:122) and anchors-reused-repo-wide (TEACHING:96)**
   remain unaudited — both are cross-file/pacing judgments with poor check ergonomics and low
   defect risk (templates handle pacing; anchors drift is caught at update-time by Step 2's impact
   scan). Owner's call whether to add; not filed.
8. **The four PR review bots already act as a de-facto second opinion at merge time** (Phase-2/3
   learnings show real catches) — noted as mitigation context for #92's second-pass design, not a
   substitute: bots see diffs at PR time, not the authoring-time definition of done.
9. **"warning: false"-style render silence, external-URL liveness in CI** — out of this phase's
   scope; liveness deliberately excluded from #94 with reasoning in the issue.

## Prior issues checked against

#10 ✓ fixed-live; #12 ✓ fixed-live (gate residue → #92); #11, #50, #51/#76 ✓ intact and untouched.
No prior issue re-filed; no overlap with phases 1-3 records (which describe pre-fix states).
