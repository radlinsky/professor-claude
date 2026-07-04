#!/usr/bin/env Rscript
# check-indexes.R — CI backstop for issue #51.
#
# The foundation<->course link web is kept by hand in several places (the two README
# index tables, each syllabus prereq table, each roadmap's Mermaid nodes). Nothing
# reconciles them, so a rename or a deleted course rots links silently. This script is
# the same guard the repo already applies to renders and licenses, aimed at the index
# web. Base R only (no packages), matching the fork-minimum posture.
#
# Five checks, each printing file-pointing messages and contributing to a non-zero exit:
#   1. every foundations/<slug> referenced under courses/ resolves to a real lesson.qmd
#   2. Used-by <-> syllabus-prereq bidirectionality (reading-math-notation special-cased)
#   3. every Mermaid :::foundation node label starts with a real foundation slug
#   4. every slug in foundations/README's "Builds on" column resolves to a table row
#   5. every Status cell is one of: not started / in progress / done
#
# Run from the repo root: Rscript scripts/check-indexes.R

fail <- 0L
err <- function(file, msg, line = NA) {
  loc <- if (is.na(line)) file else paste0(file, ":", line)
  cat(sprintf("::error file=%s::%s\n", loc, msg))
  fail <<- 1L
}
ok <- function(msg) cat(sprintf("OK  %s\n", msg))
`%||%` <- function(a, b) if (is.null(a)) b else a
# report a per-check OK only when that check added no failures
checkpoint <- function() fail
passed <- function(before, msg) if (fail == before) ok(msg)

read_lines <- function(path) if (file.exists(path)) readLines(path, warn = FALSE) else character(0)

# All existing foundation slugs = directories under foundations/ that hold a lesson.qmd.
foundation_dirs <- list.dirs("foundations", full.names = FALSE, recursive = FALSE)
existing_slugs <- foundation_dirs[file.exists(file.path("foundations", foundation_dirs, "lesson.qmd"))]

course_dirs <- list.dirs("courses", full.names = FALSE, recursive = FALSE)
course_slugs <- course_dirs[file.exists(file.path("courses", course_dirs, "syllabus.md"))]

# Extract all foundations/<slug> path references from a vector of lines.
ref_slugs <- function(lines) {
  m <- regmatches(lines, gregexpr("foundations/([a-z0-9-]+)/", lines))
  slugs <- sub("^foundations/([a-z0-9-]+)/.*$", "\\1", unlist(m))
  unique(slugs)
}

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

## ---- helpers for the README tables --------------------------------------------------
# A GitHub markdown table row: split on unescaped pipes, trim cells.
table_rows <- function(lines) {
  rows <- lines[grepl("^\\|", lines)]
  rows <- rows[!grepl("^\\|[-: ]+\\|", rows)]           # drop the |---|---| separators
  lapply(rows, function(r) {
    cells <- strsplit(sub("^\\|", "", sub("\\|\\s*$", "", r)), "\\|")[[1]]
    trimws(cells)
  })
}
# slugs linked inside a cell, from [text](path/lesson.qmd) or bare foundations/<slug>
cell_foundation_slugs <- function(cell) {
  hits <- regmatches(cell, gregexpr("([a-z0-9-]+)/lesson\\.qmd", cell))[[1]]
  unique(sub("/lesson\\.qmd$", "", hits))
}

found_readme <- read_lines("foundations/README.md")
found_rows <- table_rows(found_readme)
# keep only real module rows (first cell links a <slug>/lesson.qmd)
found_rows <- Filter(function(c) length(c) >= 5 && grepl("/lesson\\.qmd", c[[1]]), found_rows)

## ---- Check 4: Builds-on slugs resolve to a row in the same table --------------------
cat("\n== Check 4: foundations/README Builds-on slugs resolve to a table row ==\n")
before <- checkpoint()
row_slugs <- vapply(found_rows, function(c) cell_foundation_slugs(c[[1]])[1], character(1))
for (c in found_rows) {
  self <- cell_foundation_slugs(c[[1]])[1]
  builds <- cell_foundation_slugs(c[[3]])                 # column 3 = "Builds on"
  for (b in builds) {
    if (!(b %in% row_slugs)) {
      err("foundations/README.md", sprintf("row '%s' Builds-on '%s' has no row in the table", self, b))
    }
  }
}
passed(before, "all Builds-on slugs resolve to a table row")

