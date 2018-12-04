scrape_league_urls <- function() {
  
  home_url <- "https://understat.com/"
  
  # read understat home page
  home_page <- read_html(home_url)
  
  # get league hyperlinks
  league_urls <- home_page %>% 
    html_nodes(".link") %>% 
    html_attr('href')
  
  # construct full links
  full_league_urls <- paste0(home_url, league_urls)
  
  return(full_league_urls)

}

scrape_league_teams_stats <- function(league_url) {
  
  # read league page
  league_page <- read_html(league_url)
  
  teams_data <- league_page %>% 
    # locate script tags
    html_nodes("script") %>% 
    as.character() %>% 
    # isolate player data
    str_subset("teamsData") %>% 
    # fix encoding
    stri_unescape_unicode() %>% 
    sub(".*?\\'(.*)\\'.*", "\\1", .) %>% 
    # parse JSON
    fromJSON(simplifyDataFrame = TRUE, flatten = TRUE) 
  
  teams_data_df <- map_dfr(
    teams_data, function(x) {
      df <- x$history
      df <- mutate(df, id = x$id, itle = x$title)
      df
    }
  )
  
  return(as_tibble(teams_data_df))
  
}

construct_team_url <- function(team_name, year) {
  
  home_url <- "https://understat.com/team"
  
  # replace space w underscores
  team_name <- str_replace_all(team_name, pattern = " ", replacement = "_")
  
  # construct team url
  team_url <- paste(home_url, team_name, year, sep = "/")
  
  return(team_url)
  
}

scrape_team_players_stats <- function(team_url) {
  
  # read team page
  team_page <- read_html(team_url)
  
  players_data <- team_page %>% 
    # locate script tags
    html_nodes("script") %>% 
    as.character() %>% 
    # isolate player data
    str_subset("playersData") %>% 
    # fix encoding
    stri_unescape_unicode() %>% 
    # pick out JSON string
    rm_square(extract = TRUE, include.markers = TRUE) %>% 
    unlist() %>% 
    # parse JSON
    fromJSON()
  
  return(as_tibble(players_data))
  
}
