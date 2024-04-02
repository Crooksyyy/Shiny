library(shiny)
library(DT)
library(ggplot2)
library(dplyr)

# Read data
Auschwitz_Death_Raw_Data <- read.csv("Auschwitz_Death_Raw_Data.csv")

# Define UI for application
ui <- fluidPage(
  titlePanel("Auschwitz Death Certificates Analysis"),
  sidebarLayout(
    sidebarPanel(
      selectInput("dataSelection",
                  "Select Data for Graph:",
                  choices = c("Birthplace", "Residence", "Religion")),
      uiOutput("selectionInput")
    ),
    mainPanel(
      plotOutput("murderPlot"),
      DTOutput("murderTable")
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  
  # Dynamically render additional input based on the selected data
  output$selectionInput <- renderUI({
    if (input$dataSelection %in% c("Birthplace", "Residence")) {
      selectizeInput("selectedLocation",
                     label = if(input$dataSelection == "Birthplace") "Select Birthplace:" else "Select Residence:",
                     choices = unique(unlist(Auschwitz_Death_Raw_Data[c("Birthplace", "Residence")])),
                     selected = unique(unlist(Auschwitz_Death_Raw_Data[c("Birthplace", "Residence")]))[1],
                     multiple = TRUE) # Allow selecting multiple options
    } else {
      selectizeInput("selectedReligion",
                     label = "Select Religion:",
                     choices = unique(Auschwitz_Death_Raw_Data$Religion),
                     selected = unique(Auschwitz_Death_Raw_Data$Religion)[1],
                     multiple = TRUE) # Allow selecting multiple options
    }
  })
  
  # Render plot based on selected data
  output$murderPlot <- renderPlot({
    if (input$dataSelection %in% c("Birthplace", "Residence")) {
      selected_location <- input$selectedLocation
      data_to_plot <- Auschwitz_Death_Raw_Data %>%
        filter(if(input$dataSelection == "Birthplace") Birthplace %in% selected_location else Residence %in% selected_location) %>%
        group_by(Location = if(input$dataSelection == "Birthplace") Birthplace else Residence) %>%
        summarise(Count = n())
      
      ggplot(data_to_plot, aes(x = Location, y = Count, fill = Location)) +
        geom_bar(stat = "identity") +
        labs(x = "Location", y = "Count", title = paste("Number of People Murdered by", input$dataSelection)) +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1))
    } else {
      selected_religion <- input$selectedReligion
      data_to_plot <- Auschwitz_Death_Raw_Data %>%
        filter(Religion %in% selected_religion) %>%
        group_by(Religion) %>%
        summarise(Count = n())
      
      ggplot(data_to_plot, aes(x = Religion, y = Count, fill = Religion)) +
        geom_bar(stat = "identity") +
        labs(x = "Religion", y = "Count", title = "Number of People Murdered by Religion") +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1))
    }
  })
  
  # Render interactive table based on selected data
  output$murderTable <- renderDT({
    if (input$dataSelection %in% c("Birthplace", "Residence")) {
      selected_location <- input$selectedLocation
      data_to_display <- Auschwitz_Death_Raw_Data %>%
        filter(if(input$dataSelection == "Birthplace") Birthplace %in% selected_location else Residence %in% selected_location)
    } else {
      selected_religion <- input$selectedReligion
      data_to_display <- Auschwitz_Death_Raw_Data %>%
        filter(Religion %in% selected_religion)
    }
    datatable(data_to_display, options = list(pageLength = 10, scrollX = TRUE))
  })
}

# Run the application
shinyApp(ui = ui, server = server)
