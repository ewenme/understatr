
scrape_team_stats <- function(team_url) {
  
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
  
  return(players_data)
  
}
