#' @title Guess Delimited File Parameters
#' @description
#' Guess the delimiter, quote character and decimal mark of a
#' delimited text file. The function splits each of the first
#' \code{n} lines by each candidate delimiter and selects the
#' delimiter that produces the most consistent number of fields.
#'
#' The algorithm is adapted from the vroom package.
#' @param path path to the text file.
#' @param delims character vector of candidate delimiters.
#' @param quotes character vector of candidate quote characters.
#' @param n number of lines to read for guessing (default 1024).
#' @return a named list with elements:
#' \describe{
#'   \item{delim}{the guessed delimiter character (or \code{NULL})}
#'   \item{quote}{the guessed quote character (or \code{NULL})}
#'   \item{decimal_mark}{the guessed decimal mark (or \code{NULL})}
#' }
#' @export
#' @examples
#' f <- system.file(package = "fpeek",
#'   "datafiles", "test-comma.csv")
#' peek_guess_delim(f)
#'
#' f <- system.file(package = "fpeek",
#'   "datafiles", "test-semicolon.csv")
#' peek_guess_delim(f)
peek_guess_delim <- function(
  path,
  delims = c(",", "\t", " ", "|", ":", ";"),
  quotes = c("\"", "'"),
  n = 1024
) {
  lines <- peek_head(path, n = n, intern = TRUE)

  if (length(lines) == 0) {
    return(list(delim = NULL, quote = NULL, decimal_mark = NULL))
  }

  # transliterate to ASCII to avoid multibyte issues
  tmp <- iconv(lines, to = "ASCII//TRANSLIT")
  tmp[is.na(tmp)] <- lines[is.na(tmp)]

  # clear quoted text to avoid false positives
  # useBytes = TRUE prevents errors on strings with invalid multibyte sequences
  for (q in quotes) {
    tmp <- gsub(paste0(q, "[^", q, "]*", q), "", tmp, useBytes = TRUE)
  }

  splits <- lapply(delims, strsplit, x = tmp, useBytes = TRUE, fixed = TRUE)
  counts <- lapply(splits, function(x) table(lengths(x)))
  num_fields <- vapply(
    counts,
    function(x) as.integer(names(x)[[1]]),
    integer(1)
  )
  num_lines <- vapply(counts, function(x) (x)[[1]], integer(1))

  # le nombre de lignes qui ont le meme nombre de champs
  best_consistent_count <- 0L
  # indice du meilleur candidat dans le vecteur delims
  best_delim_idx <- 0L
  for (i in seq_along(delims)) {
    if (
      num_fields[[i]] >= 2 &&
        num_lines[[i]] > best_consistent_count ||
        (best_consistent_count == num_lines[[i]] &&
          (best_delim_idx <= 0 ||
            num_fields[[best_delim_idx]] < num_fields[[i]]))
    ) {
      best_consistent_count <- num_lines[[i]]
      best_delim_idx <- i
    }
  }

  if (best_delim_idx == 0) {
    return(list(delim = NULL, quote = NULL, decimal_mark = NULL))
  }

  delim <- delims[[best_delim_idx]]

  # guess quote character, escape special regex chars in delim
  delim_esc <- delim
  for (sc in c(
    "\\",
    ".",
    "|",
    "(",
    ")",
    "[",
    "]",
    "{",
    "}",
    "^",
    "$",
    "*",
    "+",
    "?"
  )) {
    delim_esc <- gsub(sc, paste0("\\", sc), delim_esc, fixed = TRUE)
  }
  qcounts <- vapply(
    quotes,
    function(q) {
      length(unlist(regmatches(
        lines,
        gregexpr(paste0("(", q, "[^", q, "]*", q, delim_esc, ")"), lines,
                 useBytes = TRUE)
      )))
    },
    integer(1)
  )
  quote <- quotes[[which.max(qcounts)]]

  # guess decimal mark
  if (delim == ",") {
    decimal_mark <- "."
  } else if (delim == ";") {
    decimal_mark <- ","
  } else {
    decimal_mark <- NULL
  }

  list(
    delim = delim,
    quote = quote,
    decimal_mark = decimal_mark
  )
}
