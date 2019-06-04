<!-- README.md is generated from README.Rmd. Please edit that file -->



<!-- badges: start -->
[![Travis build status](https://travis-ci.org/news-r/loc.svg?branch=master)](https://travis-ci.org/news-r/loc)
<!-- badges: end -->

# loc

Access [Library of Congress](https://chroniclingamerica.loc.gov) from R.

> Chronicling America provides access to information about historic newspapers and select digitized newspaper pages. To encourage a wide range of potential uses, we designed several different views of the data we provide, all of which are publicly visible. Each uses common Web protocols, and access is not restricted in any way. You do not need to apply for a special key to use them. Together they make up an extensive application programming interface (API) which you can use to explore all of our data in many ways.

## Installation

``` r
# install.packages("remotes")
remotes::install_github("news-r/loc")
```

## Example


```r
library(loc)

# titles
titles <- loc_search_titles("michigan", pages = 2)
#> ℹ 9 pages available
#> 
 downloading [========================================] 100%

# pages
loc_search_pages("thomas")
#> ℹ 110300 pages available
#> # A tibble: 11 x 28
#>    sequence county edition frequency id    subject city  date  title
#>       <int> <list> <lgl>   <chr>     <chr> <list>  <lis> <chr> <chr>
#>  1       40 <chr … NA      Daily     /lcc… <list … <chr… 1906… Los …
#>  2       45 <chr … NA      Daily     /lcc… <list … <chr… 1906… Los …
#>  3       46 <chr … NA      Daily     /lcc… <list … <chr… 1907… Los …
#>  4       46 <chr … NA      Daily     /lcc… <list … <chr… 1906… Los …
#>  5       50 <chr … NA      Daily     /lcc… <list … <chr… 1906… Los …
#>  6       56 <chr … NA      Daily     /lcc… <list … <chr… 1907… Los …
#>  7       44 <chr … NA      Daily     /lcc… <list … <chr… 1907… Los …
#>  8        5 <NULL> NA      Daily     /lcc… <list … <chr… 1912… Even…
#>  9       39 <chr … NA      Daily     /lcc… <list … <chr… 1900… New-…
#> 10       31 <chr … NA      Daily     /lcc… <list … <chr… 1901… New-…
#> 11       85 <NULL> NA      Daily     /lcc… <list … <chr… 1935… Even…
#> # … with 19 more variables: end_year <int>, note <list>, state <list>,
#> #   section_label <chr>, type <chr>, place_of_publication <chr>,
#> #   start_year <int>, edition_label <chr>, publisher <chr>,
#> #   language <list>, alt_title <list>, lccn <chr>, country <chr>,
#> #   ocr_eng <chr>, batch <chr>, title_normal <chr>, url <chr>,
#> #   place <list>, page <chr>
```

The text of the newspaper is in the `ocr_eng` variable. You can reconstruct endpoints to specific newspapers, editions, or issues.

```r
a <- sample(articles$url, 1) # take a random article
pdf <- gsub(".json", ".pdf", a) # change to PDF
browseURL(pdf)
```

![](loc.png)