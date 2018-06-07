
<!-- README.md is generated from README.Rmd. Please edit that file -->

<p align="center">
  <img width="15%" src="http://www.ardata.fr/images/fpeek.svg">
</p>

# fpeek

The goal of fpeek is to help importation of text files from R.

When a text file has unknown characteristics, beeing able to have a
glance at it helps to get those:

  - Use function `file_nlines()` to count lines contained in a file.
  - Functions `file_head_show()` and `file_tail_show()` will display
    first and last lines of the file.

Sometimes encoding is an issue when files generated on a “Windows”
machine has to be used on a “Linux” machine. Function `file_iconv` will
converts file content in one encoding to another encoding.

## Installation

``` r
devtools::install_github("davidgohel/fpeek")
```

## Example

First download an example file, the file is containing lot of times
series about power system and has lot of lines.

``` r
library(fpeek)
power_file <- tempfile(fileext = ".csv")
download.file("https://data.open-power-system-data.org/time_series/2018-03-13/time_series_15min_singleindex.csv", destfile = power_file)
```

### Counting number of lines:

``` r
file_nlines(power_file)
#> [1] 420773
```

### Show first and last lines of a file

The first lines can be printed in the console with function
`file_head_show()`.

``` r
file_head_show(power_file, n = 4)
#> utc_timestamp,cet_cest_timestamp,AT_load_entsoe_transparency,AT_solar_generation_actual,AT_wind_onshore_generation_actual,DE_load_entsoe_transparency,DE_solar_capacity,DE_solar_generation_actual,DE_solar_profile,DE_wind_capacity,DE_wind_generation_actual,DE_wind_profile,DE_wind_offshore_capacity,DE_wind_offshore_generation_actual,DE_wind_offshore_profile,DE_wind_onshore_capacity,DE_wind_onshore_generation_actual,DE_wind_onshore_profile,DE_50hertz_load_entsoe_transparency,DE_50hertz_solar_generation_actual,DE_50hertz_solar_generation_forecast,DE_50hertz_wind_generation_actual,DE_50hertz_wind_generation_forecast,DE_50hertz_wind_offshore_generation_actual,DE_50hertz_wind_offshore_generation_forecast,DE_50hertz_wind_onshore_generation_actual,DE_50hertz_wind_onshore_generation_forecast,DE_AT_LU_load_entsoe_transparency,DE_AT_LU_solar_generation_actual,DE_AT_LU_wind_offshore_generation_actual,DE_AT_LU_wind_onshore_generation_actual,DE_amprion_load_entsoe_transparency,DE_amprion_solar_generation_actual,DE_amprion_solar_generation_forecast,DE_amprion_wind_generation_actual,DE_amprion_wind_generation_forecast,DE_amprion_wind_onshore_generation_actual,DE_tennet_load_entsoe_transparency,DE_tennet_solar_generation_actual,DE_tennet_solar_generation_forecast,DE_tennet_wind_generation_actual,DE_tennet_wind_generation_forecast,DE_tennet_wind_offshore_generation_actual,DE_tennet_wind_onshore_generation_actual,DE_transnetbw_load_entsoe_transparency,DE_transnetbw_solar_generation_actual,DE_transnetbw_solar_generation_forecast,DE_transnetbw_wind_generation_actual,DE_transnetbw_wind_generation_forecast,DE_transnetbw_wind_onshore_generation_actual,HU_load_entsoe_transparency,HU_wind_onshore_generation_actual,LU_load_entsoe_transparency,NL_load_entsoe_transparency,NL_solar_generation_actual,NL_wind_offshore_generation_actual,NL_wind_onshore_generation_actual,interpolated_values
#> 2005-12-31T23:00:00Z,2006-01-01T00:00:00+0100,,,,,2028.0000,,,,,,,,,16394.0000,,,,,,2013.0000,1366.0000,,,,,,,,,,,,,,,,,,1705.0000,1864.0000,0.0000,1705.0000,,,,,,,,,,,,,,
#> 2005-12-31T23:15:00Z,2006-01-01T00:15:00+0100,,,,,2028.0000,,,,,,,,,16394.0000,,,,,,2053.0000,1366.0000,,,,,,,,,,,,,,,,,,1739.0000,1864.0000,0.0000,1739.0000,,,,,,,,,,,,,,
#> 2005-12-31T23:30:00Z,2006-01-01T00:30:00+0100,,,,,2028.0000,,,,,,,,,16394.0000,,,,,,2188.0000,1366.0000,,,,,,,,,,,,,,,,,,1700.0000,1864.0000,0.0000,1700.0000,,,,,,,,,,,,,,
```

