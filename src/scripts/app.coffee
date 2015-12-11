$ = require 'jquery'

javascriptWeekly = require './weekly/javascript.coffee'
cssWeekly = require './weekly/css.coffee'
renderIssue = require './renderIssue.coffee'

$issue = $ '#issue'

google.load 'feeds', 1

$ '#select'
  .change (e) ->
    e.preventDefault()

    $issue.empty().hide()
    weekly  = $(@).val()

    switch weekly
      when 'javascript'
        javascriptWeekly (err, items) ->
          renderIssue err, items, 'javascript', 'JavaScript'

      when 'css'
        cssWeekly (err, items) ->
          renderIssue err, items, 'css', 'CSS'
