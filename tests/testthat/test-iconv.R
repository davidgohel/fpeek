context("iconv tests")

file <- system.file(package = "fpeek", "datafiles", "cigfou-ISO-8859-1.txt")

has_locale <- Sys.which("locale") != ""
is_utf_8 <- has_locale && (system(command = "locale charmap", intern = TRUE) == "UTF-8")
test_that("ckeck head output", {
  skip_on_os("windows")

  skip_if_not( is_utf_8 )

  file_utf8 <- tempfile()
  peek_iconv(path = file, newfile = file_utf8, from = "ISO-8859-1", to = "UTF-8")

  content <- c("La Cigale et la Fourmi", "", "La Cigale, ayant chanté",
               "Tout l'été,", "Se trouva fort dépourvue")

  expect_output(peek_head(file_utf8, n = 5), paste(content, collapse = "\n") )
})

