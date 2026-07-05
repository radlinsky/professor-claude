# Resource curation procedure

Goal: give the learner 2–4 REAL, working, well-matched external resources per module
(minimum 2 unless the TODO sentinel applies; videos preferred, then
posts/interactive demos). A dead or hallucinated link destroys trust in the whole
course. Follow this procedure exactly. (Audited by content-review-checklist check 19.)

## Non-negotiable rules

1. **Every URL must be WebFetch-verified in the current session** before it is
   written into any file. Verified means: the fetch succeeded AND the returned
   content is genuinely about the module's topic. This includes candidate links
   inherited from a `COURSE-REQUEST.md` — they were verified when the request was
   written, not now.
2. **Never write a URL from memory.** Not even "obviously stable" ones. Models
   hallucinate YouTube IDs constantly.
3. If WebSearch/WebFetch are unavailable or blocked, write exactly
   `TODO: resources pending — search tools unavailable` in that section. A TODO is
   honest; an unverified link is not.
4. Skip paywalled resources and anything requiring signup to view.

## Preferred sources, in order

1. **StatQuest (Josh Starmer)** — best match for this learner's style (plain
   English, small numeric examples) for statistics/ML topics.
2. **3Blue1Brown (Grant Sanderson)** — best for visual intuition: linear algebra
   ("Essence of Linear Algebra"), calculus ("Essence of Calculus"), probability.
3. **Khan Academy** — best for practice-oriented refreshers of school-level
   material (algebra tricks, derivative mechanics, basic probability).
4. Good written/interactive sources: *Seeing Theory* (seeing-theory.brown.edu),
   *setosa.io* visual explanations, R-focused posts (e.g., on r-bloggers), and
   free textbook chapters (OpenIntro Statistics, *Introduction to Statistical
   Learning* — both free and legal).
5. Only then: general search results, judged carefully for level-appropriateness.

## Search query recipes

- Video on a stats concept: `StatQuest <concept>` then `<concept> intuitive
  explanation video`
- Linear algebra / calculus intuition: `3blue1brown <concept>` / `essence of linear
  algebra <concept>`
- School-level refresher: `Khan Academy <specific skill, e.g. "expanding binomials">`
- Interactive: `<concept> interactive visualization`
- R-flavored: `<concept> in R tutorial`

## Verification loop (per candidate URL)

1. WebSearch with a recipe above; collect 2–5 candidate URLs per module.
2. For each candidate, WebFetch it with a prompt like: *"Is this page about
   <topic>? What does it cover, what format is it (video/post/interactive), and
   roughly how long? Is it beginner-friendly?"*
3. Keep it only if the answer confirms topic match and appropriate level.
   - For YouTube: the fetch must confirm the actual video title/description matches.
     If YouTube blocks fetching, fetch a search-engine cache or the channel's page —
     if you cannot confirm the exact URL's content by ANY fetch, drop it.
4. Aim for 2–4 keepers per module: ideally ≥1 video + 1 written/interactive.

## Annotation format (what goes in resources.md)

One section per module. Each resource is one bullet:

```markdown
## Module 01 — Least squares: the idea

- 📺 [StatQuest: Fitting a line to data](<verified-url>) (video, ~9 min) —
  walks the "minimize squared distances" idea with tiny numeric examples; exactly
  this module's toy example, animated. Watch after the lesson's toy example.
- 📖 [Seeing Theory: Regression](<verified-url>) (interactive) — drag points and
  watch the fitted line move; great for building the "least squares resists
  outliers poorly" intuition.
```

Every bullet: emoji for type (📺 video / 📖 post / 🎮 interactive / 📚 book
chapter), verified link, format + length if known, and one or two lines on WHY it
suits this learner and WHEN to use it (before/after the lesson).
