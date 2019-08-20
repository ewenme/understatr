
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
get_leagues_meta()
```

    ## # A tibble: 36 x 4
    ##    league_name  year season    url                                      
    ##    <chr>       <dbl> <chr>     <chr>                                    
    ##  1 EPL          2019 2019/2020 https://understat.com/league/EPL/2019    
    ##  2 EPL          2018 2018/2019 https://understat.com/league/EPL/2018    
    ##  3 EPL          2017 2017/2018 https://understat.com/league/EPL/2017    
    ##  4 EPL          2016 2016/2017 https://understat.com/league/EPL/2016    
    ##  5 EPL          2015 2015/2016 https://understat.com/league/EPL/2015    
    ##  6 EPL          2014 2014/2015 https://understat.com/league/EPL/2014    
    ##  7 La liga      2019 2019/2020 https://understat.com/league/La liga/2019
    ##  8 La liga      2018 2018/2019 https://understat.com/league/La liga/2018
    ##  9 La liga      2017 2017/2018 https://understat.com/league/La liga/2017
    ## 10 La liga      2016 2016/2017 https://understat.com/league/La liga/2016
    ## # … with 26 more rows

### Get stats for a team’s playing squad in a league season:

``` r
get_team_players_stats(team_name = "Manchester City", year = 2018)
```

    ## # A tibble: 21 x 19
    ##    player_id player_name games  time goals    xG assists     xA shots
    ##        <int> <chr>       <int> <int> <int> <dbl>   <int>  <dbl> <int>
    ##  1       619 Sergio Agü…    33  2515    21 19.9        8  5.23    118
    ##  2       618 Raheem Ste…    34  2788    17 15.9       10 10.8      77
    ##  3       337 Leroy Sané     31  1866    10  6.98      10  8.10     56
    ##  4       750 Riyad Mahr…    27  1333     7  6.62       4  5.01     54
    ##  5      3635 Bernardo S…    36  2851     7  8.20       7  8.63     62
    ##  6      5543 Gabriel Je…    29   993     7 12.6        3  2.65     43
    ##  7       314 Ilkay Günd…    31  2133     6  4.21       3  4.97     43
    ##  8       617 David Silva    33  2426     6  8.13       8 10.1      51
    ##  9      2498 Aymeric La…    35  3059     3  3.75       3  0.839    26
    ## 10       447 Kevin De B…    19   965     2  1.47       2  6.65     31
    ## # … with 11 more rows, and 10 more variables: key_passes <int>,
    ## #   yellow_cards <int>, red_cards <int>, position <chr>, team_name <chr>,
    ## #   npg <int>, npxG <dbl>, xGChain <dbl>, xGBuildup <dbl>, year <int>

### Get stats for a player across all seasons:

``` r
get_player_seasons_stats(player_id = 618)
```

    ## # A tibble: 6 x 19
    ##   position games goals shots  time    xG assists     xA key_passes  year
    ##   <chr>    <int> <int> <int> <int> <dbl>   <int>  <dbl>      <int> <int>
    ## 1 FWL          2     4    10   180  2.47       0  0.169          2  2019
    ## 2 AML         34    17    77  2788 15.9       10 10.8           66  2018
    ## 3 Sub         33    18    87  2594 18.8       11  8.84          55  2017
    ## 4 AMR         33     7    64  2532  8.11       6  5.50          46  2016
    ## 5 AML         31     6    52  1943  7.15       2  3.25          35  2015
    ## 6 AML         35     7    84  3059  8.79       7  6.04          75  2014
    ## # … with 9 more variables: team_name <chr>, yellow <int>, red <int>,
    ## #   npg <int>, npxG <dbl>, xGChain <dbl>, xGBuildup <dbl>,
    ## #   player_id <int>, player_name <chr>

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
