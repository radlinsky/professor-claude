#!/usr/bin/env Rscript
# check-indexes.R — CI backstop for issue #51.
#
# The foundation<->course link web is kept by hand in several places (the two README
# index tables, each foundation lesson's "Builds on:" line, each syllabus prereq table,
# each roadmap's Mermaid nodes). Nothing reconciles them, so a rename or a deleted
# course rots links silently. This script is the same guard the repo already applies to
# renders and licenses, aimed at the index web. Base R only (no packages), matching the
# fork-minimum posture.
#
# Checks, each emitting GitHub-Actions file+line annotations and contributing to a
# non-zero exit:
#   0. the two README index files this script relies on exist (else later checks pass
#      vacuously over zero rows)
#   1. every foundations/<slug> referenced under courses/ resolves to a real lesson.qmd
#   2. every slug in foundations/README's "Builds on" column resolves to a table row
#   3. every Status cell is one of: not started / in progress / done
#   4. every Mermaid :::foundation node label starts with a real foundation slug
#   5. each foundation's README "Builds on" cell matches its lesson.qmd "Builds on:" line
#   6. Used-by <-> syllabus-prereq bidirectionality (reading-math-notation special-cased)
#   7. every *.qmd/*.md page on disk under foundations/, courses/ and knowledge/
#      (except README.md) appears in _quarto.yml's render list (same rule as
#      render.yml's bash guard)
#   8. every [@key] citation under knowledge/, courses/, foundations/ resolves to an
#      entry in knowledge/references.bib, and every knowledge/sources/<slug>.md
#      declares the Bib key its filename implies (see citations.md)
#   9. every knowledge/concepts/<slug>.md link resolves to a real concept page
#  10. every knowledge/concepts/ page carries at least one citation
#
# Run from the repo root: Rscript scripts/check-indexes.R

fail <- 0L
# Emit a GitHub Actions error annotation. file+line are separate fields so Actions can
# deep-link (file=path,line=N); line is omitted when a single line isn't meaningful.
err <- function(file, msg, line = NA) {
  if (is.na(line)) cat(sprintf("::error file=%s::%s\n", file, msg))
  else             cat(sprintf("::error file=%s,line=%d::%s\n", file, as.integer(line), msg))
  fail <<- fail + 1L                                        # counter, so per-check passed() stays accurate
}
ok <- function(msg) cat(sprintf("OK  %s\n", msg))
`%||%` <- function(a, b) if (is.null(a)) b else a
checkpoint <- function() fail                                # per-check OK bookkeeping
passed <- function(before, msg) if (fail == before) ok(msg)

read_lines <- function(path) if (file.exists(path)) readLines(path, warn = FALSE) else character(0)

# All existing foundation slugs = directories under foundations/ that hold a lesson.qmd.
foundation_dirs <- list.dirs("foundations", full.names = FALSE, recursive = FALSE)
existing_slugs <- foundation_dirs[file.exists(file.path("foundations", foundation_dirs, "lesson.qmd"))]

course_dirs <- list.dirs("courses", full.names = FALSE, recursive = FALSE)
course_slugs <- course_dirs[file.exists(file.path("courses", course_dirs, "syllabus.md"))]

# Foundation slugs referenced by [text](.../<slug>/lesson.qmd) links in a set of lines.
ref_slugs <- function(lines) {
  m <- regmatches(lines, gregexpr("([a-z0-9-]+)/lesson\\.qmd", lines))
  slugs <- sub("/lesson\\.qmd$", "", unlist(m))
  unique(slugs[slugs %in% existing_slugs])
}

# Parse a GitHub markdown table into rows carrying their 1-based line number.
table_rows <- function(lines) {
  out <- list()
  for (i in seq_along(lines)) {
    r <- lines[i]
    if (!grepl("^\\|", r)) next
    if (grepl("^\\|[-: ]+\\|", r)) next                     # skip |---|---| separators
    cells <- trimws(strsplit(sub("^\\|", "", sub("\\|\\s*$", "", r)), "\\|")[[1]])
    out[[length(out) + 1]] <- list(cells = cells, line = i)
  }
  out
}
# Foundation slugs linked inside one table cell.
cell_foundation_slugs <- function(cell) {
  hits <- regmatches(cell, gregexpr("([a-z0-9-]+)/lesson\\.qmd", cell))[[1]]
  unique(sub("/lesson\\.qmd$", "", hits))
}

