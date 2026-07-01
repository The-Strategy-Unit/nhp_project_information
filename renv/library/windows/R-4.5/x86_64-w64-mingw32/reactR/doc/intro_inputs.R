## ----echo=FALSE, include=FALSE------------------------------------------------
knitr::opts_chunk$set(eval = FALSE)

## -----------------------------------------------------------------------------
#  install.packages(c("shiny", "devtools", "usethis", "reactR"))

## -----------------------------------------------------------------------------
#  # Create the R package (rstudio=TRUE is recommended if you're not already comfortable with your terminal)
#  usethis::create_package("~/colorpicker", rstudio = TRUE)
#  # Scaffold initial input implementation files
#  withr::with_dir(
#    "~/colorpicker",
#    reactR::scaffoldReactShinyInput("colorpicker", list("react-color" = "^2.17.0"), edit = FALSE)
#  )

## -----------------------------------------------------------------------------
#  devtools::document()
#  devtools::install(quick = TRUE)

## -----------------------------------------------------------------------------
#  shiny::runApp()

