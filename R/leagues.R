#' Get information on a league's available seasons
#'
#' Retrieve available seasons for a given league on understat.
#'
#' @keywords internal
#'
#' @export
get_league_seasons <- function(league_name) {

  # construct league url
  league_url <- str_glue("https://understat.com/league/{league_name}")

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

  return(seasons_df)

}


#' Get information on available leagues and seasons
#'
#' Retrieve useful metadata on leagues currently supported by understat.
#'
#' @export
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

  league_df <- map_dfr(
    league_names, get_league_seasons)

  return(as_tibble(league_df))

}


#' Get stats on a league's teams for a given season
#'
#' Retrieve data for all teams in a league season listed on understat.
#'
#' @param league_name League name
#' @param year Year (season)
#' @export
#' @examples \dontrun{
#' get_league_teams_stats(league_name = "EPL", year = 2018)
#' }
get_league_teams_stats <- function(league_name, year) {

  stopifnot(is.character(league_name))

  # construct league url
  league_url <- str_glue("https://understat.com/league/{league_name}/{year}")

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
      df$team_id <- x$id
      df$team_name <- x$title
      df
    })

  # add reference fields
  teams_data_df$league_name <- league_name
  teams_data_df$year <- as.numeric(year)

  # fix col classes
  teams_data_df <- type.convert(teams_data_df)
  teams_data_df[] <- lapply(teams_data_df, function(x) if(is.factor(x)) as.character(x) else x)
  teams_data_df$date <- as.Date(teams_data_df$date, "%Y-%m-%d")

  return(as_tibble(teams_data_df))

}