found_readme <- read_lines("foundations/README.md")
found_rows <- Filter(function(x) length(x$cells) >= 5 && grepl("/lesson\\.qmd", x$cells[[1]]),
                     table_rows(found_readme))

## ---- Check 0: the index files this script relies on must exist ---------------------
# Without this, a deleted/renamed README makes read_lines() return character(0) and the
# table checks iterate zero rows — passing vacuously instead of catching the breakage.
cat("\n== Check 0: required index files present ==\n")
before <- checkpoint()
for (req in c("foundations/README.md", "courses/README.md")) {
  if (!file.exists(req)) err(req, "required index file is missing")
}
passed(before, "required index files present")

## ---- Check 1: every foundations/<slug> referenced under courses/ exists -------------
cat("\n== Check 1: foundation references under courses/ resolve ==\n")
before <- checkpoint()
course_files <- list.files("courses", pattern = "\\.(qmd|md)$", recursive = TRUE, full.names = TRUE)
for (f in course_files) {
  lines <- read_lines(f)
  for (i in seq_along(lines)) {
    hits <- regmatches(lines[i], gregexpr("foundations/[a-z0-9-]+/", lines[i]))[[1]]
    for (h in hits) {
      slug <- sub("^foundations/([a-z0-9-]+)/$", "\\1", h)
      if (!(slug %in% existing_slugs)) {
        err(f, sprintf("references foundations/%s/ which has no lesson.qmd", slug), i)
      }
    }
  }
}
passed(before, "all foundation path references under courses/ resolve")

## ---- Check 2: Builds-on slugs resolve to a row in the same table --------------------
cat("\n== Check 2: foundations/README Builds-on slugs resolve to a table row ==\n")
before <- checkpoint()
row_slugs <- vapply(found_rows, function(x) cell_foundation_slugs(x$cells[[1]])[1], character(1))
for (x in found_rows) {
  self <- cell_foundation_slugs(x$cells[[1]])[1]
  for (b in cell_foundation_slugs(x$cells[[3]])) {          # column 3 = "Builds on"
    if (!(b %in% row_slugs)) {
      err("foundations/README.md",
          sprintf("row '%s' Builds-on '%s' has no row in the table", self, b), x$line)
    }
  }
}
passed(before, "all Builds-on slugs resolve to a table row")

## ---- Check 3: Status values are from the allowed set --------------------------------
cat("\n== Check 3: Status cells are not started / in progress / done ==\n")
before <- checkpoint()
allowed <- c("not started", "in progress", "done")
check_status <- function(path, rows, status_idx) {
  for (x in rows) {
    if (length(x$cells) >= status_idx) {
      s <- tolower(x$cells[[status_idx]])
      if (!(s %in% allowed)) {
        err(path, sprintf("Status '%s' not in {not started, in progress, done}", x$cells[[status_idx]]), x$line)
      }
    }
  }
}
check_status("foundations/README.md", found_rows, 5)         # ...| Builds on | Used by | Status |
course_rows <- Filter(function(x) length(x$cells) >= 6 && grepl("/syllabus\\.md", x$cells[[1]]),
                      table_rows(read_lines("courses/README.md")))
check_status("courses/README.md", course_rows, 6)           # ...| Foundation prerequisites | Status |
passed(before, "all Status cells valid")

## ---- Check 4: Mermaid :::foundation node labels start with a real slug --------------
cat("\n== Check 4: roadmap Mermaid :::foundation nodes name real slugs ==\n")
before <- checkpoint()
for (cs in course_slugs) {
  rf <- file.path("courses", cs, "00-roadmap.qmd")
  lines <- read_lines(rf)
  for (i in seq_along(lines)) {
    if (grepl(":::foundation", lines[i])) {
      lab <- regmatches(lines[i], regexpr('\\["[^"]+"\\]', lines[i]))
      if (length(lab) == 1) {
        inner <- sub('^\\["', "", sub('"\\]$', "", lab))
        slug <- trimws(sub("(<br/?>|\\(|\\s).*$", "", inner))  # text before <br/>, "(", or space
        if (!(slug %in% existing_slugs)) {
          err(rf, sprintf("Mermaid foundation node label '%s' is not an existing slug", slug), i)
        }
      }
    }
  }
}
passed(before, "all Mermaid foundation node labels resolve")

