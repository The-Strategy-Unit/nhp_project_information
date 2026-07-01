## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = FALSE
)

## ----setup--------------------------------------------------------------------
# library(pins)

## -----------------------------------------------------------------------------
# # Legacy API
# board_register_local("vignette", tempfile())
# 
# pin(head(mtcars), "mtcars", board = "vignette")
# pin_get("mtcars", board = "vignette")

## -----------------------------------------------------------------------------
# # Modern API
# board <- board_local()
# 
# pin_write(board, head(mtcars), "mtcars")
# pin_read(board, "mtcars")

## ----echo=FALSE---------------------------------------------------------------
# Sys.sleep(1)

## -----------------------------------------------------------------------------
# # Modern API
# board <- board_local()
# 
# board |> pin_write(head(mtcars), "mtcars")
# board |> pin_read("mtcars")

## -----------------------------------------------------------------------------
# # Legacy API
# path <- tempfile()
# writeLines(letters, path)
# 
# pin(path, "alphabet", board = "vignette")
# pin_get("alphabet", board = "vignette")

## -----------------------------------------------------------------------------
# # Modern API
# board |> pin_upload(path, "alphabet")
# board |> pin_download("alphabet")

## -----------------------------------------------------------------------------
# # Legacy API
# base <- "https://raw.githubusercontent.com/rstudio/pins-r/main/tests/testthat/"
# 
# (pin(paste0(base, "pin-files/first.txt"), board = "vignette"))

## -----------------------------------------------------------------------------
# # Modern API
# board_github <- board_url(c(
#   raw = paste0(base, "pin-files/first.txt")
# ))
# board_github |> pin_download("raw")

## -----------------------------------------------------------------------------
# # Legacy API
# pin(data.frame(x = 1:3), "test-data")
# pin_get("test-data")

## -----------------------------------------------------------------------------
# # Modern API
# board <- board_local()
# 
# board |> pin_write(data.frame(x = 1:3), "test-data")
# board |> pin_read("test-data")

