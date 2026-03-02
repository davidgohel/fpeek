# Converts encoding of characters

Read a file, convert the encoding of characters and print the result.

## Usage

``` r
peek_iconv(path, from, to = "UTF-8", newfile = NULL)
```

## Arguments

- path:

  file path

- from:

  the code set in which the input is encoded.

- to:

  the code set to which the output is to be converted.

- newfile:

  result file. Default to NULL. If null the result will be print in the
  R console, otherwise a file is produced containing the result.

## Examples

``` r
la_cigale <- system.file(package = "fpeek", "datafiles",
  "cigfou-ISO-8859-1.txt")

peek_iconv(la_cigale, from = "ISO-8859-1", to = "UTF-8")
#> La Cigale et la Fourmi
#> 
#> La Cigale, ayant chanté
#> Tout l'été,
#> Se trouva fort dépourvue
#> Quand la bise fut venue :
#> Pas un seul petit morceau
#> De mouche ou de vermisseau.
#> Elle alla crier famine
#> Chez la Fourmi sa voisine,
#> La priant de lui prêter
#> Quelque grain pour subsister
#> Jusqu'à la saison nouvelle.
#> Je vous paierai, lui dit-elle,
#> Avant l'Oût, foi d'animal,
#> Intérêt et principal. 
#> La Fourmi n'est pas prêteuse :
#> C'est là son moindre défaut.
#> Que faisiez-vous au temps chaud ?
#> Dit-elle à cette emprunteuse.
#> Nuit et jour à tout venant
#> Je chantais, ne vous déplaise.
#> Vous chantiez ? j'en suis fort aise.
#> Eh bien! dansez maintenant.

newfile <- tempfile()
peek_iconv(la_cigale, from = "ISO-8859-1", to = "UTF-8",
  newfile = newfile)
#> [1] "/tmp/RtmpL41u1X/file1ad725045484"
peek_head(newfile, n = 10)
#> La Cigale et la Fourmi
#> 
#> La Cigale, ayant chanté
#> Tout l'été,
#> Se trouva fort dépourvue
#> Quand la bise fut venue :
#> Pas un seul petit morceau
#> De mouche ou de vermisseau.
#> Elle alla crier famine
#> Chez la Fourmi sa voisine,
```
