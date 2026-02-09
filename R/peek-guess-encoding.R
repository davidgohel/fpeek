#' @title Guess File Encoding
#' @description
#' Detect the encoding of a text file. This function is a
#' wrapper around \code{\link[readr]{guess_encoding}} from
#' the \code{readr} package, returning the best candidate
#' as a character string.
#'
#' \code{readr} must be installed (it is listed in \code{Suggests}).
#' If it is not available, the function stops with an informative
#' message.
#' @param path path to the text file.
#' @return a character string giving the most likely encoding.
#' @export
#' @examples
#' \dontrun{
#' f <- system.file(package = "fpeek",
#'   "datafiles", "cigfou-ISO-8859-1.txt")
#' peek_guess_encoding(f)
#' }
peek_guess_encoding <- function(path) {
  if (!requireNamespace("readr", quietly = TRUE)) {
    stop(
      "Package 'readr' is required for peek_guess_encoding() ",
      "but is not installed. Install it with: install.packages('readr')",
      call. = FALSE
    )
  }

  guessed_encodings <- readr::guess_encoding(path)
  encoding <- guessed_encodings$encoding[1]

  if (is.na(encoding) || !nzchar(encoding)) {
    encoding <- ""
  }

  encoding
}
