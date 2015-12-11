$ = require 'jquery'

html5Weekly = require './weekly/html5.coffee'
cssWeekly = require './weekly/css.coffee'
javascriptWeekly = require './weekly/javascript.coffee'
nodeWeekly = require './weekly/node.coffee'
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
        html5Weekly (err, issue) ->
          renderIssue err, issue, 'html5'

      when 'css'
        cssWeekly (err, issue) ->
          renderIssue err, issue, 'css'

      when 'javascript'
        javascriptWeekly (err, issue) ->
          renderIssue err, issue, 'javascript'

      when 'node'
        nodeWeekly (err, issue) ->
          renderIssue err, issue, 'node'
