# Changelog

## fpeek 0.2.0

CRAN release: 2026-02-09

### New features

- New function
  [`peek_guess_delim()`](https://davidgohel.github.io/fpeek/reference/peek_guess_delim.md):
  detect the delimiter, quote character and decimal mark of a delimited
  text file. The algorithm reads the first lines via
  [`peek_head()`](https://davidgohel.github.io/fpeek/reference/peek_head.md)
  and selects the delimiter that produces the most consistent number of
  fields across lines. No additional dependency required.
- New function
  [`peek_guess_encoding()`](https://davidgohel.github.io/fpeek/reference/peek_guess_encoding.md):
  detect the encoding of a text file. Wraps
  [`readr::guess_encoding()`](https://readr.tidyverse.org/reference/encoding.html)
  and returns the best candidate as a character string. Requires the
  ‘readr’ package.

## fpeek 0.1.2

CRAN release: 2021-03-31

- remove LazyData field in DESCRIPTION to solve a note on CRAN check
  page.

## fpeek 0.1.1

CRAN release: 2019-04-16

- update peek_iconv test to skip it when platform charset is not UTF-8