## ---- Check 5: README "Builds on" cell matches the lesson's "Builds on:" line --------
cat("\n== Check 5: README Builds-on column matches each lesson's Builds-on line ==\n")
before <- checkpoint()
# Pull the foundation slugs a lesson declares in its "**Builds on:**" statement (which may
# wrap across lines up to the next blank line). Roots say "just the baseline" -> empty set.
lesson_builds_on <- function(slug) {
  lines <- read_lines(file.path("foundations", slug, "lesson.qmd"))
  h <- grep("\\*\\*Builds on:\\*\\*", lines)
  if (!length(h)) return(list(slugs = character(0), line = NA))
  seg <- lines[h[1]:length(lines)]
  blank <- which(seg == "" | grepl("^\\s*$", seg))
  seg <- if (length(blank)) seg[1:(blank[1] - 1)] else seg
  # Use the same unfiltered extractor as the README side, for an apples-to-apples diff.
  list(slugs = unique(unlist(lapply(seg, cell_foundation_slugs))), line = h[1])
}
for (x in found_rows) {
  self <- cell_foundation_slugs(x$cells[[1]])[1]
  if (is.na(self)) next
  readme_deps <- sort(cell_foundation_slugs(x$cells[[3]]))
  lb <- lesson_builds_on(self)
  lesson_deps <- sort(lb$slugs)
  if (!identical(readme_deps, lesson_deps)) {
    err(file.path("foundations", self, "lesson.qmd"),
        sprintf("Builds-on line {%s} != README Builds-on column {%s}",
                paste(lesson_deps, collapse = ", "), paste(readme_deps, collapse = ", ")),
        lb$line)
  }
}
passed(before, "every lesson Builds-on line matches its README column cell")

## ---- Check 6: Used-by <-> syllabus-prereq bidirectionality -------------------------
cat("\n== Check 6: Used-by <-> syllabus prereq bidirectionality ==\n")
before <- checkpoint()
RMN <- "reading-math-notation"

# Map: foundation slug -> (courses in its Used-by cell, README row line).
usedby <- list(); usedby_line <- list()
for (x in found_rows) {
  self <- cell_foundation_slugs(x$cells[[1]])[1]
  hits <- regmatches(x$cells[[4]], gregexpr("courses/([a-z0-9-]+)/", x$cells[[4]]))[[1]]
  usedby[[self]] <- unique(sub("^courses/([a-z0-9-]+)/$", "\\1", hits))
  usedby_line[[self]] <- x$line
}

# Map: course slug -> (foundation slugs in its syllabus prereq table, table heading line).
syllabus_prereqs <- list(); syllabus_line <- list()
for (cs in course_slugs) {
  sf <- file.path("courses", cs, "syllabus.md")
  lines <- read_lines(sf)
  start <- grep("Prerequisites from the foundations library", lines)
  slugs <- character(0); hline <- NA
  if (length(start)) {
    hline <- start[1]
    tail_lines <- lines[start[1]:length(lines)]
    nexth <- grep("^## ", tail_lines)
    seg <- if (length(nexth) >= 2) tail_lines[1:(nexth[2] - 1)] else tail_lines
    slugs <- ref_slugs(seg)
  }
  syllabus_prereqs[[cs]] <- slugs
  syllabus_line[[cs]] <- hline
}

# Forward: every course in a foundation's Used-by must list that foundation.
for (slug in names(usedby)) {
  if (slug == RMN) next
  for (cs in usedby[[slug]]) {
    if (!(slug %in% (syllabus_prereqs[[cs]] %||% character(0)))) {
      err("foundations/README.md",
          sprintf("Used-by says '%s' is used by '%s', but that syllabus does not list it", slug, cs),
          usedby_line[[slug]])
    }
  }
}
# Reverse: every foundation a syllabus lists must carry that course in its Used-by.
for (cs in names(syllabus_prereqs)) {
  for (slug in syllabus_prereqs[[cs]]) {
    if (slug == RMN) next                                   # standing-first: Used-by = "all courses"
    if (!(cs %in% (usedby[[slug]] %||% character(0)))) {
      err(file.path("courses", cs, "syllabus.md"),
          sprintf("lists foundation '%s', but that foundation's Used-by omits '%s'", slug, cs),
          syllabus_line[[cs]])
    }
  }
}
# reading-math-notation standing-first rule: every course syllabus must list it.
for (cs in course_slugs) {
  if (!(RMN %in% (syllabus_prereqs[[cs]] %||% character(0)))) {
    err(file.path("courses", cs, "syllabus.md"),
        sprintf("must list the standing-first prerequisite '%s' in its prereq table", RMN),
        syllabus_line[[cs]])
  }
}
passed(before, "Used-by and syllabus prereqs are consistent")

