# -----------------------------------------------
# Water Supply Sites in Yokohama, Japan
# server.R
# -----------------------------------------------

shinyServer(function (input, output) {
  # load data
  df <- "http://www.city.yokohama.lg.jp/somu/org/kikikanri/data/watersupplysites.xml" %>%
    xmlToDataFrame(stringsAsFactors=F, 
                   colClasses=c(rep("character", 4), rep("numeric", 2), "character")) %>% 
    mutate(id = 1:n(),
           popup = sprintf("種類: %s <br / > 名称: %s <br /> 住所: %s %s <br /><br /> %s", 
                           Type, Name, Ward, Address, Notes))

  # filter data
  filter_df <- reactive({
    if (input$supply.type != "すべて") df <- filter(df, Type == input$supply.type)
    if (input$supply.ward != "すべて") df <- filter(df, Ward == input$supply.ward)
    df
  })

  # with leftlet 
  output$water_leaf <- renderLeaflet({
    df <- filter_df()
    leaflet() %>%
      addTiles() %>%
      addMarkers(lng=df$Longitude, lat=df$Latitude, popup=df$popup)
  })
  
  # with ggvis
  water_tooltip <- function (x) {
    if (is.null(x)) return (NULL)
    row <- filter(df, id == x$id)
    # paste0(names(row), ":", format(row), collapse="<br />")
    paste0(row["popup"])
  }
  vis <- reactive({
    df <- filter_df()
    df %>% 
      ggvis(x = ~Longitude, y = ~Latitude, key:= ~id) %>% 
      layer_points() %>% 
      add_tooltip(water_tooltip, "hover")
  })  
  bind_shiny(vis, "water_vis")
  
  # with ggmap
  m.ggmap <- get_map(location=c(mean(df$Longitude), mean(df$Latitude)), zoom=11)
  output$water_ggmap <- renderPlot({
    df <- filter_df()
    ggmap(m.ggmap) + 
      geom_point(data=df, aes(x=Longitude, y=Latitude), colour="blue")
  })

  # data table  
  output$water_df <- renderDataTable({
    df <- filter_df()
    df %>% select(-popup)
  }, options=list(pageLength=10))
  
  # count site
  output$water_text <- renderText({
    df <- filter_df()
    ifelse(nrow(df) > 0, 
           paste0("対象の給水拠点は ", nrow(df), "件あります"), 
           "対象の給水拠点はありません")
  })
})
