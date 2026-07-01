## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(pins)

board <- board_temp()

## -----------------------------------------------------------------------------
pin_write_factor_json <- function(board, 
                                  x, 
                                  name, 
                                  title = NULL, 
                                  description = NULL, 
                                  metadata = list(), 
                                  versioned = NULL, 
                                  tags = NULL, 
                                  ...) {
  if (!is.factor(x)) rlang::abort("`x` is not a factor")
  factor_levels <- levels(x)
  metadata <- modifyList(metadata, list(factor_levels = factor_levels))
  pin_write(
    board = board, 
    x = x, 
    name = name, 
    type = "json", 
    title = title, 
    description = description, 
    metadata = metadata,
    ...
  )
}

## -----------------------------------------------------------------------------
ten_letters <- factor(sample(letters, size = 10), levels = letters)
board |> pin_write_factor_json(ten_letters, "letters-as-json")

## -----------------------------------------------------------------------------
board |> pin_read("letters-as-json")

## -----------------------------------------------------------------------------
pin_read_factor_json <- function(board, name, version = NULL, hash = NULL, ...) {
  ret <- pin_read(board = board, name = name, version = version, hash = hash, ...)
  meta <- pin_meta(board = board, name = name, version = version, ...)
  factor(ret, levels = meta$user$factor_levels)
}

board |> pin_read_factor_json("letters-as-json")

