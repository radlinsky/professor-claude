#!/usr/bin/env Rscript
# gen-indexes.R — regenerate the foundation blocks of the two shared index files.
#
# The foundation render list + sidebar in the root `_quarto.yml` and the foundation
# table in `foundations/README.md` used to be hand-edited on every new module, so
# parallel PRs collided at the same append point. This script makes those three
# regions GENERATED, SORTED BY SLUG, from per-module metadata (foundations/<slug>/
# meta.dcf). Different modules then touch non-adjacent lines and git auto-merges.
#
# Source of truth per module: foundations/<slug>/meta.dcf (base-R read.dcf format):
#   ShortName: sidebar section label
#   Concepts:  README "Concepts covered" cell (continuation lines indented 1 space)
#   BuildsOn:  README "Builds on" cell, verbatim (or "—" for a root)
#   UsedBy:    README "Used by" cell, verbatim (or "—" if none)
# The README Status cell is NOT in meta.dcf — it belongs to the learner and is
# PRESERVED by re-reading the current README before regenerating (new slug -> "not
# started"). Status is never invented or reset.
#
# The script rewrites ONLY the text between matching sentinel markers, leaving course
# entries and all prose byte-identical.
#
# Usage:
#   Rscript scripts/gen-indexes.R          # rewrite the files in place
#   Rscript scripts/gen-indexes.R --check  # compare only; exit 1 on any drift (CI)
#
# Base R only (no packages), matching the repo's fork-minimum posture. Run from repo root.

args <- commandArgs(trailingOnly = TRUE)
check_mode <- "--check" %in% args

QUARTO   <- "_quarto.yml"
README   <- "foundations/README.md"

REQUIRED_FIELDS <- c("ShortName", "Concepts", "BuildsOn", "UsedBy")

# ---- marker strings (must match what the files carry) --------------------------------
M_RENDER_OPEN  <- "    # >>> generated: foundation render list (scripts/gen-indexes.R) — do not edit by hand"
M_RENDER_CLOSE <- "    # <<< generated: foundation render list"
M_SIDEBAR_OPEN  <- "          # >>> generated: foundation sidebar (scripts/gen-indexes.R) — do not edit by hand"
M_SIDEBAR_CLOSE <- "          # <<< generated: foundation sidebar"
M_TABLE_OPEN  <- "<!-- >>> generated: foundation table (scripts/gen-indexes.R) — do not edit by hand -->"
M_TABLE_CLOSE <- "<!-- <<< generated: foundation table -->"

# Normalize to UTF-8 on read so byte-identical files with differing R Encoding tags
# (readLines yields "unknown"; strings built from read.dcf are tagged "UTF-8") compare
# equal under identical() in --check mode, and writes stay deterministic.
read_lines  <- function(path) enc2utf8(readLines(path, warn = FALSE))
die <- function(...) { cat("gen-indexes: ", sprintf(...), "\n", sep = ""); quit(status = 1L) }

# ---- discover slugs = foundations/ subdirs holding a lesson.qmd, sorted ascending ----
found_dirs <- list.dirs("foundations", full.names = FALSE, recursive = FALSE)
slugs <- found_dirs[file.exists(file.path("foundations", found_dirs, "lesson.qmd"))]
slugs <- sort(slugs)
if (!length(slugs)) die("no foundation modules found under foundations/")

# A module discovered by its lesson.qmd must also carry practice.qmd + resources.md,
# else the render/sidebar bodies below would emit lines for nonexistent files (a partial
# scaffold). Fail here with the exact missing paths, mirroring the meta.dcf die() below.
missing_pages <- unlist(lapply(slugs, function(s) {
  need <- file.path("foundations", s, c("practice.qmd", "resources.md"))
  need[!file.exists(need)]
}))
if (length(missing_pages)) {
  die("partial scaffold — these expected module files are missing:\n  %s",
      paste(missing_pages, collapse = "\n  "))
}

# ---- read each module's meta.dcf -----------------------------------------------------
meta <- list()
for (s in slugs) {
  mf <- file.path("foundations", s, "meta.dcf")
  if (!file.exists(mf)) die("foundations/%s/lesson.qmd exists but %s is missing", s, mf)
  d <- tryCatch(read.dcf(mf), error = function(e) die("cannot parse %s: %s", mf, conditionMessage(e)))
  fields <- colnames(d)
  for (f in REQUIRED_FIELDS) {
    if (!(f %in% fields) || is.na(d[1, f]) || !nzchar(trimws(d[1, f]))) {
      die("%s is missing required field '%s'", mf, f)
    }
  }
  meta[[s]] <- list(
    ShortName = trimws(d[1, "ShortName"]),
    Concepts  = trimws(d[1, "Concepts"]),
    BuildsOn  = trimws(d[1, "BuildsOn"]),
    UsedBy    = trimws(d[1, "UsedBy"])
  )
}

# ---- helper: locate a marked region, return the index range BETWEEN the markers ------
# Returns list(open=i, close=j) of the marker line indices; body is (open+1):(close-1).
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

# Replace the body between markers with `body` (character vector, no markers). Returns
# the new full line vector.
splice <- function(lines, reg, body) {
  c(lines[seq_len(reg$open)], body, lines[reg$close:length(lines)])
}

