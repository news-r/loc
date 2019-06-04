BASE_URL <- "https://chroniclingamerica.loc.gov"

.as_row <- function(row){
  r <- purrr::map(row, function(x){
    if(is.null(x)) 
      return(NA)
    
    if(length(x) > 1)
      x <- list(x)

    return(x)
  })

  tibble::as_tibble(r)
}

.as_df <- function(articles){
  articles <- purrr::flatten(articles)
  purrr::map_df(articles, .as_row)
}