## ---- Check 7: every on-disk page is registered in _quarto.yml render list -----------
# Same rule as render.yml 'Check every page is registered' — keep in sync.
cat("\n== Check 7: every foundations/, courses/ & knowledge/ page is in the _quarto.yml render list ==\n")
before <- checkpoint()
# On-disk pages: every *.qmd/*.md under foundations/, courses/ and knowledge/ except
# README.md (README.md files are GitHub-facing repo indexes, not rendered site pages).
disk_pages <- list.files(c("foundations", "courses", "knowledge"), pattern = "\\.(qmd|md)$",
                         recursive = TRUE, full.names = TRUE)
disk_pages <- disk_pages[basename(disk_pages) != "README.md"]
# Registered pages: extract the path token right after "- ", exactly as render.yml's
# `grep -oP '(?<=- )(foundations|courses|knowledge)/\S+\.(qmd|md)'` does. The lookbehind
# excludes sidebar `href:` lines, and `\S+` stops at whitespace so a trailing YAML comment
# after the path is tolerated (matching CI). PCRE lookbehind needs perl = TRUE.
quarto_lines <- read_lines("_quarto.yml")
registered <- unique(regmatches(quarto_lines,
  regexpr("(?<=- )(foundations|courses|knowledge)/\\S+\\.(qmd|md)", quarto_lines, perl = TRUE)))
for (p in disk_pages) {
  if (!(p %in% registered)) {
    err("_quarto.yml", sprintf("page '%s' exists on disk but is not in the render list", p))
  }
}
passed(before, "every on-disk page is registered in _quarto.yml")

## ---- Checks 8-10: knowledge-base integrity (citations.md + knowledge-base.md) --------
# Shared helpers. Fenced code blocks are excluded so `[@key]` examples in code listings
# never count as citations (same rule as scripts/gen-kb-index.R).
BIB <- "knowledge/references.bib"
code_mask <- function(lines) {                               # TRUE = prose line
  fenced <- FALSE
  vapply(lines, function(l) {
    if (grepl("^\\s*(```|~~~)", l)) { fenced <<- !fenced; return(FALSE) }
    !fenced
  }, logical(1), USE.NAMES = FALSE)
}
kb_scan_files <- list.files(c("knowledge", "foundations", "courses"),
                            pattern = "\\.(qmd|md)$", recursive = TRUE, full.names = TRUE)
concept_pages <- list.files("knowledge/concepts", pattern = "\\.md$", full.names = TRUE)
source_pages  <- list.files("knowledge/sources",  pattern = "\\.md$", full.names = TRUE)

