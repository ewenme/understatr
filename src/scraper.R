
# setup -------------------------------------------------------------------

# load packages
library(rvest)
library(jsonlite)
library(tidyverse)
library(stringi)
library(qdapRegex)

# load functions
source("./src/functions.R")

# test url
url <- "https://understat.com/team/Newcastle_United/2018"


# scrape -------------------------------------------------------------------

# test scrape
scrape_team_stats(team_url = url)



