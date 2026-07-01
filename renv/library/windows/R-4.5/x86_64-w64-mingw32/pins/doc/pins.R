## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
) 

# Fake testing environment to get consistent hashes
Sys.setenv("TESTTHAT" = "true")
options(pins.quiet = FALSE)

## -----------------------------------------------------------------------------
library(pins)

## -----------------------------------------------------------------------------
board <- board_temp()

## ----eval = FALSE-------------------------------------------------------------
# board <- board_local() # share data across R sessions on the same computer
# board <- board_folder("~/Dropbox") # share data with others using dropbox
# board <- board_folder("Z:\\my-team\pins") # share data using a shared network drive
# board <- board_connect() # share data with Posit Connect

## -----------------------------------------------------------------------------
mtcars <- tibble::as_tibble(mtcars)
board |> pin_write(mtcars, "mtcars")

## -----------------------------------------------------------------------------
board |> pin_read("mtcars")

## -----------------------------------------------------------------------------
board |> pin_meta("mtcars")

## ----echo=FALSE---------------------------------------------------------------
Sys.sleep(1)

## -----------------------------------------------------------------------------
board |> pin_write(mtcars, 
  description = "Data extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models).",
  metadata = list(
    source = "Henderson and Velleman (1981), Building multiple regression models interactively. Biometrics, 37, 391–411."
  ),
  # Necessary if only changing pin metadata but pin content is the same
  force_identical_write = TRUE
)
board |> pin_meta("mtcars")

## ----eval = FALSE-------------------------------------------------------------
# board2 <- board_temp(versioned = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# board2 <- board_temp()
# board2 |> pin_write(mtcars, versioned = TRUE)

## -----------------------------------------------------------------------------
board2 <- board_temp(versioned = TRUE)

board2 |> pin_write(1:5, name = "x", type = "rds")
board2 |> pin_write(2:6, name = "x", type = "rds")
board2 |> pin_write(3:7, name = "x", type = "rds")

## -----------------------------------------------------------------------------
board2 |> pin_versions("x")

## -----------------------------------------------------------------------------
board2 |> pin_read("x")

## ----eval = FALSE-------------------------------------------------------------
# board2 |> pin_read("x", version = "20210520T173110Z-49519")

## -----------------------------------------------------------------------------
paths <- file.path(tempdir(), c("mtcars.csv", "alphabet.txt"))
write.csv(mtcars, paths[[1]])
writeLines(letters, paths[[2]])

## -----------------------------------------------------------------------------
board |> pin_upload(paths, "example")

## -----------------------------------------------------------------------------
board |> pin_download("example")

## ----error = TRUE-------------------------------------------------------------
try({
board |> pin_read("example")
})

## -----------------------------------------------------------------------------
board |> pin_download("mtcars")

## -----------------------------------------------------------------------------
my_data <- board_url(c(
  "penguins" = "https://raw.githubusercontent.com/allisonhorst/palmerpenguins/master/inst/extdata/penguins_raw.csv"
))

## -----------------------------------------------------------------------------
my_data |>
  pin_download("penguins") |> 
  read.csv(check.names = FALSE) |> 
  tibble::as_tibble()

