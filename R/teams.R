#' Get information on a team's available seasons
#'
#' Retrieve useful metadata on a team currently supported by understat.
#'
#' @export
#' @examples \dontrun{
#' get_team_meta(team_name = "Newcastle United")
#' }
get_team_meta <- function(team_name) {

  team_url <- str_glue("https://understat.com/team/{team_name}")

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

  return(team_df)

}


#' Get stats for a team's players for a given season
#'
#' Retrieve data for all players in a team's season listed on understat.
#'
#' @param team_name Team name
#' @param year Year (season)
#' @export
#' @examples \dontrun{
#' get_team_squad_stats(team_name = "Newcastle United", year = 2018)
#' }
get_team_players_stats <- function(team_name, year) {

  stopifnot(is.character(team_name))

  # construct team url
  team_url <- str_glue("https://understat.com/team/{team_name}/{year}")

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
  players_data$year <- as.numeric(year)
  names(players_data)[names(players_data) == 'team_title'] <- 'team_name'
  names(players_data)[names(players_data) == 'id'] <- 'player_id'

  # fix col classes
  players_data <- type.convert(players_data)
  players_data[] <- lapply(players_data, function(x) if(is.factor(x)) as.character(x) else x)

  return(as_tibble(players_data))

}
