## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = rlang::is_installed("arrow")
)

## ----setup--------------------------------------------------------------------
library(pins)

board <- board_temp()

## -----------------------------------------------------------------------------
pin_name <- "mtcars-arrow"

# file name will be `mtcars-arrow.arrow`
path <- fs::path_temp(fs::path_ext_set(pin_name, "arrow"))

arrow::write_feather(mtcars, path, compression = "uncompressed")

pin_upload(board, paths = path, name = pin_name)

## -----------------------------------------------------------------------------
mtcars_download <- 
  pin_download(board, pin_name) |>
  arrow::read_feather()

head(mtcars_download)

## -----------------------------------------------------------------------------
pin_upload_arrow <- function(board, x, name, ...) {
  # path deleted when `pin_upload_arrow()` exits
  path <- fs::path_temp(fs::path_ext_set(name, "arrow"))
  withr::defer(fs::file_delete(path))
  
  # custom writer
  arrow::write_feather(x, path, compression = "uncompressed")
  
  pin_upload(board, paths = path, name = name, ...) 
}

## -----------------------------------------------------------------------------
pin_upload_arrow(board, x = mtcars, name = "mtcars-arrow2")

## -----------------------------------------------------------------------------
pin_download(board, name = "mtcars-arrow2") |>
  arrow::read_feather() |>
  head()

## -----------------------------------------------------------------------------
pin_upload_archive <- function(board, dir, name, ...) {
  path <- fs::path_temp(fs::path_ext_set(name, "tar.gz"))
  withr::defer(fs::file_delete(path))
  archive::archive_write_dir(path, dir)
  pin_upload(board = board, paths = path, name = name, ...)
}

