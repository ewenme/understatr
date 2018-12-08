
# understatr <img alt="understatr Logo" title="discogger" align="right" src="man/figures/understatr_logo.png" width="100" style="float:right;width:100px;"/>

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
status](https://travis-ci.org/ewenme/understatr.svg?branch=master)](https://travis-ci.org/ewenme/understatr)

An R package to help with retrieving tidy
[understat](https://understat.com/) data.

## Install

`understatr` is not likely to be submitted to CRAN. Get it from
GitHub:

``` r
remotes::install_github('ewenme/understatr')
```

## Use

``` r
library(understatr)
```

### Get player stats for a team’s roster:

``` r
get_team_player_stats(team_url = "https://understat.com/team/Newcastle_United/2018")
```

    ## # A tibble: 20 x 18
    ##    id    player_name games time  goals xG    assists xA    shots key_passes
    ##  * <chr> <chr>       <chr> <chr> <chr> <chr> <chr>   <chr> <chr> <chr>     
    ##  1 813   Salomón Ro… 10    650   3     3.42… 1       0.47… 24    1         
    ##  2 866   Joselu      12    467   2     1.52… 0       0.01… 15    2         
    ##  3 875   Ciaran Cla… 8     580   2     0.37… 0       0.05… 4     2         
    ##  4 47    Yoshinori … 10    369   1     0.97… 0       0.20… 5     3         
    ##  5 689   Kenedy      13    1024  1     2.23… 1       0.74… 27    8         
    ##  6 727   DeAndre Ye… 14    1251  1     1.06… 1       1.11… 5     13        
    ##  7 770   Ayoze Pérez 15    1079  1     2.04… 1       2.04… 16    20        
    ##  8 76    Fabian Sch… 6     483   0     0.22… 0       0.15… 5     2         
    ##  9 461   Matt Ritch… 13    1041  0     1.50… 2       1.77… 15    19        
    ## 10 708   Federico F… 12    1080  0     0.07… 1       0.37… 3     3         
    ## 11 723   Ki Sung-yu… 8     589   0     0.05… 1       0.62… 2     10        
    ## 12 766   Jamaal Las… 11    903   0     0.29… 0       0.49… 6     1         
    ## 13 769   Jonjo Shel… 9     700   0     0.53… 1       1.53… 14    18        
    ## 14 853   Paul Dumme… 10    900   0     0.11… 0       0.20… 4     3         
    ## 15 1719  Javier Man… 5     328   0     0     0       0.02… 0     1         
    ## 16 2344  Christian … 9     303   0     0.52… 0       0.64… 8     7         
    ## 17 4471  Mohamed Di… 15    1337  0     0.82… 0       0.04… 12    1         
    ## 18 6062  Isaac Hayd… 4     119   0     0     0       0.33… 0     1         
    ## 19 6063  Jacob Murp… 7     278   0     0.03… 1       0.60… 2     1         
    ## 20 6532  Martin Dub… 15    1350  0     0     0       0     0     0         
    ## # ... with 8 more variables: yellow_cards <chr>, red_cards <chr>,
    ## #   position <chr>, team_title <chr>, npg <chr>, npxG <chr>,
    ## #   xGChain <chr>, xGBuildup <chr>

## Disclaimer

While there is no official notice on the site condoning web scraping
activity, Understat’s [support](support@understat.com) have previously
confirmed (via e-mail exchange, 8th November 2018) that their data is
free to use for non-commercial purposes. This stance is subject to
change. Also, be polite and attribute the source.
