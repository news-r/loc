<!-- README.md is generated from README.Rmd. Please edit that file -->



<!-- badges: start -->
[![Travis build status](https://travis-ci.org/news-r/loc.svg?branch=master)](https://travis-ci.org/news-r/loc)
<!-- badges: end -->

# loc

Access [Library of Congress](https://chroniclingamerica.loc.gov) from R.

## Installation

``` r
# install.packages("remotes")
remotes::install_github("news-r/loc")
```

## Example


```r
library(loc)

# titles
articles <- loc_search_titles("michigan", pages = 2)
#> ℹ 9 pages available
#> 
  downloading [=======================================] 100%
```
