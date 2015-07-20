# -----------------------------------------------
# Water Supply Sites in Yokohama, Japan
# server.R
# -----------------------------------------------

# load data
# source: 
#   http://www.city.yokohama.lg.jp/somu/org/kikikanri/data/watersupplysites.xml
df <- "watersupplysites.xml" %>%
  xmlToDataFrame(stringsAsFactors=F, 
                 colClasses=c(rep("character", 4), rep("numeric", 2), "character")) %>% 
  mutate(id = 1:n(),
         popup = sprintf("種類: %s <br / > 名称: %s <br /> 住所: %s %s <br /><br /> %s", 
                         Type, Name, Ward, Address, Notes),
         color = ifelse(Type == "配水池", "orange", 
                 ifelse(Type == "災害用地下給水タンク", "green", "blue")))

shinyServer(function (input, output) {
  
  # filter data
  filter_df <- reactive({
    if (input$supply.type != "すべて") df <- filter(df, Type == input$supply.type)
    if (input$supply.ward != "すべて") df <- filter(df, Ward == input$supply.ward)
    df
  })

  # with leaflet
  output$water_leaf <- renderLeaflet({
    df <- filter_df()
    leaflet(df) %>%
      addTiles() %>%
      addMarkers(lng = ~Longitude, lat = ~Latitude, popup = ~popup, 
                 clusterOptions=markerClusterOptions(maxClusterRadius=40))
  })
  
  # with ggvis
  water_tooltip <- function (x) {
    if (is.null(x)) return (NULL)
    row <- filter(df, id == x$id)
    row$popup
  }
  vis <- reactive({
    df <- filter_df()
    df %>% 
      ggvis(x = ~Longitude, y = ~Latitude, key := ~id) %>% 
      layer_points(fill := ~color) %>% 
      add_tooltip(water_tooltip, "hover")
  })  
  bind_shiny(vis, "water_vis")
  
  # with ggmap
  output$water_ggmap <- renderPlot({
    df <- filter_df()
    m.ggmap <- get_map(location=c(mean(df$Longitude), mean(df$Latitude)), 
                       zoom=ifelse(input$supply.ward == "すべて", 11, 13))
    p <- switch(input$ggmap.source, 
                "ggmap"  = ggmap(m.ggmap), 
                "ggplot" = ggplot())
    p + 
      geom_point(data=df, aes(x=Longitude, y=Latitude), colour="navy", size=3.5) +
      xlab("Longitude") + ylab("Latitude") + theme_bw()
  })
  output$ggmap_hover_info <- renderText({
    df <- filter_df() 
    nearPoints(df, input$ggmap.hover, xvar="Longitude", yvar="Latitude", 
               maxpoints=1, threshold=10)$popup
  })

  # data table  
  output$water_df <- renderDataTable({
    filter_df() %>% select(-popup, -color)
  }, options=list(pageLength=10))
  
  # count site
  output$water_text <- renderText({
    df <- filter_df()
    ifelse(nrow(df) > 0, 
           sprintf("対象の給水拠点は%s件あります", nrow(df)), 
           "対象の給水拠点はありません")
  })
})
