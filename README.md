
# understatr <img alt="understatr Logo" title="discogger" align="right" src="man/figures/understatr_logo.png" width="100" style="float:right;width:100px;"/>

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
status](https://travis-ci.org/ewenme/understatr.svg?branch=master)](https://travis-ci.org/ewenme/understatr)

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
get_league_meta()
```

    ## # A tibble: 30 x 4
    ##    league_name year  season    url                                      
    ##    <chr>       <chr> <chr>     <chr>                                    
    ##  1 EPL         2018  2018/2019 https://understat.com/league/EPL/2018    
    ##  2 EPL         2017  2017/2018 https://understat.com/league/EPL/2017    
    ##  3 EPL         2016  2016/2017 https://understat.com/league/EPL/2016    
    ##  4 EPL         2015  2015/2016 https://understat.com/league/EPL/2015    
    ##  5 EPL         2014  2014/2015 https://understat.com/league/EPL/2014    
    ##  6 La liga     2018  2018/2019 https://understat.com/league/La_liga/2018
    ##  7 La liga     2017  2017/2018 https://understat.com/league/La_liga/2017
    ##  8 La liga     2016  2016/2017 https://understat.com/league/La_liga/2016
    ##  9 La liga     2015  2015/2016 https://understat.com/league/La_liga/2015
    ## 10 La liga     2014  2014/2015 https://understat.com/league/La_liga/2014
    ## # ... with 20 more rows

### Get stats for a team’s playing squad in a league season:

``` r
get_team_squad_stats(team_name = "Manchester City", year = 2018)
```

    ## # A tibble: 21 x 20
    ##    team_name  year player_name player_id games time  goals xG    assists
    ##  * <chr>     <dbl> <chr>       <chr>     <chr> <chr> <chr> <chr> <chr>  
    ##  1 Manchest…  2018 Raheem Ste… 618       13    1126  8     6.59… 6      
    ##  2 Manchest…  2018 Sergio Agü… 619       13    986   8     8.76… 4      
    ##  3 Manchest…  2018 Leroy Sané  337       14    821   6     4.91… 5      
    ##  4 Manchest…  2018 David Silva 617       14    1094  5     4.40… 2      
    ##  5 Manchest…  2018 Riyad Mahr… 750       15    753   5     4.56… 2      
    ##  6 Manchest…  2018 Bernardo S… 3635      15    1233  4     3.45… 3      
    ##  7 Manchest…  2018 Ilkay Günd… 314       11    568   3     2.29… 2      
    ##  8 Manchest…  2018 Fernandinho 614       16    1418  1     0.95… 2      
    ##  9 Manchest…  2018 Kyle Walker 638       13    1170  1     0.22… 0      
    ## 10 Manchest…  2018 Aymeric La… 2498      16    1351  1     1.56… 0      
    ## # ... with 11 more rows, and 11 more variables: xA <chr>, shots <chr>,
    ## #   key_passes <chr>, yellow_cards <chr>, red_cards <chr>, position <chr>,
    ## #   team_name.1 <chr>, npg <chr>, npxG <chr>, xGChain <chr>,
    ## #   xGBuildup <chr>

### Get stats for a player across all seasons:

``` r
get_player_season_stats(player_id = 618)
```

    ## # A tibble: 5 x 18
    ##   player_name player_id team_name year  games goals shots time  xG   
    ## * <chr>           <dbl> <chr>     <chr> <chr> <chr> <chr> <chr> <chr>
    ## 1 Raheem Ste…       618 Manchest… 2018  13    8     32    1126  6.59…
    ## 2 Raheem Ste…       618 Manchest… 2017  33    18    87    2594  18.8…
    ## 3 Raheem Ste…       618 Manchest… 2016  33    7     64    2532  8.10…
    ## 4 Raheem Ste…       618 Manchest… 2015  31    6     52    1943  7.14…
    ## 5 Raheem Ste…       618 Liverpool 2014  35    7     84    3059  8.78…
    ## # ... with 9 more variables: assists <chr>, xA <chr>, key_passes <chr>,
    ## #   yellow <chr>, red <chr>, npg <chr>, npxG <chr>, xGChain <chr>,
    ## #   xGBuildup <chr>

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

-----

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree
to abide by its terms.
