BASE_URL <- "https://chroniclingamerica.loc.gov"

.construct <- function(content){
  structure(content, class = c("loc", class(content)))
}