# ---- preserve Status: parse current README table body for each slug's Status cell ----
# The README table body is between the table markers. Each row:
#   | [<slug>](<slug>/lesson.qmd) | Concepts | Builds on | Used by | Status |
current_status <- function() {
  lines <- read_lines(README)
  reg <- find_region(lines, M_TABLE_OPEN, M_TABLE_CLOSE, README)
  body <- if (reg$close > reg$open + 1L) lines[(reg$open + 1L):(reg$close - 1L)] else character(0)
  st <- list()
  for (r in body) {
    if (!grepl("^\\|", r)) next
    cells <- strsplit(sub("^\\|", "", sub("\\|\\s*$", "", r)), "\\|", fixed = FALSE)[[1]]
    cells <- trimws(cells)
    if (length(cells) < 5) next
    slug <- sub("^.*\\[([a-z0-9-]+)\\].*$", "\\1", cells[1])
    st[[slug]] <- cells[length(cells)]   # Status is the last cell
  }
  st
}
status_map <- current_status()
status_for <- function(s) {
  v <- status_map[[s]]
  if (is.null(v) || !nzchar(v)) "not started" else v
}

# ---- sanitizers so meta.dcf values can't corrupt the generated syntax ----------------
# read.dcf joins continuation lines with "\n", so collapse whitespace runs to one space;
# escape pipes so a "|" in a value can't split the Markdown table row.
md_cell <- function(v) {
  v <- gsub("[[:space:]]+", " ", trimws(v))
  gsub("|", "\\|", v, fixed = TRUE)
}
# escape a value for a double-quoted YAML scalar (the sidebar section title): backslash
# first (it's YAML's escape char), then double quotes
yaml_dq <- function(v) {
  v <- gsub("[[:space:]]+", " ", trimws(v))
  v <- gsub("\\", "\\\\", v, fixed = TRUE)
  gsub('"', '\\"', v, fixed = TRUE)
}

# ---- build the three generated bodies (sorted by slug) -------------------------------
table_body <- vapply(slugs, function(s) {
  m <- meta[[s]]
  sprintf("| [%s](%s/lesson.qmd) | %s | %s | %s | %s |",
          s, s, md_cell(m$Concepts), md_cell(m$BuildsOn), md_cell(m$UsedBy), status_for(s))
}, character(1))

render_body <- unlist(lapply(slugs, function(s) c(
  sprintf("    - foundations/%s/lesson.qmd", s),
  sprintf("    - foundations/%s/practice.qmd", s),
  sprintf("    - foundations/%s/resources.md", s)
)), use.names = FALSE)

sidebar_body <- unlist(lapply(slugs, function(s) c(
  sprintf('          - section: "%s"', yaml_dq(meta[[s]]$ShortName)),
  "            contents:",
  '              - text: "Lesson"',
  sprintf("                href: foundations/%s/lesson.qmd", s),
  '              - text: "Practice"',
  sprintf("                href: foundations/%s/practice.qmd", s),
  '              - text: "Resources"',
  sprintf("                href: foundations/%s/resources.md", s)
)), use.names = FALSE)

# ---- assemble new file contents ------------------------------------------------------
regen_readme <- function() {
  lines <- read_lines(README)
  reg <- find_region(lines, M_TABLE_OPEN, M_TABLE_CLOSE, README)
  splice(lines, reg, table_body)
}
regen_quarto <- function() {
  lines <- read_lines(QUARTO)
  reg1 <- find_region(lines, M_RENDER_OPEN, M_RENDER_CLOSE, QUARTO)
  lines <- splice(lines, reg1, render_body)
  reg2 <- find_region(lines, M_SIDEBAR_OPEN, M_SIDEBAR_CLOSE, QUARTO)
  lines <- splice(lines, reg2, sidebar_body)
  lines
}

new_readme <- enc2utf8(regen_readme())
new_quarto <- enc2utf8(regen_quarto())

# ---- --check mode: compare to committed files, exit 1 on any drift -------------------
if (check_mode) {
  drift <- 0L
  # Compare by content, ignoring R's per-string Encoding tag: readLines yields
  # "unknown"-tagged ASCII while strings built from read.dcf are "UTF-8"-tagged, so
  # identical() would report visually-identical lines as different. Same length + same
  # UTF-8 bytes per line is the meaningful test.
  same_content <- function(a, b) {
    if (length(a) != length(b)) return(FALSE)
    all(mapply(function(x, y) identical(charToRaw(enc2utf8(x)), charToRaw(enc2utf8(y))), a, b))
  }
  cmp <- function(path, new) {
    old <- read_lines(path)
    if (!same_content(old, new)) {
      cat(sprintf("::error file=%s::%s is out of date — run `Rscript scripts/gen-indexes.R`\n", path, path))
      # Show first differing line for a diff-ish hint.
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
  cat("gen-indexes --check: all generated blocks up to date\n")
  quit(status = 0L)
}

# ---- default mode: rewrite in place --------------------------------------------------
writeLines(new_readme, README)
writeLines(new_quarto, QUARTO)
cat(sprintf("gen-indexes: regenerated %s and %s (%d foundation modules)\n",
            README, QUARTO, length(slugs)))
quit(status = 0L)
