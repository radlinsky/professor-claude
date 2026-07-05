# Content-accuracy review checklist

Run this AFTER a course renders green. Rendering proves the code executes and the
Quarto is well-formed; it proves **nothing** about whether the math and notation are
correct. These defect classes render perfectly and have all escaped the pipeline
before — that is why this pass exists.

**Read with fresh eyes.** The author (you, three phases ago) already believes the
content is right; that belief is exactly what let these bugs through. Re-read each
new `lesson.qmd` and `practice.qmd` as if you had never seen it, checking only the
items below. If a Task/Agent tool is available, dispatch the **`course-auditor`
agent** (`.claude/agents/course-auditor.md`) instead of self-reviewing —
independence catches what self-review misses.

(This file is the machine-checkable rubric; the contract behind it is root
`TEACHING.md`, whose §Self-check these items operationalize.)

For every new lesson and practice file, verify each item. A "no" is a defect: fix it,
re-render, and re-check.

## The checks

1. **Notation claims match their own examples.**
   Any sentence that states a *general rule* about notation must be true of every
   example it cites in the same breath.
   - Seed bug: "Latin letters with bars/hats ($\bar{x}$, $s$)" — but $s$ has neither
     bar nor hat.
   - Same class: calling $\hat{\beta}$ a "Latin" quantity — $\beta$ is Greek.
   - Check the Greek-vs-Latin / bar / hat convention paragraph especially: it is the
     easiest place to overstate a rule.

2. **Every symbol in a formula has a pronunciation-table row in the SAME lesson.**
   Scan each `$...$` and `$$...$$` block; list every distinct symbol; confirm each
   one appears in that lesson's "How to read the symbols" table. Subscripted twins
   count: if $y_i$ appears in a formula, $y_i$ (not just $\bar{y}$) needs a row.
   Inheriting a symbol from a prerequisite lesson is NOT enough — the contract is
   "decoded in the same lesson." Also confirm the symbol's FIRST prose use is decoded
   there — its pronunciation given inline or by an immediate pointer to the table — not
   dropped into a sentence and left to the table alone.

3. **Hand-worked arithmetic matches everywhere — lesson AND practice.**
   Re-compute every hand-worked number in the target file yourself, then confirm
   every place it appears agrees. In the lesson: the toy example's prose number, the
   R chunk's commented result, and any later reference to it. In `practice.qmd`: every
   collapsed worked answer (its prose numbers vs the baked chunk's output vs the
   problem statement's data), every faded-example blank's correct value, and the
   spot-the-error solution's intended-correct values (the numbers the learner should
   land on once the planted mistake is removed — check 11 owns the mistake's LOCATION,
   this check owns the surrounding arithmetic). A wrong number in a hidden answer
   callout is the highest-stakes defect: it is the learner's only signal for grading
   their own pencil work. Watch $n$ vs $n-1$ divisors, sign of deviations, and
   squared-vs-summed order.

4. **No derivation step is asserted without teaching its trick.**
   Every algebra/calculus move (factor, expand, chain rule, "set derivative to 0",
   log rules) is either taught earlier or annotated inline on its own line. A line
   that "follows" without a named reason is a defect. Also confirm the annotation
   actually describes the transition it sits under — it must not quote a fragment
   that drops a term the real step keeps.

5. **Every data-bearing question ships copy-able starter code.**
   Any problem or "check yourself" question that gives the learner specific data to
   compute with (a vector, function, or data frame) must open with a copy-able starter
   chunk defining that data, placed before the answer callout — by-hand problems
   included. A question that states data only in prose or math (e.g. "$x = (3,1,4,2)$")
   with no copy-able chunk is a defect. Exempt: built-in datasets (`mtcars`) and
   scalar-only prompts. (Engine — live `{webr}` vs baked `{r}` — is governed by check
   12 and `interactive-webr.md`.)

6. **"Getting a feel for it" builds a model, not filler.**
   The intuition section must contain BOTH (a) a genuine analogy or mental picture
   tying the concept to something already understood, AND (b) a why-it's-constructed-
   this-way reason (why square, why multiply, why this divisor). A section that only
   restates the formula in words ("we add the squared deviations") is a defect — it
   renders fine and reads plausibly, which is exactly why it slips through. Also check
   it introduces NO formal notation (that belongs to later sections).

7. **Warm-up questions retrieve; they don't re-read.**
   Each lesson's Warm-up has 2–3 questions that make the learner PRODUCE something
   (a value, a pronunciation, a one-line explanation) from earlier material, each
   answer in a collapsed callout with a backlink to where it was taught. Reaching
   back to only one source when two exist, prompts answerable without recall
   ("remember that variance measures spread?"), or missing backlinks are defects.

8. **Predict-then-run prompts exist and are answerable.**
   The lesson has 2–3 PREDICT prompts (Explore chunks and/or problems) asking for a
   committed guess BEFORE running, and each is checkable by the very next run. A
   "prediction" whose answer was already printed above it is a defect.

9. **Common traps refute with numbers.**
   Each trap states a tempting wrong belief and defeats it using the lesson's own
   numbers (or a tiny chunk) — not just "be careful about X". A traps section that
   warns without demonstrating is a defect. One lesson trap should reappear as the
   practice set's spot-the-error problem.

10. **The recap is can-dos plus a mastery rule.**
    "What you can now do" lists 3–5 abilities (verbs — compute, decode, explain),
    not topic nouns, and ends with the mastery rule naming exactly where to revisit.
    Topic-noun bullets ("covariance", "the SSE") are defects.