`file_head_char()` is also provided to get the first lines as a
character vector.

``` r
file_head_char(power_file, n = 4)
#> [1] "utc_timestamp,cet_cest_timestamp,AT_load_entsoe_transparency,AT_solar_generation_actual,AT_wind_onshore_generation_actual,DE_load_entsoe_transparency,DE_solar_capacity,DE_solar_generation_actual,DE_solar_profile,DE_wind_capacity,DE_wind_generation_actual,DE_wind_profile,DE_wind_offshore_capacity,DE_wind_offshore_generation_actual,DE_wind_offshore_profile,DE_wind_onshore_capacity,DE_wind_onshore_generation_actual,DE_wind_onshore_profile,DE_50hertz_load_entsoe_transparency,DE_50hertz_solar_generation_actual,DE_50hertz_solar_generation_forecast,DE_50hertz_wind_generation_actual,DE_50hertz_wind_generation_forecast,DE_50hertz_wind_offshore_generation_actual,DE_50hertz_wind_offshore_generation_forecast,DE_50hertz_wind_onshore_generation_actual,DE_50hertz_wind_onshore_generation_forecast,DE_AT_LU_load_entsoe_transparency,DE_AT_LU_solar_generation_actual,DE_AT_LU_wind_offshore_generation_actual,DE_AT_LU_wind_onshore_generation_actual,DE_amprion_load_entsoe_transparency,DE_amprion_solar_generation_actual,DE_amprion_solar_generation_forecast,DE_amprion_wind_generation_actual,DE_amprion_wind_generation_forecast,DE_amprion_wind_onshore_generation_actual,DE_tennet_load_entsoe_transparency,DE_tennet_solar_generation_actual,DE_tennet_solar_generation_forecast,DE_tennet_wind_generation_actual,DE_tennet_wind_generation_forecast,DE_tennet_wind_offshore_generation_actual,DE_tennet_wind_onshore_generation_actual,DE_transnetbw_load_entsoe_transparency,DE_transnetbw_solar_generation_actual,DE_transnetbw_solar_generation_forecast,DE_transnetbw_wind_generation_actual,DE_transnetbw_wind_generation_forecast,DE_transnetbw_wind_onshore_generation_actual,HU_load_entsoe_transparency,HU_wind_onshore_generation_actual,LU_load_entsoe_transparency,NL_load_entsoe_transparency,NL_solar_generation_actual,NL_wind_offshore_generation_actual,NL_wind_onshore_generation_actual,interpolated_values"
#> [2] "2005-12-31T23:00:00Z,2006-01-01T00:00:00+0100,,,,,2028.0000,,,,,,,,,16394.0000,,,,,,2013.0000,1366.0000,,,,,,,,,,,,,,,,,,1705.0000,1864.0000,0.0000,1705.0000,,,,,,,,,,,,,,"
#> [3] "2005-12-31T23:15:00Z,2006-01-01T00:15:00+0100,,,,,2028.0000,,,,,,,,,16394.0000,,,,,,2053.0000,1366.0000,,,,,,,,,,,,,,,,,,1739.0000,1864.0000,0.0000,1739.0000,,,,,,,,,,,,,,"
#> [4] "2005-12-31T23:30:00Z,2006-01-01T00:30:00+0100,,,,,2028.0000,,,,,,,,,16394.0000,,,,,,2188.0000,1366.0000,,,,,,,,,,,,,,,,,,1700.0000,1864.0000,0.0000,1700.0000,,,,,,,,,,,,,,"
```

The last lines can be printed in the console with function
`file_tail_show()`.

