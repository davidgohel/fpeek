context("head tail tests")

file <- system.file(package = "fpeek", "datafiles", "cigale-ISO-8859-1.txt")

test_that("ckeck head output", {

  expect_output(file_head_show(file, n = 1), regexp = "La Cigale et la Fourmi")
  expect_equal(file_head_char(file, n = 1),  "La Cigale et la Fourmi")

})

test_that("ckeck tail output", {

  expect_output(file_tail_show(file, n = 1), regexp = "Eh bien! dansez maintenant.")
  expect_equal(file_tail_char(file, n = 1),  "Eh bien! dansez maintenant.")

})