11. **The practice ramp is complete and honest.**
    Per `problem-authoring.md`: P1 = confidence rep of the toy example; a faded
    worked example with the CORE step blanked (not bookkeeping); one spot-the-error
    with exactly one real mistake (verify the mistake is where the answer says);
    one labeled interleaved problem when an earlier module exists; a transfer or
    clearly-labeled cliffhanger last. Capstone sets instead: every course module
    represented, mixed order, no module labels.

12. **The interactive/static split is correct and wired.**
    Contract: `.claude/course-authoring/interactive-webr.md`. Check each:
    - A file with any ```` ```{webr} ```` cell has BOTH `engine: knitr` in its header
      and the `{{< include /_extensions/r-wasm/live/_knitr.qmd >}}` line once after it;
      a file with none has neither. A `{webr}` cell without the include (or the include
      in a file with no live cells) is a defect.
    - No content file reintroduces a per-file `format:` (it drops the page out of the
      shared live-html theme).
    - Cells the learner TWEAKS or SOLVES are `{webr}` (practice/check-yourself starters
      especially); hidden setup, read-only listings, and worked ANSWER chunks stay
      baked `{r}`. A practice starter left as `{r}` (not solvable in-browser), or an
      answer made `{webr}` (its result hidden until the learner runs it), is a defect.
    - Any code needing a package WebAssembly can't run (`docs/webr-decision.md` §3) is a
      baked `{r}` chunk under the "runs on your machine, not here" callout — never a
      `{webr}` cell that would silently fail in the browser.
    - PORTED course only (built with the port-library skill, e.g. a from-scratch method
      validated against a real library): the module that completes the reimplementation
      has a live `{webr}` cell re-running it against the FROZEN reference numbers
      (embedded inline) and states which validation tier proved the match (full /
      partial / fallback); the real reference it was checked against is shown static
      under the "runs on your machine" callout, never as a `{webr}` cell. A missing
      self-check cell, an unstated tier, or a non-wasm reference left live is a defect.
    (You cannot execute `{webr}` cells while auditing — that is a manual/CI check. Audit
    the WIRING and the split, not in-browser execution.)

13. **The source-license verdict is present and honest.**
    The `syllabus.md` carries a `**Source license:**` line in the
    `.claude/course-authoring/source-licensing.md` format. Confirm the verdict actually
    fits the source (a paper with a plain `©` line or a repo with no LICENSE is FLAG, not
    `n/a`), and that any **flagged / copyleft / restrictive** verdict carries the
    `confirmed by human YYYY-MM-DD` token — a flag without it is a defect (and CI fails
    it). A missing line, or one that overstates a restricted source as OK, is a defect.

14. **Declared prerequisites exist and are honest.**
    Every prerequisite the `syllabus.md` / `00-roadmap.qmd` names — foundation
    modules AND prerequisite courses — resolves to a real file (`ls` / link check)
    and is actually linked, not named in prose only. If a lesson leans on an anchor
    from another course (reuses its picture, notation, or result without
    re-deriving it), that course must appear in the syllabus's *Before you start:
    course(s) this one builds on* section and as a `:::priorcourse` node in the
    roadmap. A silently-assumed course, or a declared prerequisite whose link
    dangles, is a defect.

15. **Check-yourself prompts for own words, and practice tests interpretation.**
    The lesson's Check-yourself contains at least one prompt that makes the learner
    explain a concept in their OWN words (not restate a definition, not recompute a
    number), per `TEACHING.md` §Self-check. AND at least one practice question tests
    INTERPRETATION over computation — asking what a result MEANS, whether a claim
    holds, or which of two setups behaves a certain way, rather than "compute X". A
    Check-yourself with only recompute/recall prompts, or a practice set that is
    all arithmetic with no interpretation item, is a defect.

16. **Every formula is restated in plain English, and the formal version gives both readings.**
    Each displayed formula (`$$...$$`) has a plain-English restatement beside it —
    one sentence saying what it does in words, not just its symbol decode. AND "The
    formal version" section gives BOTH readings of its result: the symbol-by-symbol
    walk AND the everyday-words paraphrase. A displayed formula with no prose
    restatement, or a formal version that decodes symbols without the plain-words
    reading, is a defect.

17. **"Explore it" computes the concept both ways and shows they agree.**
    The Explore section computes the concept from the raw formula (built up by hand)
    AND via the built-in function, and shows the two results MATCH (an explicit
    comparison — same printed value, an `all.equal`, or a side-by-side). Computing it
    only one way, or showing both without demonstrating they agree, is a defect.
    (Checks 8 and 12 cover the predict-then-run prompt and the live/static wiring;
    this check owns the from-scratch-vs-built-in agreement.)

18. **"Where this goes next" exists with a resolving forward link.**
    The lesson ends with a "Where this goes next" section (golden step 11) that
    points forward — to the next module, a later course, or a concrete practice
    pointer — and that link/pointer resolves to a real target. A missing section, or
    a forward pointer that names nothing the learner can actually go to, is a defect.

19. **Resources are curated per `resource-curation.md`.**
    Each module's `resources.md` has 2–4 annotated entries or an explicit TODO
    sentinel; every entry carries the prescribed annotation (what it is / why it
    earns its place / when to use it); no bare unannotated URLs. You cannot verify
    liveness (no network) — check FORM and the verified-on claim, and flag any entry
    missing one.

## Reporting

List each defect as: file path, exact offending quote, why it is wrong, minimal fix.
Fix all of them, re-render, then re-run this checklist on the fixed files. The course
is not done until this pass finds nothing.
