#' Get player stats for a given match
#'
#' Retrieve data for all players in a match listed on understat.
#'
#' @param match_id Match ID
#' @export
#' @return a tibble
#' @examples \dontrun{
#' get_match_stats(match_id = 11662)
#' }
get_match_stats <- function(match_id) {

  match_url <- str_glue("{home_url}/match/{match_id}")

  # read match page
  match_page <- read_html(match_url)

  # locate script tags
  match_data <- get_script(match_page)

  # isolate player data
  match_data <- get_data_element(match_data, "rostersData")

  # pick out JSON string
  match_data <- sub(".*?\\'(.*)\\'.*", "\\1", match_data)

  # parse JSON
  match_data <- fromJSON(match_data)

  # get home data
  home_data <- do.call(rbind.data.frame, match_data$h)

  # get away data
  away_data <- do.call(rbind.data.frame, match_data$a)

  # bind data
  match_data <- rbind(home_data, away_data)

  # add reference fields
  match_data$match_id <- match_id

  # fix col classes
  match_data <- utils::type.convert(match_data, as.is = TRUE)

  as_tibble(match_data)
}

#' Get shots for a given match
#'
#' Retrieve data for all shots in a match listed on understat.
#'
#' @param match_id Match ID
#' @export
#' @return a tibble
#' @examples \dontrun{
#' get_match_shots(match_id = 11662)
#' }
get_match_shots <- function(match_id) {

  match_url <- str_glue("{home_url}/match/{match_id}")

  # read match page
  match_page <- read_html(match_url)

  # locate script tags
  match_data <- get_script(match_page)

  # isolate player data
  shots_data <- get_data_element(match_data, "shotsData")

  # pick out JSON string
  shots_data <- fix_json(shots_data)

  # parse JSON
  shots_data <- lapply(shots_data, fromJSON)

  # convert to df
  shots_data <- do.call("rbind", shots_data)

  # add reference fields
  shots_data$match_id <- match_id

  # fix col classes
  shots_data <- type.convert(shots_data, as.is = TRUE)

  as_tibble(shots_data)

}
