
# understatr <img src="man/figures/logo.png" alt="" width="120" align="right" />

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R-CMD-check](https://github.com/ewenme/understatr/workflows/R-CMD-check/badge.svg)](https://github.com/ewenme/understatr/actions)

## Overview

An R package to help with retrieving tidy
[understat](https://understat.com/) data.

## Install

`understatr` is not likely to be submitted to CRAN. Get the latest
development version from GitHub:

``` r
remotes::install_github('ewenme/understatr')
```

## Use

``` r
library(understatr)
```

### Check currently available leagues/seasons:

``` r
get_leagues_meta()
#> # A tibble: 48 × 4
#>    league_name  year season    url                                        
#>    <chr>       <dbl> <chr>     <chr>                                      
#>  1 EPL          2021 2021/2022 https://understat.com/league/EPL/2021      
#>  2 EPL          2020 2020/2021 https://understat.com/league/EPL/2020      
#>  3 EPL          2019 2019/2020 https://understat.com/league/EPL/2019      
#>  4 EPL          2018 2018/2019 https://understat.com/league/EPL/2018      
#>  5 EPL          2017 2017/2018 https://understat.com/league/EPL/2017      
#>  6 EPL          2016 2016/2017 https://understat.com/league/EPL/2016      
#>  7 EPL          2015 2015/2016 https://understat.com/league/EPL/2015      
#>  8 EPL          2014 2014/2015 https://understat.com/league/EPL/2014      
#>  9 La liga      2021 2021/2022 https://understat.com/league/La%20liga/2021
#> 10 La liga      2020 2020/2021 https://understat.com/league/La%20liga/2020
#> # … with 38 more rows
```

### Get stats for a team’s playing squad in a league season:

``` r
get_team_players_stats(team_name = "Manchester City", year = 2018)
#> 
#> ── Column specification ────────────────────────────────────────────────────────
#> cols(
#>   player_id = col_double(),
#>   player_name = col_character(),
#>   games = col_double(),
#>   time = col_double(),
#>   goals = col_double(),
#>   xG = col_double(),
#>   assists = col_double(),
#>   xA = col_double(),
#>   shots = col_double(),
#>   key_passes = col_double(),
#>   yellow_cards = col_double(),
#>   red_cards = col_double(),
#>   position = col_character(),
#>   team_name = col_character(),
#>   npg = col_double(),
#>   npxG = col_double(),
#>   xGChain = col_double(),
#>   xGBuildup = col_double()
#> )
#> # A tibble: 21 × 19
#>    player_id player_name     games  time goals    xG assists     xA shots key_passes
#>        <dbl> <chr>           <dbl> <dbl> <dbl> <dbl>   <dbl>  <dbl> <dbl>      <dbl>
#>  1       619 Sergio Agüero      33  2515    21 19.9        8  5.23    118         34
#>  2       618 Raheem Sterling    34  2788    17 15.9       10 10.8      77         66
#>  3       337 Leroy Sané         31  1866    10  6.98      10  8.10     56         40
#>  4       750 Riyad Mahrez       27  1333     7  6.62       4  5.01     54         24
#>  5      3635 Bernardo Silva     36  2851     7  8.20       7  8.63     62         71
#>  6      5543 Gabriel Jesus      29   993     7 12.6        3  2.65     43         21
#>  7       314 Ilkay Gündogan     31  2133     6  4.21       3  4.97     43         43
#>  8       617 David Silva        33  2426     6  8.13       8 10.1      51         73
#>  9      2498 Aymeric Laporte    35  3059     3  3.75       3  0.839    26         13
#> 10       447 Kevin De Bruyne    19   965     2  1.47       2  6.65     31         36
#> # … with 11 more rows, and 9 more variables: yellow_cards <dbl>,
#> #   red_cards <dbl>, position <chr>, team_name <chr>, npg <dbl>, npxG <dbl>,
#> #   xGChain <dbl>, xGBuildup <dbl>, year <dbl>
```

### Get stats for a player across all seasons:

``` r
get_player_seasons_stats(player_id = 618)
#> 
#> ── Column specification ────────────────────────────────────────────────────────
#> cols(
#>   position = col_character(),
#>   games = col_double(),
#>   goals = col_double(),
#>   shots = col_double(),
#>   time = col_double(),
#>   xG = col_double(),
#>   assists = col_double(),
#>   xA = col_double(),
#>   key_passes = col_double(),
#>   year = col_double(),
#>   team_name = col_character(),
#>   yellow = col_double(),
#>   red = col_double(),
#>   npg = col_double(),
#>   npxG = col_double(),
#>   xGChain = col_double(),
#>   xGBuildup = col_double(),
#>   player_name = col_character()
#> )
#> # A tibble: 8 × 19
#>   position games goals shots  time    xG assists     xA key_passes  year
#>   <chr>    <dbl> <dbl> <dbl> <dbl> <dbl>   <dbl>  <dbl>      <dbl> <dbl>
#> 1 FWL          3     1     7   128  1.71       0  0.111          1  2021
#> 2 AML         31    10    70  2539 12.1        7  6.63          39  2020
#> 3 FWL         33    20   100  2678 19.8        1  7.21          48  2019
#> 4 AML         34    17    77  2788 15.9       10 10.8           66  2018
#> 5 Sub         33    18    87  2594 18.8       11  8.84          55  2017
#> 6 AMR         33     7    64  2532  8.11       6  5.50          46  2016
#> 7 AML         31     6    52  1943  7.15       2  3.25          35  2015
#> 8 AML         35     7    84  3059  8.79       7  6.04          75  2014
#> # … with 9 more variables: team_name <chr>, yellow <dbl>, red <dbl>, npg <dbl>,
#> #   npxG <dbl>, xGChain <dbl>, xGBuildup <dbl>, player_id <dbl>,
#> #   player_name <chr>
```

## Issues

If you encounter a clear bug, please file a minimal reproducible example
on [GitHub](https://github.com/ewenme/understatr/issues). For questions
and other discussion, try [stackoverflow](https://stackoverflow.com/) or
[e-mail](ewenhenderson@gmail.com).

## Disclaimer

While there is no official notice on the site condoning web scraping
activity, Understat’s [support](support@understat.com) have previously
confirmed (via e-mail exchange, 8th November 2018) that their data is
free to use for non-commercial purposes. This stance is subject to
change.

Also, be polite and attribute the source.

------------------------------------------------------------------------

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree
to abide by its terms.