``` r
file_tail_show(power_file, n = 4)
#> 2017-12-31T23:00:00Z,2018-01-01T00:00:00+0100,5657.6000,0.0000,922.5770,44607.9100,41951.0000,0.0000,0.0000,55790.0000,30955.0000,0.5548,5323.0000,2973.0000,0.5585,50467.0000,27982.0000,0.5545,6476.3300,0.0000,0.0000,10230.6900,9979.4540,186.7680,83.5990,10043.9220,9895.8550,50769.3400,0.0000,2972.8500,28860.5200,17349.8600,0.0000,0.0000,6957.0000,6757.0000,6957.0000,15817.9100,0.0000,0.0000,12679.0000,13097.0000,2786.0000,9893.0000,4963.8100,0.0000,0.0000,1088.0000,1016.0000,1088.0000,4028.8900,78.4900,503.8300,9956.0300,0.0000,849.6100,2654.9400,
#> 2017-12-31T23:15:00Z,2018-01-01T00:15:00+0100,5597.6000,0.0000,931.9630,43777.3000,41951.0000,0.0000,0.0000,55790.0000,31608.0000,0.5666,5323.0000,2991.0000,0.5619,50467.0000,28617.0000,0.5671,6415.8600,0.0000,0.0000,10400.4320,9947.9450,203.9830,82.7620,10196.4490,9865.1830,49844.1800,0.0000,2990.8400,29549.0400,16857.5200,0.0000,0.0000,7046.0000,6850.0000,7046.0000,15618.8700,0.0000,0.0000,13057.0000,13284.0000,2787.0000,10270.0000,4885.0500,0.0000,0.0000,1105.0000,1025.0000,1105.0000,4002.3600,82.5400,469.2800,9856.0100,0.0000,852.6100,2738.7900,
#> 2017-12-31T23:30:00Z,2018-01-01T00:30:00+0100,5596.8000,0.0000,922.9650,43532.3000,41951.0000,0.0000,0.0000,55790.0000,31874.0000,0.5713,5323.0000,2921.0000,0.5487,50467.0000,28953.0000,0.5737,6299.5400,0.0000,0.0000,10393.0210,9918.7440,197.7470,82.0160,10195.2740,9836.7280,49597.5400,0.0000,2920.5600,29908.3100,16715.4600,0.0000,0.0000,7132.0000,6946.0000,7132.0000,15633.5900,0.0000,0.0000,13266.0000,13477.0000,2723.0000,10543.0000,4883.7100,0.0000,0.0000,1083.0000,1033.0000,1083.0000,3965.5900,93.1400,468.4400,9727.4900,0.0000,855.3900,2742.4000,
#> 2017-12-31T23:45:00Z,2018-01-01T00:45:00+0100,5665.6000,0.0000,881.0160,43293.6300,41951.0000,0.0000,0.0000,55790.0000,31873.0000,0.5713,5323.0000,2785.0000,0.5232,50467.0000,29088.0000,0.5764,6275.1900,0.0000,0.0000,10556.6970,9893.5240,189.9090,81.2330,10366.7880,9812.2910,49433.8600,0.0000,2785.0400,30080.3900,16617.8000,0.0000,0.0000,7111.0000,6993.0000,7111.0000,15525.7200,0.0000,0.0000,13139.0000,13652.0000,2595.0000,10544.0000,4874.9200,0.0000,0.0000,1066.0000,1042.0000,1066.0000,3945.0800,105.9100,474.6300,9742.8100,0.0000,861.7700,2749.5000,
```

`file_tail_char()` is also provided to get the last lines as a character
vector.

