## ----echo = FALSE, message = FALSE--------------------------------------------
knitr::opts_chunk$set(comment = "")
library(V8)

## -----------------------------------------------------------------------------
ct <- v8()
ct$source('https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.13.6/underscore-min.js')
ct$call("_.filter", mtcars, JS("function(x){return x.mpg < 15}"))

## ----eval=FALSE---------------------------------------------------------------
# ct <- v8()
# ct$source("~/Desktop/bundle.js")

## ----echo=FALSE, results='hide'-----------------------------------------------
# Hack because we unbundled this library
ct <- v8()
ct$source("https://cdnjs.cloudflare.com/ajax/libs/js-beautify/1.14.7/beautify.min.js")
ct$source("https://cdnjs.cloudflare.com/ajax/libs/js-beautify/1.14.7/beautify-html.js")
ct$eval('global.beautify = {js_beautify:js_beautify, html_beautify:html_beautify}')

## -----------------------------------------------------------------------------
ct$get(JS('Object.keys(global)'))

## -----------------------------------------------------------------------------
test <- "(function(x,y){x = x || 1; y = y || 1; return y * x;})(4, 9)"
pretty_test <- ct$call("beautify.js_beautify", test, list(indent_size = 2))
cat(pretty_test)

## -----------------------------------------------------------------------------
html <- "<ul><li>one</li><li>two</li><li>three</li></ul>"
cat(ct$call("beautify.html_beautify", html))

