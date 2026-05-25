# print the first lines of files

print the first `n` lines of a file.

## Usage

``` r
peek_head(path, n = 10, intern = FALSE)
```

## Arguments

- path:

  file path

- n:

  number of lines to print

- intern:

  a logical which indicates whether to capture the output as an R
  character vector or to print the output in the R console.

## Examples

``` r
f <- system.file(package = "fpeek",
  "datafiles", "test-tab.csv")
peek_head(f, n = 4)
#> name age city
#> "Alice"  30  "New York"
#> "Bob"    25  "Los Angeles"
#> "Charlie"    35  "Chicago"
peek_head(f, n = 4, intern = TRUE)
#> [1] "name\tage\tcity"              "\"Alice\"\t30\t\"New York\"" 
#> [3] "\"Bob\"\t25\t\"Los Angeles\"" "\"Charlie\"\t35\t\"Chicago\""
```
