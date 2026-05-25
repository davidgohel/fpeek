# Guess Delimited File Parameters

Guess the delimiter, quote character and decimal mark of a delimited
text file. The function splits each of the first `n` lines by each
candidate delimiter and selects the delimiter that produces the most
consistent number of fields.

The algorithm is adapted from the vroom package.

## Usage

``` r
peek_guess_delim(
  path,
  delims = c(",", "\t", " ", "|", ":", ";"),
  quotes = c("\"", "'"),
  n = 1024
)
```

## Arguments

- path:

  path to the text file.

- delims:

  character vector of candidate delimiters.

- quotes:

  character vector of candidate quote characters.

- n:

  number of lines to read for guessing (default 1024).

## Value

a named list with elements:

- delim:

  the guessed delimiter character (or `NULL`)

- quote:

  the guessed quote character (or `NULL`)

- decimal_mark:

  the guessed decimal mark (or `NULL`)

## Examples

``` r
f <- system.file(package = "fpeek",
  "datafiles", "test-comma.csv")
peek_guess_delim(f)
#> $delim
#> [1] ","
#> 
#> $quote
#> [1] "\""
#> 
#> $decimal_mark
#> [1] "."
#> 

f <- system.file(package = "fpeek",
  "datafiles", "test-semicolon.csv")
peek_guess_delim(f)
#> $delim
#> [1] ";"
#> 
#> $quote
#> [1] "\""
#> 
#> $decimal_mark
#> [1] ","
#> 
```
