## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = rlang::is_installed("webfakes")
)

## ----pin-mtcars---------------------------------------------------------------
library(pins)
board <- board_temp(versioned = TRUE)

## -----------------------------------------------------------------------------
board |> pin_write(mtcars, type = "json")

## -----------------------------------------------------------------------------
# we need a short delay here to keep the versions in the right order
Sys.sleep(2)

## ----metric-------------------------------------------------------------------
mtcars_metric <- mtcars
mtcars_metric$lper100km <- 235.215 / mtcars$mpg

board |> pin_write(mtcars_metric, name = "mtcars", type = "json")

## ----board-pin-list-----------------------------------------------------------
board |> pin_list()

board |> pin_versions("mtcars")

## -----------------------------------------------------------------------------
board |> write_board_manifest()

## -----------------------------------------------------------------------------
withr::with_dir(board$path, fs::dir_ls())

## ----board-serve--------------------------------------------------------------
board_server <- webfakes::new_app()
board_server$use(webfakes::mw_static(root = board$path))
board_process <- webfakes::new_app_process(board_server)

web_board <- board_url(board_process$url())

## -----------------------------------------------------------------------------
# web_board <- board_url("https://not.real.website.co/pins/")

## -----------------------------------------------------------------------------
web_board |> pin_list()

versions <- web_board |> pin_versions("mtcars")
versions

## -----------------------------------------------------------------------------
web_board |> pin_read("mtcars") |> head()

## -----------------------------------------------------------------------------
web_board |> pin_read("mtcars", version = versions$version[[1]]) |> head()

## -----------------------------------------------------------------------------
# board <- board_url("https://user-name.github.io/repo-name/pins-board/")

## -----------------------------------------------------------------------------
# board <- board_url("https://your-existing-bucket.s3.us-west-2.amazonaws.com/")

