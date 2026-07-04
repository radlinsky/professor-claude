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
#   2. Used-by <-> syllabus-prereq bidirectionality (reading-math-notation special-cased)
#   3. every Mermaid :::foundation node label starts with a real foundation slug
#   4. every slug in foundations/README's "Builds on" column resolves to a table row
#   5. every Status cell is one of: not started / in progress / done
#   6. each foundation's README "Builds on" cell matches its lesson.qmd "Builds on:" line
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

## ---- Check 4: Builds-on slugs resolve to a row in the same table --------------------
cat("\n== Check 4: foundations/README Builds-on slugs resolve to a table row ==\n")
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

## ---- Check 5: Status values are from the allowed set --------------------------------
cat("\n== Check 5: Status cells are not started / in progress / done ==\n")
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
        slug <- trimws(sub("(<br/?>|\\(|\\s).*$", "", inner))  # text before <br/>, "(", or space
        if (!(slug %in% existing_slugs)) {
          err(rf, sprintf("Mermaid foundation node label '%s' is not an existing slug", slug), i)
        }
      }
    }
  }
}
passed(before, "all Mermaid foundation node labels resolve")

## ---- Check 6: README "Builds on" cell matches the lesson's "Builds on:" line --------
cat("\n== Check 6: README Builds-on column matches each lesson's Builds-on line ==\n")
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

## ---- Check 2: Used-by <-> syllabus-prereq bidirectionality -------------------------
cat("\n== Check 2: Used-by <-> syllabus prereq bidirectionality ==\n")
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

## ---- done ---------------------------------------------------------------------------
cat("\n")
if (fail == 0L) cat("check-indexes: all checks passed\n") else cat(sprintf("check-indexes: %d FAILURE(S) above\n", fail))
quit(status = if (fail > 0L) 1L else 0L)                     # any failure -> exit 1
