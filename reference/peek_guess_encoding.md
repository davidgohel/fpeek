# Guess File Encoding

Detect the encoding of a text file. This function is a wrapper around
[`guess_encoding`](https://readr.tidyverse.org/reference/encoding.html)
from the `readr` package, returning the best candidate as a character
string.

`readr` must be installed (it is listed in `Suggests`). If it is not
available, the function stops with an informative message.

## Usage

``` r
peek_guess_encoding(path)
```

## Arguments

- path:

  path to the text file.

## Value

a character string giving the most likely encoding.

## Examples

``` r
if (FALSE) { # \dontrun{
f <- system.file(package = "fpeek",
  "datafiles", "cigfou-ISO-8859-1.txt")
peek_guess_encoding(f)
} # }
```
