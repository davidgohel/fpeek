context("count lines")


test_that("ckeck number of lines", {
  f <- system.file(package = "fpeek", "datafiles", "cigale-ISO-8859-1.txt")
  testthat::expect_equal(wc_l(f), 24)
  testthat::expect_equal(wc_l(f, with_eof = TRUE), 25)

  f <- system.file(package = "fpeek", "datafiles", "Windows_1252.txt")
  testthat::expect_equal(wc_l(f), 0)
  testthat::expect_equal(wc_l(f, with_eof = TRUE), 1)
})

