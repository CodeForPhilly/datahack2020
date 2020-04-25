library(shiny)
library(magrittr)
library(leaflet)
library(DT)
library(dplyr)

# Load City of Philadelphia DBHIDS data on treatment resources
programs <- read.csv("dbhids_geocoded.csv")
programs <- subset(programs, select=-c(X))

# Create UI
ui <- shinyUI(fluidPage(
  titlePanel("MATchmaker - Shiny Version"),
  sidebarLayout(
    sidebarPanel(width = 3,
                 tags$b("Treatments Available"),
                 checkboxInput("bup", "Buprenorphine", value=F),
                 checkboxInput("meth", "Methadone", value=F),
                 checkboxInput("viv", "Vivitrol", value=F),
                 tags$b("Other Features"),
                 checkboxInput("same", "Same-Day Induction", value=F)
    ),
    mainPanel(
      leafletOutput("leafletmap", width = "350px"),
      dataTableOutput("tbl")
    )
  ),
  hr(),
  print("Source: Philadelphia Department of Behavioral Health and Intellectual disAbility Services")
))

# Create underlying app server
server <- function(input, output) {
  
  # function to create bounding box (map range) based on the data remaining after filtering
  in_bounding_box <- function(data, lat, lon, bounds) {
    data %>%
      filter(
        lat > bounds$south &
          lat < bounds$north &
          lon < bounds$east & lon > bounds$west)
  }
  
  # function to apply a filter if a box is checked. 'else TRUE' returns the full input dataset
  checkfilter <- function(checkbox, filter){
    if (checkbox) filter else TRUE
  }
  
  # create a dynamic dataframe called 'map_data_react' that updates as filters toggle on/off.
  map_data_react <- reactive({
    programs %>% 
      filter(
        checkfilter(input$bup == TRUE, Buprenorphine. == "Yes"),
        checkfilter(input$meth == TRUE, Methadone. == "Yes"),
        checkfilter(input$viv == TRUE, Vivitrol. == "Yes"),
        checkfilter(input$same == TRUE, Same.day.induction.during.walk.in.hours. == "Yes")
      )
  })
  
  # create a leaflet map of the filtered data
  output$leafletmap <- renderLeaflet({
    
    program_data <- map_data_react
    
    program_data %>% leaflet() %>%
      addProviderTiles("CartoDB.Voyager") %>%
      addCircleMarkers(
        data = map_data_react(),
        ~ lon ,
        ~ lat,
        popup = ~ paste("<b>",ProgramName,"</b>","<br>",Address),
        radius = 4 ,
        stroke = FALSE,
        fillOpacity = 0.8,
        popupOptions = popupOptions(closeButton = FALSE)
      )
  })
  
  
  # create a datatable of the filtered data
  output$tbl <- DT::renderDataTable({
    DT::datatable(
      map_data_react(),
      extensions = "Scroller",
      style = "bootstrap",
      class = "compact",
      width = "100%",
      options = list(
        deferRender = TRUE,
        scrollY = 300,
        scrollX = TRUE,
        scroller = TRUE,
        dom = 'tp'
      )
    )
  })
}

# run the app
shinyApp(ui = ui, server = server)