#' @useDynLib fpeek
#' @importFrom Rcpp sourceCpp
#' @export
#' @title number of lines of a file
#' @description return the number of lines
#' found in a file.
#' @param path file path
#' @return number of lines as an integer
#' @examples
#' f <- system.file(package = "fpeek",
#'   "datafiles", "cigale-ISO-8859-1.txt")
#' wc_l(f)
wc_l <- function(path) {
  nlines_(path)
}

#' @export
#' @title grep a file and print the results
#' @description print lines
#' of a file matching a regular expression.
#' @param path file path
#' @param regexp regular expression as a string
#' @examples
#' f <- system.file(package = "fpeek",
#'                  "datafiles", "cigale-ISO-8859-1.txt")
#' file_grep_show(f, regexp = "([C|c]igale|fut)")
#' file_grep_show(f, regexp = "[^i]er")
#' @rdname grep
#' @aliases grep file_grep
file_grep_show <- function(path, regexp) {
  grep_print_(path, regexp)
}


#' @export
#' @title print the first lines of files
#' @description print the first \code{n} lines
#' of a file.
#' @param path file path
#' @param n number of lines to print
#' @examples
#' f <- system.file(package = "fpeek",
#'   "datafiles", "cigale-ISO-8859-1.txt")
#' file_head_show(f, n = 4)
#' file_head_char(f, n = 4)
#' @rdname head
#' @aliases head file_head
file_head_show <- function(path, n = 10) {
  head_print_(path, n)
}


#' @export
#' @rdname head
file_head_char <- function(path, n = 10) {
  head_str_(path, n)
}

#' @export
#' @title print the last lines of files
#' @description print the last \code{n} lines
#' of a file.
#' @param path file path
#' @param n number of lines to print
#' @examples
#' f <- system.file(package = "fpeek",
#'   "datafiles", "cigale-ISO-8859-1.txt")
#' file_tail_show(f, n = 4)
#' file_tail_char(f, n = 4)
#' @rdname tail
#' @aliases tail file_tail
file_tail_show <- function(path, n = 10) {
  tail_print_(path, n)
}
#' @export
#' @rdname tail
file_tail_char <- function(path, n = 10) {
  tail_str_(path, n)
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
#' @examples
#' la_cigale <- system.file(package = "fpeek", "datafiles",
#'   "cigale-ISO-8859-1.txt")
#'
#' file_head_show(la_cigale)
#' file_iconv_show(la_cigale, from = "ISO-8859-1", to = "UTF-8")
#'
#' file <- system.file(package = "fpeek", "datafiles",
#'   "Windows_1252.txt")
#' file_head_show(file)
#' file_iconv_show(file, from = "WINDOWS-1252", to = "UTF-8")
#'
#' file <- system.file(package = "fpeek", "datafiles",
#'   "UTF16_BE.txt")
#' file_head_show(file)
#' file_iconv_show(file, from = "UTF-16", to = "UTF-8")
#' @rdname iconv
#' @aliases iconv file_iconv
file_iconv_show <- function(path, from, to = "UTF-8") {
  file_iconv_(path, from, to )
}

#' @export
#' @rdname iconv
#' @param newfile result file
#' @examples
#' la_cigale <- system.file(package = "fpeek", "datafiles",
#'   "cigale-ISO-8859-1.txt")
#'
#' file_utf8 <- tempfile()
#' file_iconv_write(path = la_cigale, newfile = file_utf8,
#'   from = "WINDOWS-1252", to = "UTF-8")
#'
file_iconv_write <- function(path, newfile, from, to = "UTF-8") {

  file_con <- file( newfile, open = "wt", encoding = to)
  sink(file = file_con)
  file_iconv_show(path, from = from, to = to)
  sink()
  close(file_con)
  newfile
}


#' @export
#' @title print the last lines of files
#' @description print the last \code{n} lines
#' of a file.
#' @param path file path
#' @param n number of lines to print
#' @examples
#' if( interactive() ){
#'   f <- system.file(package = "fpeek",
#'     "datafiles", "cigale-ISO-8859-1.txt")
#'   less_show(f)
#' }
#' @section commands:
#'
#' type \code{q} to quit.
#'
#' type any key to see next lines.
#'
#' type \code{p} to see previous lines (not implemented yet).
#' @rdname less
#' @aliases less file_less
less_show <- function(path, n = 6) {
  stopifnot(interactive())
  less_(path, n)
}

