# -----------------------------------------------
# Water Supply Sites in Yokohama, Japan
# ui.R
# -----------------------------------------------

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
                  choices=list("すべて", "鶴見区", "神奈川区", "西区", "中区", "南区", "港南区", "保土ケ谷区", "旭区", 
                               "磯子区", "金沢区", "港北区", "緑区", "青葉区", "都筑区", "戸塚区", "栄区", "泉区", "瀬谷区"), 
                  selected="すべて"), 
      fluidRow(column(10, textOutput("water_text"))), 
      br(), 
      br(), 
      p("このサイトは横浜市のオープンデータを用いています", br(), "詳しくは", 
        a("よこはまオープンデータカタログ", 
          href="http://www.city.yokohama.lg.jp/seisaku/seisaku/opendata/catalog.html")), 
      br(), 
      p("Powered by ", a("shiny", href="http://shiny.rstudio.com"))
    ), 
    
    mainPanel(
      tabsetPanel(
        id="tabsetpanel1", 
        tabPanel("leaflet", 
                 h4("Render with", a("leaflet", href="https://github.com/rstudio/leaflet")), 
                 fluidRow(column(10, leafletOutput("water_leaf")))
                 ),
        tabPanel("ggvis", 
                 h4("Render with", a("ggvis", href="https://github.com/rstudio/ggvis")), 
                 fluidRow(column(10, ggvisOutput("water_vis"))), 
                 p(br(), "TODO: render with google map")
                 ), 
        tabPanel("ggmap",
                 h4("Render with", a("ggmap", href="https://github.com/dkahle/ggmap")), 
                 fluidRow(column(10, plotOutput("water_ggmap"))),
                 p(br(), "TODO: implement infomation popup")
                 ), 
        tabPanel("data", 
                 h4("Table"), 
                 fluidRow(column(10, dataTableOutput("water_df")))
                 )
        )
      )
    )
))