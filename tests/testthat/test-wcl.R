context("count lines")

f1 <- system.file(package = "fpeek", "datafiles", "cigfou-ISO-8859-1.txt")
f2 <- system.file(package = "fpeek", "datafiles", "ISO-8859-1.txt")

test_that("ckeck number of lines without eof", {
  expect_equal(peek_count_lines(f1), 24)
  expect_equal(peek_count_lines(f2), 0)
})

test_that("ckeck number of lines with eof", {
  expect_equal(peek_count_lines(f1, with_eof = TRUE), 25)
  expect_equal(peek_count_lines(f2, with_eof = TRUE), 1)
})

