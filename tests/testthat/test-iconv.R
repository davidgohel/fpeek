context("iconv tests")

file <- system.file(package = "fpeek", "datafiles", "cigale-ISO-8859-1.txt")

test_that("ckeck head output", {

  file_utf8 <- tempfile()
  file_iconv_write(path = file, newfile = file_utf8, from = "WINDOWS-1252", to = "UTF-8")

  content <- c("La Cigale et la Fourmi", "", "La Cigale, ayant chanté",
               "Tout l'été,", "Se trouva fort dépourvue")

  expect_output(file_head_show(file_utf8, n = 5), paste(content, collapse = "\n") )
})

