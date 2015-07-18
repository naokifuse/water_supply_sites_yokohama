# water_supply_sites_yokohama

## Shiny app
My first [shiny](http://shiny.rstudio.com) app to draw maps of water supply sites in Yokohama, Japan.
Dataset is available at [Open Data Catalog](http://www.city.yokohama.lg.jp/seisaku/seisaku/opendata/catalog.html).

## Method to draw maps
* [leaflet](https://github.com/rstudio/leaflet)
* [ggvis](https://github.com/rstudio/ggvis)
* [ggmap](https://github.com/dkahle/ggmap)

## Required library
All available at CRAN.

```r:
install.packages("shiny")
install.packages("XML")
install.packages("dplyr")

install.packages("leaflet")
install.packages("ggvis")
install.packages("ggmap")
```

## Run app

```r:
shiny::runGitHub("naokifuse/water_supply_sites_yokohama")
```

or visit [shinyapps.io](https://naokifuse.shinyapps.io/water_supply_sites_yokohama).