## ---- Check 5: Status values are from the allowed set --------------------------------
cat("\n== Check 5: Status cells are not started / in progress / done ==\n")
before <- checkpoint()
allowed <- c("not started", "in progress", "done")
check_status <- function(path, rows, status_idx) {
  for (c in rows) {
    if (length(c) >= status_idx) {
      s <- tolower(c[[status_idx]])
      if (!(s %in% allowed)) {
        err(path, sprintf("Status '%s' not in {not started, in progress, done}", c[[status_idx]]))
      }
    }
  }
}
check_status("foundations/README.md", found_rows, 5)      # ...| Builds on | Used by | Status |
courses_readme <- read_lines("courses/README.md")
course_rows <- table_rows(courses_readme)
course_rows <- Filter(function(c) length(c) >= 6 && grepl("/syllabus\\.md", c[[1]]), course_rows)
check_status("courses/README.md", course_rows, 6)         # ...| Foundation prerequisites | Status |
passed(before, "all Status cells valid")

## ---- Check 3: Mermaid :::foundation node labels start with a real slug --------------
cat("\n== Check 3: roadmap Mermaid :::foundation nodes name real slugs ==\n")
before <- checkpoint()
for (cs in course_slugs) {
  rf <- file.path("courses", cs, "00-roadmap.qmd")
  lines <- read_lines(rf)
  for (i in seq_along(lines)) {
    if (grepl(":::foundation", lines[i])) {
      lab <- regmatches(lines[i], regexpr('\\["[^"]+"\\]', lines[i]))
      if (length(lab) == 1) {
        inner <- sub('^\\["', "", sub('"\\]$', "", lab))
        slug <- sub("(<br/?>|\\().*$", "", inner)          # take text before <br/> or (
        slug <- trimws(slug)
        if (!(slug %in% existing_slugs)) {
          err(rf, sprintf("Mermaid foundation node label '%s' is not an existing slug", slug), i)
        }
      }
    }
  }
}
passed(before, "all Mermaid foundation node labels resolve")

## ---- Check 2: Used-by <-> syllabus-prereq bidirectionality -------------------------
cat("\n== Check 2: Used-by <-> syllabus prereq bidirectionality ==\n")
before <- checkpoint()
RMN <- "reading-math-notation"

# Map: foundation slug -> courses listed in its Used-by cell (col 4).
usedby <- list()
for (c in found_rows) {
  self <- cell_foundation_slugs(c[[1]])[1]
  courses_cell <- c[[4]]
  hits <- regmatches(courses_cell, gregexpr("courses/([a-z0-9-]+)/", courses_cell))[[1]]
  usedby[[self]] <- unique(sub("^courses/([a-z0-9-]+)/$", "\\1", hits))
}

# Map: course slug -> foundation slugs listed in its syllabus prereq table.
syllabus_prereqs <- list()
for (cs in course_slugs) {
  sf <- file.path("courses", cs, "syllabus.md")
  lines <- read_lines(sf)
  # the prereq table lives under the "Prerequisites from the foundations library" heading
  start <- grep("Prerequisites from the foundations library", lines)
  slugs <- character(0)
  if (length(start)) {
    tail_lines <- lines[start[1]:length(lines)]
    nexth <- grep("^## ", tail_lines)
    seg <- if (length(nexth) >= 2) tail_lines[1:(nexth[2] - 1)] else tail_lines
    slugs <- ref_slugs(seg)
  }
  syllabus_prereqs[[cs]] <- slugs
}

# Forward: every course in a foundation's Used-by must list that foundation.
for (slug in names(usedby)) {
  if (slug == RMN) next                                   # special-cased below
  for (cs in usedby[[slug]]) {
    if (!(slug %in% (syllabus_prereqs[[cs]] %||% character(0)))) {
      err("foundations/README.md",
          sprintf("Used-by says '%s' is used by '%s', but that syllabus does not list it", slug, cs))
    }
  }
}
# Reverse: every foundation a syllabus lists must carry that course in its Used-by.
for (cs in names(syllabus_prereqs)) {
  for (slug in syllabus_prereqs[[cs]]) {
    if (slug == RMN) next                                 # standing-first: Used-by = "all courses"
    if (!(cs %in% (usedby[[slug]] %||% character(0)))) {
      err(file.path("courses", cs, "syllabus.md"),
          sprintf("lists foundation '%s', but that foundation's Used-by omits '%s'", slug, cs))
    }
  }
}
# reading-math-notation standing-first rule: every course syllabus must list it.
for (cs in course_slugs) {
  if (!(RMN %in% (syllabus_prereqs[[cs]] %||% character(0)))) {
    err(file.path("courses", cs, "syllabus.md"),
        sprintf("must list the standing-first prerequisite '%s' in its prereq table", RMN))
  }
}
passed(before, "Used-by and syllabus prereqs are consistent")

## ---- done ---------------------------------------------------------------------------
cat("\n")
if (fail == 0L) cat("check-indexes: all checks passed\n") else cat("check-indexes: FAILURES above\n")
quit(status = fail)
