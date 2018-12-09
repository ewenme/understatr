#' Get information about currently supported leagues
#'
#' Retrieve useful metadata on leagues currently supported by understat.
#'
#' @export
#' @examples \dontrun{
#' get_league_metadata()
#' }
get_league_metadata <- function() {

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

#' Get information about a leagues seasons
#'
#' Retrieve seasons on understat for a given league.
#'
#' @keywords internal
#'
#' @export
get_league_seasons <- function(league_name) {

  # form league name for url
  league_name_fixed <- str_replace_all(
    league_name, pattern = " ", replacement = "_"
    )

  # construct league url
  league_url <- file.path(home_url, "league", league_name_fixed)

  # read league page
  league_page <- read_html(league_url)

  # pick year link
  year_link <- html_nodes(league_page, "#header :nth-child(2)")

  # isolate year options
  year_options <- html_nodes(year_link[2], "option")

  # create league fields as df
  seasons_df <- data.frame(
    league_name = league_name,
    year = html_attr(year_options, "value"),
    season = html_text(year_options),
    stringsAsFactors = FALSE
  )

  # create url per season
  seasons_df$url <- file.path(league_url, seasons_df$year)

  return(seasons_df)

}

#' Get team stats for a league's roster
#'
#' Retrieve team data for a league listed on understat.
#'
#' @param league_url League's understat url
#' @export
#' @examples \dontrun{
#' get_league_teams_data(league_url = "https://understat.com/league/EPL/2018")
#' }
get_league_teams_data <- function(league_url) {

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
      df$id <- x$id
      df$title <- x$title
      df
    }
  )

  return(teams_data_df)

}
