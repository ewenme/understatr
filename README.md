
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
    ##    player_id player_name games  time goals    xG assists     xA shots
    ##        <int> <chr>       <int> <int> <int> <dbl>   <int>  <dbl> <int>
    ##  1       619 Sergio Agü…    28  2095    19 18.0        7  4.12     99
    ##  2       618 Raheem Ste…    29  2338    17 14.4        9 10.3      67
    ##  3       337 Leroy Sané     27  1709     9  6.84      10  7.56     53
    ##  4      5543 Gabriel Je…    26   966     7 12.0        3  2.65     42
    ##  5       617 David Silva    28  2073     6  7.89       6  9.01     47
    ##  6       750 Riyad Mahr…    26  1243     6  6.36       3  4.38     50
    ##  7      3635 Bernardo S…    31  2401     6  6.94       7  7.76     44
    ##  8       314 Ilkay Günd…    26  1683     5  3.88       2  4.53     35
    ##  9       447 Kevin De B…    17   917     2  1.31       2  6.65     28
    ## 10      2498 Aymeric La…    30  2609     2  3.10       2  0.712    23
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
    ## 1 AML         29    17    67  2338 14.4        9 10.3          59  2018
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
