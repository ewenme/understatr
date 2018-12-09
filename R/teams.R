#' Construct URL for a team's page
#'
#' Help with constructing the URL of a team's page
#' on understat, for a given season (year).
#'
#' @param team_name Team name as seen on understat
#'
#' @param year Year (or season) as seen on understat
#' @export
#' @examples \dontrun{
#' construct_team_url(team_name = "Newcastle United", year = 2018)
#' }
construct_team_url <- function(team_name, year) {

  home_url <- file.path(home_url, "team")

  # replace space w underscores
  team_name <- str_replace_all(team_name, pattern = " ", replacement = "_")

  # construct team url
  team_url <- paste(home_url, team_name, year, sep = "/")

  return(team_url)

}

#' Get player stats for a team's roster
#'
#' Retrieve player data for a team listed on understat.
#'
#' @param team_url Team's understat url
#' @export
#' @examples \dontrun{
#' get_team_players_data(team_url = "https://understat.com/team/Newcastle_United/2018")
#' }
get_team_players_data <- function(team_url) {

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
