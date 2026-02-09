test_that("detect comma delimiter", {
  f <- system.file(package = "fpeek", "datafiles", "test-comma.csv")
  result <- peek_guess_delim(f)
  expect_equal(result$delim, ",")
  expect_equal(result$quote, "\"")
  expect_equal(result$decimal_mark, ".")
})

test_that("detect semicolon delimiter", {
  f <- system.file(package = "fpeek", "datafiles", "test-semicolon.csv")
  result <- peek_guess_delim(f)
  expect_equal(result$delim, ";")
  expect_equal(result$quote, "\"")
  expect_equal(result$decimal_mark, ",")
})

test_that("detect tab delimiter", {
  f <- system.file(package = "fpeek", "datafiles", "test-tab.csv")
  result <- peek_guess_delim(f)
  expect_equal(result$delim, "\t")
  expect_equal(result$quote, "\"")
})

test_that("detect pipe delimiter", {
  f <- system.file(package = "fpeek", "datafiles", "test-pipe.csv")
  result <- peek_guess_delim(f)
  expect_equal(result$delim, "|")
  expect_equal(result$quote, "\"")
})

test_that("empty file returns NULLs", {
  f <- tempfile(fileext = ".csv")
  writeLines(character(0), f)
  result <- peek_guess_delim(f)
  expect_null(result$delim)
  expect_null(result$quote)
  expect_null(result$decimal_mark)
  unlink(f)
})

test_that("single column file returns NULLs", {
  f <- tempfile(fileext = ".csv")
  writeLines(c("a", "b", "c"), f)
  result <- peek_guess_delim(f)
  expect_null(result$delim)
  expect_null(result$quote)
  expect_null(result$decimal_mark)
  unlink(f)
})

test_that("result is a named list", {
  f <- system.file(package = "fpeek", "datafiles", "test-comma.csv")
  result <- peek_guess_delim(f)
  expect_type(result, "list")
  expect_named(result, c("delim", "quote", "decimal_mark"))
})
