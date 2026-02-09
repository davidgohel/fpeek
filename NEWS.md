# fpeek 0.2.0


## New features

* New function `peek_guess_delim()`: detect the delimiter, quote character
  and decimal mark of a delimited text file. The algorithm reads the first
  lines via `peek_head()` and selects the delimiter that produces the most
  consistent number of fields across lines. No additional dependency required.
* New function `peek_guess_encoding()`: detect the encoding of a text file.
  Wraps `readr::guess_encoding()` and returns the best candidate as a
  character string. Requires the 'readr' package.

# fpeek 0.1.2

* remove LazyData field in DESCRIPTION to solve a note on CRAN check page.

# fpeek 0.1.1

* update peek_iconv test to skip it when platform charset is not UTF-8