``` r
file_tail_char(power_file, n = 4)
#> [1] "2017-12-31T23:00:00Z,2018-01-01T00:00:00+0100,5657.6000,0.0000,922.5770,44607.9100,41951.0000,0.0000,0.0000,55790.0000,30955.0000,0.5548,5323.0000,2973.0000,0.5585,50467.0000,27982.0000,0.5545,6476.3300,0.0000,0.0000,10230.6900,9979.4540,186.7680,83.5990,10043.9220,9895.8550,50769.3400,0.0000,2972.8500,28860.5200,17349.8600,0.0000,0.0000,6957.0000,6757.0000,6957.0000,15817.9100,0.0000,0.0000,12679.0000,13097.0000,2786.0000,9893.0000,4963.8100,0.0000,0.0000,1088.0000,1016.0000,1088.0000,4028.8900,78.4900,503.8300,9956.0300,0.0000,849.6100,2654.9400,"  
#> [2] "2017-12-31T23:15:00Z,2018-01-01T00:15:00+0100,5597.6000,0.0000,931.9630,43777.3000,41951.0000,0.0000,0.0000,55790.0000,31608.0000,0.5666,5323.0000,2991.0000,0.5619,50467.0000,28617.0000,0.5671,6415.8600,0.0000,0.0000,10400.4320,9947.9450,203.9830,82.7620,10196.4490,9865.1830,49844.1800,0.0000,2990.8400,29549.0400,16857.5200,0.0000,0.0000,7046.0000,6850.0000,7046.0000,15618.8700,0.0000,0.0000,13057.0000,13284.0000,2787.0000,10270.0000,4885.0500,0.0000,0.0000,1105.0000,1025.0000,1105.0000,4002.3600,82.5400,469.2800,9856.0100,0.0000,852.6100,2738.7900," 
#> [3] "2017-12-31T23:30:00Z,2018-01-01T00:30:00+0100,5596.8000,0.0000,922.9650,43532.3000,41951.0000,0.0000,0.0000,55790.0000,31874.0000,0.5713,5323.0000,2921.0000,0.5487,50467.0000,28953.0000,0.5737,6299.5400,0.0000,0.0000,10393.0210,9918.7440,197.7470,82.0160,10195.2740,9836.7280,49597.5400,0.0000,2920.5600,29908.3100,16715.4600,0.0000,0.0000,7132.0000,6946.0000,7132.0000,15633.5900,0.0000,0.0000,13266.0000,13477.0000,2723.0000,10543.0000,4883.7100,0.0000,0.0000,1083.0000,1033.0000,1083.0000,3965.5900,93.1400,468.4400,9727.4900,0.0000,855.3900,2742.4000," 
#> [4] "2017-12-31T23:45:00Z,2018-01-01T00:45:00+0100,5665.6000,0.0000,881.0160,43293.6300,41951.0000,0.0000,0.0000,55790.0000,31873.0000,0.5713,5323.0000,2785.0000,0.5232,50467.0000,29088.0000,0.5764,6275.1900,0.0000,0.0000,10556.6970,9893.5240,189.9090,81.2330,10366.7880,9812.2910,49433.8600,0.0000,2785.0400,30080.3900,16617.8000,0.0000,0.0000,7111.0000,6993.0000,7111.0000,15525.7200,0.0000,0.0000,13139.0000,13652.0000,2595.0000,10544.0000,4874.9200,0.0000,0.0000,1066.0000,1042.0000,1066.0000,3945.0800,105.9100,474.6300,9742.8100,0.0000,861.7700,2749.5000,"
```

### File reencoding

``` r
la_cigale <- system.file(package = "fpeek", "datafiles", 
  "cigale-ISO-8859-1.txt")
file_head_char(la_cigale, n = 4)
#> [1] "La Cigale et la Fourmi"     ""                          
#> [3] "La Cigale, ayant chant\xe9" "Tout l'\xe9t\xe9,"

file_iconv(la_cigale, from = "WINDOWS-1252", to = "UTF-8")
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

Function `file_iconv()` is converting the content of the file and print
the result in the console. Use `sink()` to create a file:

``` r
file_utf8 <- tempfile()

file_con <- file( file_utf8, open = "wt", encoding = "UTF-8")

sink(file = file_con)
file_iconv(la_cigale, from = "WINDOWS-1252", to = "UTF-8")
sink()

close(file_con)
```

## Comparing speed with other methods:

### `file_nlines`

``` r
library(microbenchmark)

benchmark <- microbenchmark(
  "fpeek::file_nlines" = { file_nlines(power_file) },
  "R.utils::countLines" = { R.utils::countLines(power_file) }, 
  "wc command" = { system(sprintf("wc -l %s", power_file), intern = TRUE) }
  )

benchmark
#> Unit: milliseconds
#>                 expr       min        lq      mean    median        uq
#>   fpeek::file_nlines  292.6669  295.1256  301.8779  296.6848  298.3771
#>  R.utils::countLines 3109.6786 3261.7364 3335.5405 3302.0165 3412.7215
#>           wc command  111.7104  113.1857  116.3097  114.4630  115.3531
#>        max neval
#>   463.9768   100
#>  3719.2635   100
#>   263.4251   100
```

### `file_head_show`

``` r
library(microbenchmark)
benchmark <- microbenchmark(
  "fpeek::file_head_show" = { file_head_show(power_file, n = 5) },
  "base::readLines" = { print(readLines(power_file, n = 5)) }, 
  "head command" = { print(system(sprintf("head -n 5 %s", power_file), intern = TRUE)) }
  )
```

``` r
benchmark
#> Unit: microseconds
#>                   expr      min        lq      mean    median       uq
#>  fpeek::file_head_show   61.772   81.8265  106.8277   97.0545  125.389
#>        base::readLines 1205.106 1238.0100 1271.9673 1262.3895 1299.092
#>           head command 4458.534 4673.5485 4892.2004 4779.9820 5010.116
#>       max neval
#>   364.303   100
#>  1547.858   100
#>  6572.610   100
```
