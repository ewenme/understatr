
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

    ## # A tibble: 30 x 4
    ##    league_name  year season    url                                      
    ##    <chr>       <dbl> <chr>     <chr>                                    
    ##  1 EPL          2018 2018/2019 https://understat.com/league/EPL/2018    
    ##  2 EPL          2017 2017/2018 https://understat.com/league/EPL/2017    
    ##  3 EPL          2016 2016/2017 https://understat.com/league/EPL/2016    
    ##  4 EPL          2015 2015/2016 https://understat.com/league/EPL/2015    
    ##  5 EPL          2014 2014/2015 https://understat.com/league/EPL/2014    
    ##  6 La liga      2018 2018/2019 https://understat.com/league/La liga/2018
    ##  7 La liga      2017 2017/2018 https://understat.com/league/La liga/2017
    ##  8 La liga      2016 2016/2017 https://understat.com/league/La liga/2016
    ##  9 La liga      2015 2015/2016 https://understat.com/league/La liga/2015
    ## 10 La liga      2014 2014/2015 https://understat.com/league/La liga/2014
    ## # … with 20 more rows

### Get stats for a team’s playing squad in a league season:

``` r
get_team_players_stats(team_name = "Manchester City", year = 2018)
```

    ## # A tibble: 21 x 19
    ##    player_id player_name games  time goals     xG assists    xA shots
    ##        <int> <chr>       <int> <int> <int>  <dbl>   <int> <dbl> <int>
    ##  1       618 Raheem Ste…    20  1670    10  9.16        7 7.23     40
    ##  2       619 Sergio Agü…    19  1381    10 10.9         6 3.66     68
    ##  3       337 Leroy Sané     21  1313     8  5.89        9 6.68     40
    ##  4       617 David Silva    19  1363     6  5.41        2 6.24     33
    ##  5       750 Riyad Mahr…    19   941     5  5.14        2 2.43     35
    ##  6      3635 Bernardo S…    22  1782     5  4.76        6 4.90     32
    ##  7      5543 Gabriel Je…    17   767     5  7.63        2 2.49     30
    ##  8       314 Ilkay Günd…    17   957     4  3.20        2 2.59     24
    ##  9       447 Kevin De B…     8   298     1  0.191       0 0.885     7
    ## 10       614 Fernandinho    21  1839     1  1.40        3 2.45     25
    ## # … with 11 more rows, and 10 more variables: key_passes <int>,
    ## #   yellow_cards <int>, red_cards <int>, position <chr>, team_name <chr>,
    ## #   npg <int>, npxG <dbl>, xGChain <dbl>, xGBuildup <dbl>, year <int>

### Get stats for a player across all seasons:

``` r
get_player_seasons_stats(player_id = 618)
```

    ## # A tibble: 5 x 19
    ##   position games goals shots  time    xG assists    xA key_passes  year
    ##   <chr>    <int> <int> <int> <int> <dbl>   <int> <dbl>      <int> <int>
    ## 1 AML         20    10    40  1670  9.16       7  7.23         44  2018
    ## 2 Sub         33    18    87  2594 18.8       11  8.84         55  2017
    ## 3 AMR         33     7    64  2532  8.11       6  5.50         46  2016
    ## 4 AML         31     6    52  1943  7.15       2  3.25         35  2015
    ## 5 AML         35     7    84  3059  8.79       7  6.04         75  2014
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
