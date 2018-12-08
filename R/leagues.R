#' Get URLs for supported leagues
#'
#' Retrieve URLs for leagues currently supported by understat.
#'
#' @export
#' @examples \dontrun{
#' scrape_league_urls()
#' }
scrape_league_urls <- function() {

  home_url <- "https://understat.com/"

  # read understat home page
  home_page <- read_html(home_url)

  # get league hyperlinks
  league_urls <- home_page %>%
    html_nodes(".link") %>%
    html_attr('href')

  # construct full links
  full_league_urls <- paste0(home_url, league_urls)

  return(full_league_urls)

}

#' Get tean stats for a league's roster
#'
#' Retrieve team data for a league listed on understat.
#'
#' @param league_url League's understat url
#'
#'
#' @export
#' @examples \dontrun{
#' get_league_teams_stats(team_url = "https://understat.com/league/EPL/2018")
#' }
get_league_teams_stats <- function(league_url) {

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
      df <- mutate(df, id = x$id, itle = x$title)
      df
    }
  )

  return(as_tibble(teams_data_df))

}
