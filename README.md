
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Travis-CI Build
Status](https://travis-ci.org/davidgohel/fpeek.svg?branch=master)](https://travis-ci.org/davidgohel/fpeek)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/davidgohel/fpeek?branch=master&svg=true)](https://ci.appveyor.com/project/davidgohel/fpeek)
[![version](http://www.r-pkg.org/badges/version/fpeek)](https://CRAN.R-project.org/package=fpeek)
![cranlogs](http://cranlogs.r-pkg.org./badges/fpeek) [![Coverage
status](https://codecov.io/gh/davidgohel/fpeek/branch/master/graph/badge.svg)](https://codecov.io/github/davidgohel/fpeek?branch=master)

<p align="center">

<img width="15%" src="http://www.ardata.fr/images/fpeek.svg">

</p>

## fpeek

The goal of fpeek is to help importation of text files from R.

When a text file has unknown characteristics, beeing able to have a
glance at it helps to get those:

  - Use function `peek_count_lines()` to count lines contained in a
    file.
  - Functions `peek_head()` and `peek_tail()` will display first and
    last lines of the file.

Sometimes encoding is an issue when files generated on a “Windows”
machine has to be used on a “Linux” machine. Function `peek_iconv` will
converts file content in one encoding to another encoding.

Performances are good with large files because operations are made
without reading the entire file before starting.

## Installation

``` r
devtools::install_github("davidgohel/fpeek")
```

## Examples

First download an example file, the file is containing lot of times
series about power system and has lot of lines.

``` r
library(fpeek)
power_file <- "singleindex.csv"
if( !file.exists(power_file))
  download.file(
    "https://data.open-power-system-data.org/time_series/2018-03-13/time_series_15min_singleindex.csv", 
    destfile = power_file)
```

### Counting number of lines:

Using `wc -l`

``` r
system(sprintf("wc -l %s", power_file), intern = TRUE)
#> [1] "  420773 singleindex.csv"
```

Using `peek_count_lines()`

``` r
peek_count_lines(power_file)
#> [1] 420773
```

### Show first and last lines of a file

The first lines can be printed in the console with function
`peek_head()`.

``` r
peek_head(power_file, n = 4)
#> utc_timestamp,cet_cest_timestamp,AT_load_entsoe_transparency,AT_solar_generation_actual,AT_wind_onshore_generation_actual,DE_load_entsoe_transparency,DE_solar_capacity,DE_solar_generation_actual,DE_solar_profile,DE_wind_capacity,DE_wind_generation_actual,DE_wind_profile,DE_wind_offshore_capacity,DE_wind_offshore_generation_actual,DE_wind_offshore_profile,DE_wind_onshore_capacity,DE_wind_onshore_generation_actual,DE_wind_onshore_profile,DE_50hertz_load_entsoe_transparency,DE_50hertz_solar_generation_actual,DE_50hertz_solar_generation_forecast,DE_50hertz_wind_generation_actual,DE_50hertz_wind_generation_forecast,DE_50hertz_wind_offshore_generation_actual,DE_50hertz_wind_offshore_generation_forecast,DE_50hertz_wind_onshore_generation_actual,DE_50hertz_wind_onshore_generation_forecast,DE_AT_LU_load_entsoe_transparency,DE_AT_LU_solar_generation_actual,DE_AT_LU_wind_offshore_generation_actual,DE_AT_LU_wind_onshore_generation_actual,DE_amprion_load_entsoe_transparency,DE_amprion_solar_generation_actual,DE_amprion_solar_generation_forecast,DE_amprion_wind_generation_actual,DE_amprion_wind_generation_forecast,DE_amprion_wind_onshore_generation_actual,DE_tennet_load_entsoe_transparency,DE_tennet_solar_generation_actual,DE_tennet_solar_generation_forecast,DE_tennet_wind_generation_actual,DE_tennet_wind_generation_forecast,DE_tennet_wind_offshore_generation_actual,DE_tennet_wind_onshore_generation_actual,DE_transnetbw_load_entsoe_transparency,DE_transnetbw_solar_generation_actual,DE_transnetbw_solar_generation_forecast,DE_transnetbw_wind_generation_actual,DE_transnetbw_wind_generation_forecast,DE_transnetbw_wind_onshore_generation_actual,HU_load_entsoe_transparency,HU_wind_onshore_generation_actual,LU_load_entsoe_transparency,NL_load_entsoe_transparency,NL_solar_generation_actual,NL_wind_offshore_generation_actual,NL_wind_onshore_generation_actual,interpolated_values
#> 2005-12-31T23:00:00Z,2006-01-01T00:00:00+0100,,,,,2028.0000,,,,,,,,,16394.0000,,,,,,2013.0000,1366.0000,,,,,,,,,,,,,,,,,,1705.0000,1864.0000,0.0000,1705.0000,,,,,,,,,,,,,,
#> 2005-12-31T23:15:00Z,2006-01-01T00:15:00+0100,,,,,2028.0000,,,,,,,,,16394.0000,,,,,,2053.0000,1366.0000,,,,,,,,,,,,,,,,,,1739.0000,1864.0000,0.0000,1739.0000,,,,,,,,,,,,,,
#> 2005-12-31T23:30:00Z,2006-01-01T00:30:00+0100,,,,,2028.0000,,,,,,,,,16394.0000,,,,,,2188.0000,1366.0000,,,,,,,,,,,,,,,,,,1700.0000,1864.0000,0.0000,1700.0000,,,,,,,,,,,,,,
```

The last lines can be printed in the console with function
`peek_tail()`.

``` r
peek_tail(power_file, n = 4)
#> 2017-12-31T23:00:00Z,2018-01-01T00:00:00+0100,5657.6000,0.0000,922.5770,44607.9100,41951.0000,0.0000,0.0000,55790.0000,30955.0000,0.5548,5323.0000,2973.0000,0.5585,50467.0000,27982.0000,0.5545,6476.3300,0.0000,0.0000,10230.6900,9979.4540,186.7680,83.5990,10043.9220,9895.8550,50769.3400,0.0000,2972.8500,28860.5200,17349.8600,0.0000,0.0000,6957.0000,6757.0000,6957.0000,15817.9100,0.0000,0.0000,12679.0000,13097.0000,2786.0000,9893.0000,4963.8100,0.0000,0.0000,1088.0000,1016.0000,1088.0000,4028.8900,78.4900,503.8300,9956.0300,0.0000,849.6100,2654.9400,
#> 2017-12-31T23:15:00Z,2018-01-01T00:15:00+0100,5597.6000,0.0000,931.9630,43777.3000,41951.0000,0.0000,0.0000,55790.0000,31608.0000,0.5666,5323.0000,2991.0000,0.5619,50467.0000,28617.0000,0.5671,6415.8600,0.0000,0.0000,10400.4320,9947.9450,203.9830,82.7620,10196.4490,9865.1830,49844.1800,0.0000,2990.8400,29549.0400,16857.5200,0.0000,0.0000,7046.0000,6850.0000,7046.0000,15618.8700,0.0000,0.0000,13057.0000,13284.0000,2787.0000,10270.0000,4885.0500,0.0000,0.0000,1105.0000,1025.0000,1105.0000,4002.3600,82.5400,469.2800,9856.0100,0.0000,852.6100,2738.7900,
#> 2017-12-31T23:30:00Z,2018-01-01T00:30:00+0100,5596.8000,0.0000,922.9650,43532.3000,41951.0000,0.0000,0.0000,55790.0000,31874.0000,0.5713,5323.0000,2921.0000,0.5487,50467.0000,28953.0000,0.5737,6299.5400,0.0000,0.0000,10393.0210,9918.7440,197.7470,82.0160,10195.2740,9836.7280,49597.5400,0.0000,2920.5600,29908.3100,16715.4600,0.0000,0.0000,7132.0000,6946.0000,7132.0000,15633.5900,0.0000,0.0000,13266.0000,13477.0000,2723.0000,10543.0000,4883.7100,0.0000,0.0000,1083.0000,1033.0000,1083.0000,3965.5900,93.1400,468.4400,9727.4900,0.0000,855.3900,2742.4000,
#> 2017-12-31T23:45:00Z,2018-01-01T00:45:00+0100,5665.6000,0.0000,881.0160,43293.6300,41951.0000,0.0000,0.0000,55790.0000,31873.0000,0.5713,5323.0000,2785.0000,0.5232,50467.0000,29088.0000,0.5764,6275.1900,0.0000,0.0000,10556.6970,9893.5240,189.9090,81.2330,10366.7880,9812.2910,49433.8600,0.0000,2785.0400,30080.3900,16617.8000,0.0000,0.0000,7111.0000,6993.0000,7111.0000,15525.7200,0.0000,0.0000,13139.0000,13652.0000,2595.0000,10544.0000,4874.9200,0.0000,0.0000,1066.0000,1042.0000,1066.0000,3945.0800,105.9100,474.6300,9742.8100,0.0000,861.7700,2749.5000,
```

### File reencoding

``` r
la_cigale <- system.file(package = "fpeek", "datafiles", 
  "cigfou-ISO-8859-1.txt")
peek_head(path = la_cigale, n = 4, intern = TRUE)
#> [1] "La Cigale et la Fourmi"     ""                          
#> [3] "La Cigale, ayant chant\xe9" "Tout l'\xe9t\xe9,"

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
```

Function `peek_iconv()` is converting the content of the file and print
the result in the console. Use `peek_iconv(newfile = "...")` to create a
new reencoded file:

``` r
file_utf8 <- tempfile()
peek_iconv(path = la_cigale, newfile = file_utf8, 
  from = "ISO-8859-1", to = "UTF-8")
#> [1] "/var/folders/51/6jygptvs3bb4njv0t6x7br900000gn/T//Rtmpvi1pq2/filed70f1070c120"
```
