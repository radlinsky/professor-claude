#!/usr/bin/env Rscript
# gen-kb-index.R — regenerate the knowledge-base blocks of the shared index files.
#
# Mirrors gen-indexes.R (which owns the foundation blocks): this script owns the
# knowledge blocks in the root `_quarto.yml` (render list + sidebar) and the two
# table bodies in `knowledge/README.md`. The two scripts splice DIFFERENT sentinel
# regions of the same files, so they never conflict.
#
# Unlike foundations there is no meta.dcf: the index is COMPUTED from page bodies.
#   - a page's display name  = its YAML `title:` line (required, single line)
#   - a concept's Sources    = the bib keys cited in its body ([@key ...] brackets,
#                              fenced code blocks excluded)
#   - a concept's Referenced by = files under foundations/ and courses/ that link
#                              to knowledge/concepts/<slug>
#   - a source's Bib key / License / Extraction state are read from its record's
#     `**Bib key:**` / `**Source license:**` lines and chapter-state table
#
# Usage:
#   Rscript scripts/gen-kb-index.R          # rewrite the files in place
#   Rscript scripts/gen-kb-index.R --check  # compare only; exit 1 on any drift (CI)
#
# Base R only (no packages), matching the repo's fork-minimum posture. Run from repo root.

args <- commandArgs(trailingOnly = TRUE)
check_mode <- "--check" %in% args

QUARTO <- "_quarto.yml"
README <- "knowledge/README.md"

# ---- marker strings (must match what the files carry) --------------------------------
M_RENDER_OPEN  <- "    # >>> generated: knowledge render list (scripts/gen-kb-index.R) — do not edit by hand"
M_RENDER_CLOSE <- "    # <<< generated: knowledge render list"
M_SIDEBAR_OPEN  <- "      # >>> generated: knowledge sidebar (scripts/gen-kb-index.R) — do not edit by hand"
M_SIDEBAR_CLOSE <- "      # <<< generated: knowledge sidebar"
M_CONCEPTS_OPEN  <- "<!-- >>> generated: knowledge concepts table (scripts/gen-kb-index.R) — do not edit by hand -->"
M_CONCEPTS_CLOSE <- "<!-- <<< generated: knowledge concepts table -->"
M_SOURCES_OPEN  <- "<!-- >>> generated: knowledge sources table (scripts/gen-kb-index.R) — do not edit by hand -->"
M_SOURCES_CLOSE <- "<!-- <<< generated: knowledge sources table -->"

read_lines <- function(path) enc2utf8(readLines(path, warn = FALSE))
die <- function(...) { cat("gen-kb-index: ", sprintf(...), "\n", sep = ""); quit(status = 1L) }

# ---- discover pages -------------------------------------------------------------------
kb_slugs <- function(dir) {
  files <- list.files(file.path("knowledge", dir), pattern = "\\.md$", full.names = FALSE)
  sort(sub("\\.md$", "", files))
}
concept_slugs <- kb_slugs("concepts")
source_slugs  <- kb_slugs("sources")
has_glossary  <- file.exists("knowledge/glossary.md")

# ---- page helpers ---------------------------------------------------------------------
# YAML `title:` from the frontmatter block: the file must open with `---`, and the
# title must be a single line. Quotes stripped for display.
page_title <- function(path) {
  lines <- read_lines(path)
  if (!length(lines) || lines[1] != "---") die("%s: missing YAML frontmatter (must open with ---)", path)
  close_i <- which(lines[-1] == "---")[1]
  if (!length(close_i) || is.na(close_i)) die("%s: unterminated YAML frontmatter", path)
  fm <- lines[2:close_i]
  ti <- grep("^title:", fm, value = TRUE)
  if (length(ti) != 1L) die("%s: expected exactly one single-line `title:` in frontmatter", path)
  t <- trimws(sub("^title:", "", ti))
  t <- sub('^"(.*)"$', "\\1", t)
  t <- sub("^'(.*)'$", "\\1", t)
  if (!nzchar(t)) die("%s: empty title", path)
  t
}

# Body lines with fenced code blocks removed (so `[@key]` examples in code never count).
strip_fences <- function(lines) {
  fenced <- FALSE
  keep <- logical(length(lines))
  for (i in seq_along(lines)) {
    if (grepl("^\\s*(```|~~~)", lines[i])) { fenced <- !fenced; keep[i] <- FALSE }
    else keep[i] <- !fenced
  }
  lines[keep]
}

