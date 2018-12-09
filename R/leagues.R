#' Construct URL for a league's page
#'
#' Help with constructing the URL of a league's page
#' on understat, for a given season (year).
#'
#' @param league_name League name as seen on understat
#' @param year Year (or season) as seen on understat
#' @keywords internal
#' @export
#' @examples \dontrun{
#' construct_league_url(league_name = "EPL", year = 2018)
#' }
construct_league_url <- function(league_name, year) {

  home_url <- file.path(home_url, "league")

  # replace space w underscores
  league_name <- str_replace_all(league_name, pattern = " ", replacement = "_")

  # construct team url
  league_url <- paste(home_url, league_name, year, sep = "/")

  return(league_url)

}


#' Get information on currently supported leagues
#'
#' Retrieve useful metadata on leagues currently supported by understat.
#'
#' @export
#' @examples \dontrun{
#' get_league_meta()
#' }
get_league_meta <- function() {

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


#' Get information on a league's seasons
#'
#' Retrieve available seasons for a given league on understat.
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
    year = as.numeric(html_attr(year_options, "value")),
    season = html_text(year_options),
    stringsAsFactors = FALSE
  )

  # create url per season
  seasons_df$url <- file.path(league_url, seasons_df$year)

  return(seasons_df)

}


#' Get stats on a league's roster of teams
#'
#' Retrieve data for all teams in a league season listed
#' on understat.
#'
#' @param league_name League name
#' @param year Year (season)
#' @export
#' @examples \dontrun{
#' get_league_teams_stats(league_name = "EPL", year = 2018)
#' }
get_league_teams_stats <- function(league_name, year) {

  # construct league url
  league_url <- construct_league_url(league_name = league_name,
                                     year = year)

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

  # reorder fields
  teams_data_df <- subset(
    teams_data_df,
    select = c(league_name, year, team_name, team_id, h_a:ppda_allowed.def)
    )

  # fix col classes
  teams_data_df <- type.convert(teams_data_df)
  teams_data_df[] <- lapply(teams_data_df, function(x) if(is.factor(x)) as.character(x) else x)
  teams_data_df$date <- as.Date(teams_data_df$date, "%Y-%m-%d")

  return(as_tibble(teams_data_df))

}
