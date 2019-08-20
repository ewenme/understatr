
home_url <- "https://understat.com"

# scrape helpers ----------------------------------------------------------

# get script part of html page
get_script <- function(x) {
  as.character(html_nodes(x, "script"))
}

# subset data element of html page
get_data_element <- function(x, element_name) {
  stri_unescape_unicode(str_subset(x, element_name))
}

# fix json element for parsing
fix_json <- function(x) {
  str_subset(
    unlist(
      rm_square(
        x, extract = TRUE, include.markers = TRUE
      )
    ),
    "\\[\\]", negate = TRUE
  )
}

# get player name part of html page
get_player_name <- function(x) {

  player_name <- html_nodes(x, ".header-wrapper:first-child")
  trimws(html_text(player_name))
}
