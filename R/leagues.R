#' Get information on a league's available seasons
#'
#' Retrieve available seasons for a given league on understat.
#'
#' @keywords internal
#'
#' @export
get_league_seasons <- function(league_name) {

  # construct league url
  league_url <- str_glue("{home_url}/league/{league_name}")

  # read league page
  league_page <- read_html(league_url)

  # pick year link
  year_link <- html_nodes(league_page, "#header :nth-child(2)")

  # isolate year options
  year_options <- html_nodes(year_link[2], "option")

  # create league fields as df
  seasons_df <- data.frame(
    league_name = league_name,
    year = as.numeric(html_attr(year_options, "value")),
    season = html_text(year_options),
    stringsAsFactors = FALSE
  )

  # create url per season
  seasons_df$url <- file.path(league_url, seasons_df$year)

  seasons_df

}


#' Get information on available leagues and seasons
#'
#' Retrieve useful metadata on leagues currently supported by understat.
#'
#' @export
#'
#' @return a tibble
#'
#' @examples \dontrun{
#' get_leagues_meta()
#' }
get_leagues_meta <- function() {

  # read understat home page
  home_page <- read_html(home_url)

  # isolate league links
  league_links <- html_nodes(home_page, ".link")

  # get league URLs
  league_urls <- html_attr(league_links, 'href')

  # get league names
  league_names <- html_text(league_links)

  # get league data
  leagues <- lapply(
    league_names, get_league_seasons)

  # convert to df
  league_df <- do.call("rbind", leagues)

  as_tibble(league_df)

}


#' Get stats on a league's teams for a given season
#'
#' Retrieve data for all teams in a league season listed on understat.
#'
#' @param league_name League name
#' @param year Year (season)
#' @export
#' @return a tibble
#' @examples \dontrun{
#' get_league_teams_stats(league_name = "EPL", year = 2018)
#' }
get_league_teams_stats <- function(league_name, year) {

  stopifnot(is.character(league_name))

  # construct league url
  league_url <- utils::URLencode(str_glue("{home_url}/league/{league_name}/{year}"))

  # read league page
  league_page <- read_html(league_url)

  # locate script tags
  teams_data <- get_script(league_page)

  # isolate player data
  teams_data <- get_data_element(teams_data, "teamsData")

  # pick out JSON string
  teams_data <- sub(".*?\\'(.*)\\'.*", "\\1", teams_data)

  # parse JSON
  teams_data <- fromJSON(teams_data, simplifyDataFrame = TRUE,
                          flatten = TRUE)

  # get teams data
  teams_data <- lapply(
    teams_data, function(x) {
      df <- x$history
      df$team_id <- x$id
      df$team_name <- x$title
      df
    })

  # convert to df
  teams_df <- do.call("rbind", teams_data)

  # add reference fields
  teams_df$league_name <- league_name
  teams_df$year <- as.numeric(year)

  # fix col classes
  teams_df$date <- as.Date(teams_df$date, "%Y-%m-%d")

  as_tibble(teams_df)

}
