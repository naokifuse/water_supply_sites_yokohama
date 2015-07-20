# -----------------------------------------------
# Water Supply Sites in Yokohama, Japan
# ui.R
# -----------------------------------------------

a_blank <- function (name, href) {
  a(name, href=href, target="_blank")
}

shinyUI(fluidPage(
  titlePanel("Water Supply Sites in Yokohama, Japan"), 
  
  sidebarLayout(
    sidebarPanel(
      h3("横浜市応急給水拠点"), 
      br(), 
      selectInput("supply.type", 
                  label="給水拠点の種類を選んでください", 
                  choices=list("すべて", "配水池", "災害用地下給水タンク", "緊急給水栓"), 
                  selected="すべて"), 
      selectInput("supply.ward", 
                  label="対象区を選んでください", 
                  choices=list("すべて", "鶴見区", "神奈川区", "西区", "中区", "南区", "港南区", 
                               "保土ケ谷区", "旭区", "磯子区", "金沢区", "港北区", "緑区", 
                               "青葉区", "都筑区", "戸塚区", "栄区", "泉区", "瀬谷区"), 
                  selected="すべて"), 
      fluidRow(column(10, textOutput("water_text"))), 
      br(), 
      br(), 
      p("このサイトは横浜市のオープンデータを用いています", br(), "詳しくは", 
        a_blank("よこはまオープンデータカタログ", 
                "http://www.city.yokohama.lg.jp/seisaku/seisaku/opendata/catalog.html"), "へ"), 
      br(), 
      p("Source on ", 
        a_blank("GitHub;", "https://github.com/naokifuse/water_supply_sites_yokohama"), 
        "Powered by ", 
        a_blank("shiny", "http://shiny.rstudio.com"))
    ), 
    
    mainPanel(
      tabsetPanel(
        id="tabsetpanel1", 
        tabPanel("leaflet", 
                 h4("Render with", a_blank("leaflet", href="https://github.com/rstudio/leaflet")), 
                 fluidRow(column(10, leafletOutput("water_leaf")))
                 ),
        tabPanel("ggvis", 
                 h4("Render with", a_blank("ggvis", href="https://github.com/rstudio/ggvis")), 
                 fluidRow(column(10, ggvisOutput("water_vis"))), 
                 p(br(), "TODO: render with map")
                 ), 
        tabPanel("ggmap",
                 h4("Render with", a_blank("ggmap", href="https://github.com/dkahle/ggmap")), 
                 fluidRow(column(10,
                                 radioButtons("ggmap.source", "Options", 
                                              choices=list("ggmap", "ggplot"), 
                                              selected="ggmap"), 
                                 plotOutput("water_ggmap", hover=hoverOpts("ggmap.hover", 100)), 
                                 wellPanel(h5("Information"), htmlOutput("ggmap_hover_info"))
                                 )),
                 p(br(), "WARNING: When it is rendered with ggmap, hover information does not work well")
                 ), 
        tabPanel("data", 
                 h4("Table"), 
                 fluidRow(column(10, dataTableOutput("water_df")))
                 )
        )
      )
    )
))
