#' Sleep
#' 
#' Set and get sleep time for subsequent calls.
#' 
#' @param s Seconds to sleep between pages.
#' 
#' @name sleep
#' @export
set_sleep <- function(s){
  assert_that(!missing(s), msg = "Missing seconds")
  options("LOC_SLEEP" = s)
}

#' @rdname sleep
#' @export
get_sleep <- function(){
  x <- getOption("LOC_SLEEP")
  if(is.null(x)) 
    return(1)
  return(x)
}

#' Titles
#' 
#' The directory of newspaper titles contains nearly 140,000 records of 
#' newspapers and libraries that hold copies of these newspapers. 
#' The title records are based on MARC data gathered and enhanced 
#' as part of the NDNP program.
#' 
#' @param q Search terms
#' @param pages Number of pages of results to collect.
#' @param sleep Number of milliseconds to sleep between \code{pages}.
#' 
#' @examples
#' \dontrun{articles <- loc_search_titles("michigan", pages = 2)}
#' 
#' @import httr
#' @import assertthat
#' 
#' @return An object of class \code{loc} which inherits from \code{list}.
#' 
#' @export
loc_search_titles <- function(q, pages = 1, sleep = get_sleep()) {
  assert_that(!missing(q), msg = "Missing q")

  if(is.infinite(pages)) pages <- 999

  parsed_url <- parse_url(BASE_URL)
  parsed_url$path <- c("search", "titles", "results")
  opts <- list(terms = q, format = "json")

  pb <- progress::progress_bar$new(
    format = " downloading [:bar] :percent",
    total = pages, clear = FALSE, width = 60)

  p <- 0
  content <- list()
  while(p < pages){
    pb$tick()
    if(pages > 1)
      Sys.sleep(sleep)
    opts$page <- p + 1
    parsed_url$query <- opts
    url <- build_url(parsed_url)
    response <- GET(url)
    stop_for_status(response)
    page_content <- content(response)
    if(p == 0)
      cat(crayon::blue(cli::symbol$info), ceiling(page_content$totalItems / 50), "pages available\n")
    content <- append(content, list(page_content$items))
    p <- p + 1
  }

  content <- purrr::flatten(content)
  .construct(content)
}

#' Search
#' 
#' There are millions of digitized newspaper pages in Chronicling America. 
#' These pages span several decades and many U.S. states and territories. 
#' New batches of data come in from partner institutions throughout the year 
#' and are added to the site regularly.
#' 
#' @inheritParams loc_search_titles
#' 
#' @examples
#' \dontrun{articles <- loc_search_pages("thomas", pages = 2)}
#' 
#' @return An object of class \code{loc} which inherits from \code{list}.
#' 
#' @export
loc_search_pages <- function(q, pages = 1, sleep = get_sleep()) {
  assert_that(!missing(q), msg = "Missing q")

  if(is.infinite(pages)) pages <- 999

  parsed_url <- parse_url(BASE_URL)
  parsed_url$path <- c("search", "pages", "results")
  opts <- list(andtext = q, format = "json")

  pb <- progress::progress_bar$new(
    format = " downloading [:bar] :percent",
    total = pages, clear = FALSE, width = 60)

  p <- 0
  content <- list()
  while(p < pages){
    pb$tick()
    if(pages > 1)
      Sys.sleep(sleep)
    opts$page <- p + 1
    parsed_url$query <- opts
    url <- build_url(parsed_url)
    response <- GET(url)
    stop_for_status(response)
    page_content <- content(response)
    if(p == 0)
      cat(crayon::blue(cli::symbol$info), ceiling(page_content$totalItems / 50), "pages available\n")
    content <- append(content, list(page_content$items))
    p <- p + 1
  }

  content <- purrr::flatten(content)
  .construct(content)
}
