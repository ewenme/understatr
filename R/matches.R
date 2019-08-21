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
  home_data <- do.call(rbind.data.frame, foo$h)

  # get away data
  away_data <- do.call(rbind.data.frame, foo$a)

  # bind data
  match_data <- rbind(home_data, away_data)

  # add reference fields
  match_data$match_id <- as.numeric(match_id)

  # fix col classes
  match_data <- type.convert(match_data)
  match_data[] <- lapply(match_data, function(x) if(is.factor(x)) as.character(x) else x)

  as_tibble(match_data)
}

