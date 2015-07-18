# -----------------------------------------------
# Water Supply Sites in Yokohama, Japan
# global.R
#
# Author: @naokifuse on github
# 
# Data source: 
#   Open Data Catalog in Yokohama, Japan
#   http://www.city.yokohama.lg.jp/seisaku/seisaku/opendata/catalog.html 
# -----------------------------------------------

library(shiny)
library(XML)
library(dplyr)

library(leaflet)
library(ggvis)
library(ggmap)
