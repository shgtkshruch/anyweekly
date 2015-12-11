$ = require 'jquery'

html5Weekly = require './weekly/html5.coffee'
cssWeekly = require './weekly/css.coffee'
javascriptWeekly = require './weekly/javascript.coffee'
renderIssue = require './renderIssue.coffee'

$issue = $ '#issue'

google.load 'feeds', 1

$ '#select'
  .change (e) ->
    e.preventDefault()

    $issue.empty().hide()
    weekly  = $(@).val()

    switch weekly
      when 'html5'
        html5Weekly (err, items) ->
          renderIssue err, items, 'html5', 'HTML5'

      when 'css'
        cssWeekly (err, items) ->
          renderIssue err, items, 'css', 'CSS'

      when 'javascript'
        javascriptWeekly (err, items) ->
          renderIssue err, items, 'javascript', 'JavaScript'