# All bib keys cited in a file: every @key inside a [ ... ] citation bracket.
cited_keys <- function(path) {
  txt <- paste(strip_fences(read_lines(path)), collapse = "\n")
  brackets <- regmatches(txt, gregexpr("\\[@[^]]*\\]", txt))[[1]]
  if (!length(brackets)) return(character(0))
  keys <- unlist(regmatches(brackets, gregexpr("@[a-z][a-z0-9]*", brackets)))
  sort(unique(sub("^@", "", keys)))
}

# Files under foundations/ + courses/ that mention knowledge/concepts/<slug>.
referencing_files <- function(slug) {
  pages <- list.files(c("foundations", "courses"), pattern = "\\.(qmd|md)$",
                      recursive = TRUE, full.names = TRUE)
  needle <- paste0("knowledge/concepts/", slug)
  hits <- vapply(pages, function(p) any(grepl(needle, read_lines(p), fixed = TRUE)), logical(1))
  sort(names(hits)[hits])
}

# A source record's `**<Field>:**` line value (first match), or "" if absent.
record_field <- function(path, field) {
  lines <- read_lines(path)
  pat <- paste0("^\\*\\*", field, ":\\*\\*")
  hit <- grep(pat, lines, value = TRUE)
  if (!length(hit)) return("")
  trimws(sub(pat, "", hit[1]))
}

# Summarize the chapter-state table: count each Status value (3rd cell of body rows).
extraction_state <- function(path) {
  lines <- strip_fences(read_lines(path))
  rows <- grep("^\\|", lines, value = TRUE)
  counts <- c(done = 0L, `in progress` = 0L, pending = 0L, skipped = 0L)
  for (r in rows) {
    cells <- trimws(strsplit(sub("^\\|", "", sub("\\|\\s*$", "", r)), "|", fixed = TRUE)[[1]])
    if (length(cells) < 5) next
    st <- cells[3]
    # done / in progress take an optional parenthesized qualifier after the base
    # word — `done (partial — pp. X-Y unreadable)`, `in progress (pp. X-Y done)` —
    # so prefix-match them like skipped (kb-source-template.md status vocabulary).
    # Order matters: test "in progress" before its "done" qualifier can confuse.
    if (grepl("^in progress", st)) counts["in progress"] <- counts["in progress"] + 1L
    else if (grepl("^done", st)) counts["done"] <- counts["done"] + 1L
    else if (st == "pending") counts["pending"] <- counts["pending"] + 1L
    else if (grepl("^skipped", st)) counts["skipped"] <- counts["skipped"] + 1L
  }
  if (!sum(counts)) return("no chapter map")
  parts <- sprintf("%d %s", counts[counts > 0L], names(counts)[counts > 0L])
  paste(parts, collapse = " · ")
}

# Escape a value for a Markdown table cell / a double-quoted YAML scalar.
md_cell <- function(v) {
  v <- gsub("[[:space:]]+", " ", trimws(v))
  gsub("|", "\\|", v, fixed = TRUE)
}
yaml_dq <- function(v) {
  v <- gsub("[[:space:]]+", " ", trimws(v))
  v <- gsub("\\", "\\\\", v, fixed = TRUE)
  gsub('"', '\\"', v, fixed = TRUE)
}

# ---- collect page metadata -------------------------------------------------------------
concepts <- lapply(concept_slugs, function(s) {
  path <- file.path("knowledge/concepts", paste0(s, ".md"))
  list(slug = s, title = page_title(path), keys = cited_keys(path), refs = referencing_files(s))
})
sources <- lapply(source_slugs, function(s) {
  path <- file.path("knowledge/sources", paste0(s, ".md"))
  list(slug = s, title = page_title(path),
       bibkey = record_field(path, "Bib key"),
       license = record_field(path, "Source license"),
       state = extraction_state(path))
})
glossary_title <- if (has_glossary) page_title("knowledge/glossary.md") else NULL

# ---- build the generated bodies ---------------------------------------------------------
# Render list: glossary first, then concepts, then sources.
render_body <- c(
  if (has_glossary) "    - knowledge/glossary.md",
  vapply(concepts, function(c) sprintf("    - knowledge/concepts/%s.md", c$slug), character(1)),
  vapply(sources,  function(s) sprintf("    - knowledge/sources/%s.md",  s$slug), character(1))
)

