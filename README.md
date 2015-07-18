# water_supply_sites_yokohama

## Shiny app
My first [shiny](http://shiny.rstudio.com) app to draw maps of water supply sites in Yokohama, Japan.
Dataset is available at [Open Data Catalog](http://www.city.yokohama.lg.jp/seisaku/seisaku/opendata/catalog.html).

## Plot method
* [leaflet](https://github.com/rstudio/leaflet)
* [ggvis](https://github.com/rstudio/ggvis)
* [ggmap](https://github.com/dkahle/ggmap)

## Required library

All available at CRAN.

```r:
library(shiny)
library(XML)
library(dplyr)

library(leaflet)
library(ggvis)
library(ggmap)
```

## Run app

```r:
shiny::runGitHub(repo, username)
```
