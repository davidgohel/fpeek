#' @useDynLib fpeek
#' @importFrom Rcpp sourceCpp
#' @export
#' @title number of lines of a file
#' @description return the number of lines
#' found in a file. Operation is counting the
#' number of new line symbols in the file.
#' @param path file path
#' @param with_eof count the end of file as
#' a new line.
#' @return number of lines as an integer
#' @examples
#' f <- system.file(package = "fpeek",
#'   "datafiles", "cigfou-ISO-8859-1.txt")
#' peek_count_lines(f)
peek_count_lines <- function(path, with_eof = FALSE ) {
  nlines_(path, with_eof = with_eof)
}


#' @export
#' @title print the first lines of files
#' @description print the first \code{n} lines
#' of a file.
#' @param path file path
#' @param n number of lines to print
#' @param intern a logical which indicates whether to capture
#' the output as an R character vector or to print the output
#' in the R console.
#' @examples
#' f <- system.file(package = "fpeek",
#'   "datafiles", "cigfou-ISO-8859-1.txt")
#' peek_head(f, n = 4)
#' peek_head(f, n = 4, intern = TRUE)
peek_head <- function(path, n = 10, intern = FALSE) {
  if( !intern ) head_print_(path, n)
  else head_str_(path, n)
}


#' @export
#' @title print the last lines of files
#' @description print the last \code{n} lines
#' of a file.
#' @inheritParams peek_head
#' @examples
#' f <- system.file(package = "fpeek",
#'   "datafiles", "cigfou-ISO-8859-1.txt")
#' peek_tail(f, n = 4)
#' peek_tail(f, n = 4, intern = TRUE)
peek_tail <- function(path, n = 10, intern = FALSE) {
  if( !intern ) tail_print_(path, n)
  else tail_str_(path, n)
}


#' @export
#' @title Converts encoding of characters
#' @description Read a file, convert the encoding
#' of characters and print the result.
#' @param path file path
#' @param from the code set in which the input
#' is encoded.
#' @param to the code set to which the output is
#' to be converted.
#' @param newfile result file. Default to NULL. If null the
#' result will be print in the R console, otherwise a
#' file is produced containing the result.
#' @examples
#' la_cigale <- system.file(package = "fpeek", "datafiles",
#'   "cigfou-ISO-8859-1.txt")
#'
#' peek_head(la_cigale)
#' peek_iconv(la_cigale, from = "ISO-8859-1", to = "UTF-8")
#'
#' newfile <- tempfile()
#' peek_iconv(la_cigale, from = "ISO-8859-1", to = "UTF-8",
#'   newfile = newfile)
#' peek_head(newfile, n = 10)
#'
peek_iconv <- function(path, from, to = "UTF-8", newfile = NULL) {
  if( is.null(newfile) ){
    file_iconv_(path, from, to )
  } else {
    file_con <- file( newfile, open = "wt", encoding = to)
    sink(file = file_con)
    file_iconv_(path, from, to )
    sink()
    close(file_con)
    newfile
  }

}



