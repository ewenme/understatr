#' Get season-level stats for a player
#'
#' Retrieve season-level data for a player listed on understat.
#'
#' @param player_id Player ID
#'
#' @return a tibble
#'
#' @export
#' @examples \dontrun{
#' get_player_seasons_stats(player_id = 882)
#' }
get_player_seasons_stats <- function(player_id) {

  # construct player url
  player_url <- str_glue("{home_url}/player/{player_id}")

  # read player page
  player_page <- read_html(player_url)

  # locate script tags
  player_data <- get_script(player_page)

  # isolate player data
  player_data <- get_data_element(player_data, "groupsData")

  # pick out JSON string
  player_data <- fix_json(player_data)

  # parse JSON
  player_data <- fromJSON(player_data)

  # get player name
  player_name <- get_player_name(player_page)

  # add reference fields
  player_data$player_id <- as.numeric(player_id)
  player_data$player_name <- player_name
  names(player_data)[names(player_data) == 'team'] <- 'team_name'
  names(player_data)[names(player_data) == 'season'] <- 'year'

  # fix col classes
  player_data <- type.convert(player_data, as.is = TRUE)

  as_tibble(player_data)

}


#' Get match-level stats for a player
#'
#' Retrieve match-level data for a player listed on understat.
#'
#' @param player_id Player ID
#'
#' @return a tibble
#'
#' @export
#' @examples \dontrun{
#' get_player_matches_stats(player_id = 882)
#' }
get_player_matches_stats <- function(player_id) {

  # construct player url
  player_url <- file.path(home_url, "player", player_id)

  # read player page
  player_page <- read_html(player_url)

  # locate script tags
  player_data <- get_script(player_page)

  # isolate player data
  player_data <- get_data_element(player_data, "matchesData")

  # pick out JSON string
  player_data <- fix_json(player_data)

  # parse JSON
  player_data <- fromJSON(player_data)

  # get player name
  player_name <- get_player_name(player_page)

  # add reference fields
  player_data$player_id <- as.numeric(player_id)
  player_data$player_name <- player_name
  names(player_data)[names(player_data) == 'season'] <- 'year'
  names(player_data)[names(player_data) == 'id'] <- 'match_id'

  # reorder fields
  player_data <- subset(
    player_data,
    select = c(player_name, player_id, year, goals:match_id,
               roster_id:xGBuildup)
  )

  # fix col classes
  player_data <- type.convert(player_data, as.is = TRUE)
  player_data$date <- as.Date(player_data$date, "%Y-%m-%d")

  as_tibble(player_data)

}

#' Get shotstats for a player
#'
#' Retrieve shot data for a player listed on understat.
#'
#' @param player_id Player ID
#'
#' @return a tibble
#'
#' @export
#' @examples \dontrun{
#' get_player_shots(player_id = 882)
#' }
get_player_shots <- function(player_id) {

  # construct player url
  player_url <- str_glue("{home_url}/player/{player_id}")

  # read player page
  player_page <- read_html(player_url)

  # locate script tags
  player_data <- get_script(player_page)

  # isolate player data
  player_data <- get_data_element(player_data, "shotsData")

  # pick out JSON string
  player_data <- fix_json(player_data)

  # parse JSON
  player_data <- fromJSON(player_data)

  # add reference fields
  player_data$player_id <- as.numeric(player_id)
  names(player_data)[names(player_data) == 'season'] <- 'year'

  # fix col classes
  player_data <- type.convert(player_data, as.is = TRUE)
  player_data$date <- as.Date(player_data$date, "%Y-%m-%d")

  as_tibble(player_data)

}
