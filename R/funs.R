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
#' file_nlines(f)
file_nlines <- function(path) {
  file_nlines_(path)
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
  file_head_print_(path, n)
}


#' @export
#' @rdname head
file_head_char <- function(path, n = 10) {
  file_head_str_(path, n)
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
  file_tail_print_(path, n)
}
#' @export
#' @rdname tail
file_tail_char <- function(path, n = 10) {
  file_tail_str_(path, n)
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
#' d_ <- system.file(package = "fpeek", "datafiles")
#'
#' file_head_show(file.path(d_, "cigale-ISO-8859-1.txt"))
#' file_iconv(file.path(d_, "cigale-ISO-8859-1.txt"),
#'   from = "ISO-8859-1", to = "UTF-8")
#'
#' file_head_show(file.path(d_, "Windows_1252.txt"))
#' file_iconv(file.path(d_, "Windows_1252.txt"),
#'            from = "WINDOWS-1252", to = "UTF-8")
#'
#' file_head_show(file.path(d_, "UTF16_BE.txt"))
#' file_iconv(file.path(d_, "UTF16_BE.txt"),
#'            from = "UTF-16", to = "UTF-8")
file_iconv <- function(path, from, to = "UTF-8") {
  file_iconv_(path, from, to )
}


