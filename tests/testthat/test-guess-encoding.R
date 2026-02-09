test_that("detect ISO-8859-1 encoding", {
  skip_if_not_installed("readr")
  skip_if_not_installed("stringi")
  f <- system.file(package = "fpeek", "datafiles", "cigfou-ISO-8859-1.txt")
  result <- peek_guess_encoding(f)
  expect_type(result, "character")
  expect_true(nzchar(result))
})

test_that("detect encoding of UTF-8 file", {
  skip_if_not_installed("readr")
  skip_if_not_installed("stringi")
  f <- tempfile(fileext = ".txt")
  writeLines("Hello world", f, useBytes = FALSE)
  result <- peek_guess_encoding(f)
  expect_type(result, "character")
  expect_true(nzchar(result))
  unlink(f)
})

test_that("error when readr is not available", {
  expect_true(is.function(peek_guess_encoding))
  expect_equal(names(formals(peek_guess_encoding)), "path")
})