## ---- Check 8: every [@key] citation resolves in knowledge/references.bib -------------
cat("\n== Check 8: [@key] citations resolve in knowledge/references.bib ==\n")
before <- checkpoint()
bib_keys <- character(0)
if (file.exists(BIB)) {
  m <- regmatches(read_lines(BIB), regexpr("^@\\w+\\{[^,]+,", read_lines(BIB)))
  bib_keys <- sub(",$", "", sub("^@\\w+\\{", "", m))
} else if (length(concept_pages) || length(source_pages)) {
  err(BIB, "knowledge pages exist but the bibliography file is missing")
}
for (f in kb_scan_files) {
  lines <- read_lines(f)
  prose <- code_mask(lines)
  for (i in seq_along(lines)) {
    if (!prose[i]) next
    brackets <- regmatches(lines[i], gregexpr("\\[@[^]]*\\]", lines[i]))[[1]]
    for (b in brackets) {
      keys <- sub("^@", "", unlist(regmatches(b, gregexpr("@[a-zA-Z][a-zA-Z0-9]*", b))))
      for (k in keys) {
        if (!(k %in% bib_keys)) {
          err(f, sprintf("citation [@%s] has no entry in %s", k, BIB), i)
        }
      }
    }
  }
}
# Each source record's declared Bib key must exist in the .bib AND match the key its
# filename implies: YYYY-firstauthor-shortname -> firstauthorYYYYshortname (citations.md).
for (f in source_pages) {
  slug <- sub("\\.md$", "", basename(f))
  lines <- read_lines(f)
  ki <- grep("^\\*\\*Bib key:\\*\\*", lines)
  if (!length(ki)) { err(f, "source record is missing its '**Bib key:**' line"); next }
  declared <- trimws(sub("^\\*\\*Bib key:\\*\\*", "", lines[ki[1]]))
  if (!(declared %in% bib_keys)) {
    err(f, sprintf("declared Bib key '%s' has no entry in %s", declared, BIB), ki[1])
  }
  if (grepl("^\\d{4}-[a-z]+-[a-z0-9-]+$", slug)) {
    p <- strsplit(slug, "-")[[1]]
    expected <- paste0(p[2], p[1], paste(p[-(1:2)], collapse = ""))
    if (declared != expected) {
      err(f, sprintf("Bib key '%s' does not match the key implied by the filename ('%s' -> '%s')",
                     declared, slug, expected), ki[1])
    }
  } else {
    err(f, sprintf("source record filename '%s' is not YYYY-firstauthor-shortname", slug))
  }
}
passed(before, "all citations resolve and source-record bib keys are consistent")

## ---- Check 9: knowledge/concepts/ links resolve ---------------------------------------
cat("\n== Check 9: knowledge concept links resolve ==\n")
before <- checkpoint()
concept_slugs_kb <- sub("\\.md$", "", basename(concept_pages))
for (f in kb_scan_files) {
  lines <- read_lines(f)
  for (i in seq_along(lines)) {
    # any path spelling of a concept page, from any tree
    hits <- regmatches(lines[i], gregexpr("knowledge/concepts/[a-z0-9-]+\\.md", lines[i]))[[1]]
    # sibling links inside concept pages themselves: [text](<slug>.md)
    # (length guards: paste0 recycles a zero-length vector as "", minting a phantom hit)
    if (dirname(f) == "knowledge/concepts") {
      rel <- regmatches(lines[i], gregexpr("\\]\\([a-z0-9-]+\\.md\\)", lines[i]))[[1]]
      if (length(rel)) hits <- c(hits, paste0("knowledge/concepts/", sub("^\\]\\(", "", sub("\\)$", "", rel))))
    }
    # links from knowledge/ root pages: [text](concepts/<slug>.md)
    if (f %in% c("knowledge/glossary.md", "knowledge/README.md")) {
      rel <- regmatches(lines[i], gregexpr("\\]\\(concepts/[a-z0-9-]+\\.md\\)", lines[i]))[[1]]
      if (length(rel)) hits <- c(hits, paste0("knowledge/", sub("^\\]\\(", "", sub("\\)$", "", rel))))
    }
    for (h in unique(hits)) {
      slug <- sub("\\.md$", "", basename(h))
      if (!(slug %in% concept_slugs_kb)) {
        err(f, sprintf("links to knowledge concept '%s' which does not exist", slug), i)
      }
    }
  }
}
passed(before, "all knowledge concept links resolve")

## ---- Check 10: every concept page carries at least one citation -----------------------
cat("\n== Check 10: every knowledge concept page is cited ==\n")
before <- checkpoint()
for (f in concept_pages) {
  lines <- read_lines(f)
  prose_lines <- lines[code_mask(lines)]
  if (!any(grepl("\\[@[a-zA-Z]", prose_lines))) {
    err(f, "concept page has no [@key] citation (every claim must be cited — knowledge-base.md)")
  }
}
passed(before, "every knowledge concept page carries a citation")

## ---- done ---------------------------------------------------------------------------
cat("\n")
if (fail == 0L) cat("check-indexes: all checks passed\n") else cat(sprintf("check-indexes: %d FAILURE(S) above\n", fail))
quit(status = if (fail > 0L) 1L else 0L)                     # any failure -> exit 1
