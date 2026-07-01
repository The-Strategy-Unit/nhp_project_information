## ----echo=FALSE, include=FALSE------------------------------------------------
knitr::opts_chunk$set(eval = FALSE)

## -----------------------------------------------------------------------------
#  install.packages(c("shiny", "devtools", "usethis", "htmlwidgets", "reactR"))

## -----------------------------------------------------------------------------
#  # Create the R package
#  usethis::create_package("~/sparklines")
#  # Inject the widget templating
#  withr::with_dir(
#    "~/sparklines",
#    reactR::scaffoldReactWidget("sparklines", list("react-sparklines" = "^1.7.0"), edit = FALSE)
#  )

## -----------------------------------------------------------------------------
#  system("yarn install")
#  system("yarn run webpack")

## -----------------------------------------------------------------------------
#  devtools::document()
#  devtools::install(quick = TRUE)

## -----------------------------------------------------------------------------
#  shiny::runApp()

## -----------------------------------------------------------------------------
#  sparklines <- function(message, width = NULL, height = NULL, elementId = NULL) {
#  
#    # describe a React component to send to the browser for rendering.
#    content <- htmltools::tag("div", list(message))
#  
#    # create widget
#    htmlwidgets::createWidget(
#      name = 'sparklines',
#      reactR::reactMarkup(content),
#      width = width,
#      height = height,
#      package = 'sparklines',
#      elementId = elementId
#    )
#  }

## -----------------------------------------------------------------------------
#  sparklines <- function(data, ..., width = NULL, height = NULL) {
#  
#    # describe a React component to send to the browser for rendering.
#    content <- reactR::component(
#      "Sparklines",
#      list(data = data, ...)
#    )
#  
#    # create widget
#    htmlwidgets::createWidget(
#      name = 'sparklines',
#      reactR::reactMarkup(content),
#      width = width,
#      height = height,
#      package = 'sparklines'
#    )
#  }

## -----------------------------------------------------------------------------
#  #' @export
#  sparklinesLine <- function(...) {
#    reactR::React$SparklinesLine(...)
#  }
#  
#  #' @export
#  sparklinesSpots <- function(...) {
#    reactR::React$SparklinesSpots(...)
#  }

## -----------------------------------------------------------------------------
#  system("yarn install")
#  system("yarn run webpack")
#  devtools::document()
#  devtools::install()
#  library(sparklines)
#  sparklines(rnorm(10), sparklinesLine())

## -----------------------------------------------------------------------------
#  library(shiny)
#  library(sparklines)
#  
#  ui <- fluidPage(
#    titlePanel("Sparklines library"),
#    sliderInput("n", label = "Number of samples", min = 2, max = 1000, value = 100),
#    sparklinesOutput("myWidget")
#  )
#  
#  server <- function(input, output, session) {
#      output$myWidget <- renderSparklines({
#          sparklines(
#              rnorm(input$n),
#              sparklinesLine()
#          )
#      })
#  }
#  
#  shinyApp(ui, server)

