## ----echo = FALSE, message = FALSE--------------------------------------------
knitr::opts_chunk$set(comment = "")
library(V8)

## -----------------------------------------------------------------------------
# Create a new context
ct <- v8()

# Evaluate some code
ct$eval("var foo = 123")
ct$eval("var bar = 456")
ct$eval("foo + bar")

## -----------------------------------------------------------------------------
# Create some JSON
cat(ct$eval("JSON.stringify({x:Math.random()})"))

# Simple closure
ct$eval("(function(x){return x+1;})(123)")

## -----------------------------------------------------------------------------
ct$source('https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.13.6/underscore-min.js')
ct$source("https://cdnjs.cloudflare.com/ajax/libs/crossfilter/1.3.11/crossfilter.min.js")

## -----------------------------------------------------------------------------
ct$assign("mydata", mtcars)
ct$get("mydata")

## -----------------------------------------------------------------------------
ct$assign("foo", JS("function(x){return x*x}"))
ct$assign("bar", JS("foo(9)"))
ct$get("bar")

## -----------------------------------------------------------------------------
ct$call("_.filter", mtcars, JS("function(x){return x.mpg < 15}"))

## ----error=TRUE---------------------------------------------------------------
try({
js = 'function test_number(x){
  var promise = new Promise(function(resolve, reject) {
    if(x == 42)
      resolve(true)
    else
      reject("This is wrong")
  })
  return promise;
}'

# Call will just show a promise
ctx <- V8::v8()
ctx$eval(js)

# A promise does not return anything in itself:
ctx$call("test_number", 42)

# Resolve the promise to the result
ctx$call("test_number", 42, await = TRUE)

# A rejected promise will throw an error
ctx$call("test_number", 41, await = TRUE)
})

## ----eval=FALSE---------------------------------------------------------------
# # Load some data
# data(diamonds, package = "ggplot2")
# ct$assign("diamonds", diamonds)
# ct$console()

## ----eval=FALSE---------------------------------------------------------------
# output <- ct$get("output")
# print(output)

## ----eval=FALSE---------------------------------------------------------------
# ct <- v8()
# ct$source("https://cdnjs.cloudflare.com/ajax/libs/crossfilter/1.3.11/crossfilter.min.js")
# ct$eval('var cf = crossfilter || console.error("failed to load crossfilter!")')

## -----------------------------------------------------------------------------
ct <- v8();
ct$get(JS("Object.keys(global)"))

## -----------------------------------------------------------------------------
ct2 <- v8(global = NULL, console = FALSE)
ct2$get(JS("Object.keys(this).length"))
ct2$assign("cars", cars)
ct2$eval("var foo = 123")
ct2$eval("function test(x){x+1}")
ct2$get(JS("Object.keys(this).length"))
ct2$get(JS("Object.keys(this)"))

## -----------------------------------------------------------------------------
ct2$eval("var __global__ = this")
ct2$eval("(function(){var bar = [1,2,3,4]; __global__.bar = bar; })()")
ct2$get("bar")

## -----------------------------------------------------------------------------
ct$validate("function foo(x){2*x}")
ct$validate("foo = function(x){2*x}")

## -----------------------------------------------------------------------------
ct$validate("function(x){2*x}")

## -----------------------------------------------------------------------------
ct$validate("(function(x){2*x})")
ct$validate("!function(x){2*x}")

## ----eval=FALSE---------------------------------------------------------------
# ctx <- v8()
# ctx$console()

