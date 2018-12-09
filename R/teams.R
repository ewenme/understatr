#' Construct URL for a team's page
#'
#' Help with constructing the URL of a team's page
#' on understat, for a given season (year).
#'
#' @param team_name Team name as seen on understat
#' @param year Year (or season) as seen on understat
#' @keywords internal
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

#' Get stats for a team's playing squad
#'
#' Retrieve data for all players in a team's season
#' listed on understat.
#'
#' @param team_name Team name
#' @param year Year (season)
#' @export
#' @examples \dontrun{
#' get_team_squad_stats(team_name = "Newcastle United", year = 2018)
#' }
get_team_squad_stats <- function(team_name, year) {

  # construct team url
  team_url <- construct_team_url(team_name = team_name, year = year)

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

  # add reference fields
  players_data$year <- year
  names(players_data)[names(players_data) == 'team_title'] <- 'team_name'
  names(players_data)[names(players_data) == 'id'] <- 'player_id'

  # reorder fields
  players_data <- subset(
    players_data,
    select = c(team_name, year, player_name, player_id, games:xGBuildup)
  )

  return(as_tibble(players_data))

}
