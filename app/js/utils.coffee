'use strict'

log = (t)->
  console.log(t)

focus = (id)->
  setTimeout(->
      $('#' + id).focus()
    , 100)

cleanObjectFromAngular = (items) ->
  for item in items
    for own key, value of item
      if key.indexOf('$$')>=0
        delete item[key]

this.utils =
  log: log
  focus: focus
  cleanObjectFromAngular: cleanObjectFromAngular