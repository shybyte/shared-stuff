'use strict'

log = (t)->
  console.log(t)

focus = (id)->
  setTimeout(->
      $('#' + id).focus()
    , 100)

this.utils =
  log: log
  focus: focus