#!/usr/bin/env Rscript
# check-webr-cells.R — native-R execution check for autorun {webr} cells (issue #75).
#
# Nothing else in the pipeline runs {webr} cells: render.yml only executes baked {r}
# chunks; live {webr} cells run in the browser. So a broken autorun cell (a typo in a
# starter's data, a function renamed by a later edit) ships to the live site behind a
# green build. This script closes that gap for the cells that MUST be error-free on page
# load — the ones marked `#| autorun: true`.
#
# The interactive-webr.md contract guarantees live cells are base R and self-contained,
# so native `Rscript` execution is a faithful proxy for in-browser execution (minus wasm
# quirks). Starter cells (autorun off) are intentionally incomplete and are NEVER run.
#
# Behaviour:
#   * Discover every .qmd under foundations/ and courses/.
#   * In each file, parse fenced ```{webr} ... ``` blocks. A block is AUTORUN iff it has
#     a chunk-option line whose trimmed form matches `#| autorun: true`. The chunk BODY
#     is the block's non-`#|` lines. {r} blocks and non-autorun {webr} blocks are skipped
#     entirely (never executed).
#   * For each file with >=1 autorun cell: run ALL its autorun bodies SEQUENTIALLY in ONE
#     fresh Rscript session (they share state on the page), each wrapped in a top-level
#     tryCatch that names the failing cell and exits status 1.
#   * On any file's failure: print file + CELL_ERROR line, set a failure flag; exit 1 at
#     the end. Otherwise print a per-file OK summary and exit 0.
#
# Base R only (no packages), matching scripts/check-indexes.R. Run from the repo root:
#   Rscript scripts/check-webr-cells.R

fail <- 0L

read_lines <- function(path) if (file.exists(path)) readLines(path, warn = FALSE) else character(0)

# Parse a .qmd into autorun {webr} chunk bodies, in document order.
# Returns a list of character vectors (each = one autorun cell's body lines).
autorun_cells <- function(lines) {
  cells <- list()
  i <- 1L
  n <- length(lines)
  while (i <= n) {
    if (trimws(lines[i]) == "```{webr}") {
      # collect until the closing ``` fence
      j <- i + 1L
      block <- character(0)
      while (j <= n && trimws(lines[j]) != "```") {
        block <- c(block, lines[j])
        j <- j + 1L
      }
      # `#| autorun: true`, tolerating an optional trailing YAML comment.
      is_autorun <- any(grepl("^#\\|\\s*autorun:\\s*true\\s*(#.*)?$", trimws(block)))
      if (is_autorun) {
        body <- block[!grepl("^#\\|", trimws(block))]   # drop chunk-option lines
        cells[[length(cells) + 1L]] <- body
      }
      i <- j + 1L                                        # resume past the closing fence
    } else {
      i <- i + 1L
    }
  }
  cells
}

# Run a file's autorun cells sequentially in one fresh Rscript session.
# Returns TRUE on success, FALSE on failure (details already printed by the child).
run_file_cells <- function(path, cells) {
  # Build a temp .R: open a throwaway graphics device so plot() calls don't fail/spew,
  # then run each cell body at top level (so assignments persist across cells) inside a
  # tryCatch that names the failing cell index and quits status 1.
  script <- c(
    "pdf(file = tempfile())",
    unlist(lapply(seq_along(cells), function(k) {
      c(
        "tryCatch({",
        cells[[k]],
        sprintf("}, error = function(e) { cat(sprintf(\"CELL_ERROR %d: %%s\\n\", conditionMessage(e))); quit(status = 1) })", k)
      )
    }), use.names = FALSE)
  )
  tmp <- tempfile(fileext = ".R")
  writeLines(script, tmp)
  on.exit(unlink(tmp), add = TRUE)
  out <- character(0)
  # timeout guards CI against a hung autorun cell (e.g. an accidental infinite loop);
  # a timeout kill returns non-zero status and is reported through the path below.
  status <- suppressWarnings(system2("Rscript", tmp, stdout = TRUE, stderr = TRUE, timeout = 120))
  code <- attr(status, "status")
  if (is.null(code)) code <- 0L
  if (code != 0L) {
    cat(sprintf("FAIL  %s\n", path))
    ce <- grep("^CELL_ERROR", status, value = TRUE)
    if (length(ce)) for (l in ce) cat(sprintf("  %s\n", l))
    else for (l in status) cat(sprintf("  %s\n", l))
    return(FALSE)
  }
  TRUE
}

qmd_files <- list.files(c("foundations", "courses"), pattern = "\\.qmd$",
                        recursive = TRUE, full.names = TRUE)

for (f in qmd_files) {
  cells <- autorun_cells(read_lines(f))
  if (!length(cells)) next
  if (run_file_cells(f, cells)) {
    cat(sprintf("OK  %s (%d autorun cells)\n", f, length(cells)))
  } else {
    fail <- fail + 1L
  }
}

cat("\n")
if (fail == 0L) {
  cat("check-webr-cells: all autorun cells executed cleanly\n")
  quit(status = 0L)
} else {
  cat(sprintf("check-webr-cells: %d file(s) FAILED above\n", fail))
  quit(status = 1L)
}
