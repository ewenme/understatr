
# setup -------------------------------------------------------------------

# check requirements
source("./src/requirements.R")

# load packages
library(rvest)
library(jsonlite)
library(tidyverse)
library(stringi)
library(qdapRegex)

# import scraper functions
source("./src/functions.R")


# scrape -------------------------------------------------------------------

# get player stats for Newcastle Utd
scrape_team_players_stats(team_url = "https://understat.com/team/Newcastle_United/2018")
