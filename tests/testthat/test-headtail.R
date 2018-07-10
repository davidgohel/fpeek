context("head tail tests")

file <- system.file(package = "fpeek", "datafiles", "cigfou-ISO-8859-1.txt")
file_utf8 <- tempfile()
peek_iconv(path = file, newfile = file_utf8, from = "ISO-8859-1", to = "UTF-8")

test_that("ckeck head output", {

  expect_output(peek_head(file_utf8, n = 1), regexp = "La Cigale et la Fourmi")
  expect_equal(peek_head(file_utf8, n = 1, intern = TRUE),  "La Cigale et la Fourmi")

})

test_that("ckeck tail output", {

  expect_output(peek_tail(file_utf8, n = 1), regexp = "Eh bien! dansez maintenant.")
  expect_equal(peek_tail(file_utf8, n = 1, intern = TRUE),  "Eh bien! dansez maintenant.")

})