# Sidebar: ONE "Knowledge base" section (emitted only when the KB has pages, so an
# empty KB contributes zero lines and no empty section).
sidebar_body <- if (!length(render_body)) character(0) else c(
  '      - section: "Knowledge base"',
  "        contents:",
  if (has_glossary) c(
    '          - text: "Glossary"',
    "            href: knowledge/glossary.md"
  ),
  unlist(lapply(concepts, function(c) c(
    sprintf('          - text: "%s"', yaml_dq(c$title)),
    sprintf("            href: knowledge/concepts/%s.md", c$slug)
  )), use.names = FALSE),
  if (length(sources)) c(
    '          - section: "Sources"',
    "            contents:",
    unlist(lapply(sources, function(s) c(
      sprintf('              - text: "%s"', yaml_dq(s$title)),
      sprintf("                href: knowledge/sources/%s.md", s$slug)
    )), use.names = FALSE)
  )
)

concepts_body <- vapply(concepts, function(c) {
  keys <- if (length(c$keys)) paste(c$keys, collapse = ", ") else "—"
  refs <- if (length(c$refs)) {
    paste(sprintf("[%s](../%s)", c$refs, c$refs), collapse = ", ")
  } else "—"
  sprintf("| [%s](concepts/%s.md) | %s | %s |", c$slug, c$slug, md_cell(keys), refs)
}, character(1))

sources_body <- vapply(sources, function(s) {
  sprintf("| [%s](sources/%s.md) | %s | %s | %s |",
          md_cell(s$title), s$slug,
          if (nzchar(s$bibkey)) md_cell(s$bibkey) else "—",
          if (nzchar(s$license)) md_cell(s$license) else "—",
          md_cell(s$state))
}, character(1))

# ---- splice helpers (same contract as gen-indexes.R) ------------------------------------
find_region <- function(lines, open, close, file) {
  oi <- which(lines == open)
  ci <- which(lines == close)
  if (length(oi) != 1L || length(ci) != 1L) {
    die("%s: expected exactly one open and one close marker (found %d / %d)\n  open:  %s\n  close: %s",
        file, length(oi), length(ci), open, close)
  }
  if (ci <= oi) die("%s: close marker precedes open marker", file)
  list(open = oi, close = ci)
}
splice <- function(lines, reg, body) {
  c(lines[seq_len(reg$open)], body, lines[reg$close:length(lines)])
}

regen_readme <- function() {
  lines <- read_lines(README)
  reg1 <- find_region(lines, M_CONCEPTS_OPEN, M_CONCEPTS_CLOSE, README)
  lines <- splice(lines, reg1, concepts_body)
  reg2 <- find_region(lines, M_SOURCES_OPEN, M_SOURCES_CLOSE, README)
  splice(lines, reg2, sources_body)
}
regen_quarto <- function() {
  lines <- read_lines(QUARTO)
  reg1 <- find_region(lines, M_RENDER_OPEN, M_RENDER_CLOSE, QUARTO)
  lines <- splice(lines, reg1, render_body)
  reg2 <- find_region(lines, M_SIDEBAR_OPEN, M_SIDEBAR_CLOSE, QUARTO)
  splice(lines, reg2, sidebar_body)
}

new_readme <- enc2utf8(regen_readme())
new_quarto <- enc2utf8(regen_quarto())

# ---- --check mode: compare to committed files, exit 1 on any drift ----------------------
if (check_mode) {
  drift <- 0L
  same_content <- function(a, b) {
    if (length(a) != length(b)) return(FALSE)
    all(mapply(function(x, y) identical(charToRaw(enc2utf8(x)), charToRaw(enc2utf8(y))), a, b))
  }
  cmp <- function(path, new) {
    old <- read_lines(path)
    if (!same_content(old, new)) {
      cat(sprintf("::error file=%s::%s is out of date — run `Rscript scripts/gen-kb-index.R`\n", path, path))
      n <- max(length(old), length(new))
      for (i in seq_len(n)) {
        o <- if (i <= length(old)) old[i] else "<absent>"
        v <- if (i <= length(new)) new[i] else "<absent>"
        if (!identical(charToRaw(enc2utf8(o)), charToRaw(enc2utf8(v)))) {
          cat(sprintf("  first diff at line %d:\n    committed: %s\n    generated: %s\n", i, o, v))
          break
        }
      }
      drift <<- drift + 1L
    } else {
      cat(sprintf("OK  %s is up to date\n", path))
    }
  }
  cmp(README, new_readme)
  cmp(QUARTO, new_quarto)
  if (drift > 0L) quit(status = 1L)
  cat("gen-kb-index --check: all generated blocks up to date\n")
  quit(status = 0L)
}

# ---- default mode: rewrite in place ------------------------------------------------------
writeLines(new_readme, README)
writeLines(new_quarto, QUARTO)
cat(sprintf("gen-kb-index: regenerated %s and %s (%d concepts, %d sources%s)\n",
            README, QUARTO, length(concepts), length(sources),
            if (has_glossary) ", glossary" else ""))
quit(status = 0L)
