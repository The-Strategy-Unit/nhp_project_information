## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = requireNamespace("xml2", quietly = TRUE)
)

## ----setup--------------------------------------------------------------------
library(pins)

## -----------------------------------------------------------------------------
library(xml2)

if (interactive()) {
  xml <- read_xml("http://feeds.bbci.co.uk/news/rss.xml")  
} else {
  # Read a saved version of the data to keep this vignette reproducible
  xml <- read_xml("bbc-news.xml")  
}

items <- xml |> xml_find_all("//item")

bbc_news <- tibble::tibble(
  title = items |> xml_find_first("./title") |> xml_text(),
  date = items |> xml_find_first("./pubDate") |> xml_text(),
  url = items |> xml_find_first("./guid") |> xml_text()
)
bbc_news

## ----eval = FALSE-------------------------------------------------------------
# board <- board_connect()
# board |> pin_write(bbc_news)

## ----eval=FALSE---------------------------------------------------------------
# board <- board_connect()
# board |> pin_read("your_name/bbc_news")

## ----echo = FALSE, comment = ""-----------------------------------------------
cat(readLines("connect-automate.txt"), sep = "\n")

## ----eval=FALSE---------------------------------------------------------------
# library(shiny)
# library(pins)
# 
# board <- board_connect()
# 
# ui <- fluidPage(
#   titlePanel("News from the BBC"),
#   htmlOutput("news")
# )
# 
# server <- function(input, output, session) {
#   news <- board |> pin_reactive_read("hadley/bbc_news")
# 
#   output$news <- renderUI({
#     title <- htmltools::htmlEscape(news()$title)
#     links <- paste0("<a href='", news()$url, "'>", title, "</a>")
#     bullets <- paste0("  <li>", links, "</li>", collapse = "\n")
#     HTML(paste0("<ul>", bullets, "</ul>"))
#   })
# }
# 
# shinyApp(ui, server)

