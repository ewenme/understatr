#' Get Tidy understat Data
#'
#' Provides tools to retrieve understat <https://understat.com/>
#' data in a tidy format.
#'
#' - URL: <https://github.com/ewenme/understatr>
#' - BugReports: <https://github.com/ewenme/understatr/issues>
#'
#' @md
#' @name understatr
#' @docType package
#' @author Ewen Henderson (ewenhenderson@@gmail.com)
#' @import rvest stringr
#' @importFrom stringi stri_unescape_unicode
#' @importFrom stringr str_replace_all str_subset
#' @importFrom jsonlite fromJSON
#' @importFrom xml2 read_html
#' @importFrom qdapRegex rm_square
#' @importFrom tibble as_tibble
#' @importFrom purrr map_dfr
NULL
