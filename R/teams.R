#' Get information on a team's available seasons
#'
#' Retrieve useful metadata on a team currently supported by understat.
#'
#' @param team_name Team name
#'
#' @return a tibble
#'
#' @export
#' @examples \dontrun{
#' get_team_meta(team_name = "Newcastle United")
#' }
get_team_meta <- function(team_name) {

  team_name <- str_replace_all(team_name, " ", "_")

  team_url <- str_glue("{home_url}/team/{team_name}")

  # read understat team page
  team_page <- read_html(team_url)

  # isolate league links
  year_link <- html_nodes(team_page, "#header :nth-child(2)")

  # isolate year options
  year_options <- html_nodes(year_link[2], "option")

  # create league fields as df
  team_df <- data.frame(
    team_name = team_name,
    year = as.numeric(html_attr(year_options, "value")),
    season = html_text(year_options),
    stringsAsFactors = FALSE
  )

  # create url per season
  team_df$url <- file.path(team_url, team_df$year)

  as_tibble(team_df)

}


#' Get stats for a team's players for a given season
#'
#' Retrieve data for all players in a team's season listed on understat.
#'
#' @param team_name Team name
#' @param year Year (season)
#'
#' @return a tibble
#'
#' @export
#' @examples \dontrun{
#' get_team_players_stats(team_name = "Newcastle United", year = 2018)
#' }
get_team_players_stats <- function(team_name, year) {

  stopifnot(is.character(team_name))

  team_name <- str_replace_all(team_name, " ", "_")

  # construct team url
  team_url <- str_glue("{home_url}/team/{team_name}/{year}")

  # read team page
  team_page <- read_html(team_url)

  # locate script tags
  players_data <- as.character(html_nodes(team_page, "script"))

  # isolate player data
  players_data <- get_data_element(players_data, "playersData")

  # pick out JSON string
  players_data <- fix_json(players_data)

  # parse JSON
  players_data <- fromJSON(players_data)

  # add reference fields
  players_data$year <- as.numeric(year)
  names(players_data)[names(players_data) == 'team_title'] <- 'team_name'
  names(players_data)[names(players_data) == 'id'] <- 'player_id'

  # fix col classes
  players_data <- type.convert(players_data)
  players_data[] <- lapply(players_data, function(x) if(is.factor(x)) as.character(x) else x)

  as_tibble(players_data)

}
