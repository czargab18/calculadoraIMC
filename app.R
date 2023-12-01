#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  tags$head(
    tags$title("calculadora de IMC"),
    tags$link(
      rel = "stylesheet", type = "text/css",
      href = "styles/style.css"
    ),
  ),
  includeCSS("styles/style.css"),

  div(
    id = "content",
    h1("Calculadora de IMC"),
    div(
      id = "content-input",
      numericInput(
        inputId = "input-text-peso",
        label = "Qual o seu peso em kilogramas?",
        value = 60
      )
    ),
    div(
      id = "content-input",
      numericInput(
        inputId = "input-text-altura",
        label = "Qual o seu peso em centimetros?",
        value = 173
      )
    ),
    span(id = "linha-separacao"),
    div(
      id = "content-resultado",
      textOutput(outputId = "resultado", )
    ),
    div(
      id = "content-resultado-ideal",
      textOutput(outputId = "resultado-ideal", )
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  imc <- reactive({
    input$"input-text-peso" / ((input$"input-text-altura" / 100)^2)
  })
  output$resultado <- renderText({
    paste0("Seu Indice de Massa Corporal é: ", round(imc(), 2))
  })
  output$"resultado-ideal" <- renderText({
    if (imc() < 18.5) {
      "Você está abaixo do peso!"
    } else if (imc() < 25) {
      "Você está dentro do peso ideal!"
    } else {
      "Você está acima do peso!"
    }
  })
}

# Run the application
shinyApp(ui = ui, server = server)
