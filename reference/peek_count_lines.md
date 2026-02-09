# number of lines of a file

return the number of lines found in a file. Operation is counting the
number of new line symbols in the file.

## Usage

``` r
peek_count_lines(path, with_eof = FALSE)
```

## Arguments

- path:

  file path

- with_eof:

  count the end of file as a new line.

## Value

number of lines as an integer

## Examples

``` r
f <- system.file(package = "fpeek",
  "datafiles", "test-tab.csv")
peek_count_lines(f)
#> [1] 4
```
