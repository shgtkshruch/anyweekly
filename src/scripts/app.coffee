$ = require 'jquery'

javascriptweekly = require './javascriptWeekly.coffee'
showItems = require './showItems.coffee'

$issue = $ '#issue'

$ '#submit'
  .click (e) ->
    e.preventDefault()

    $issue.empty()
    weekly  = $('#select').val()

    if weekly == 'javascript'
      javascriptweekly $('#issueNum').val(), (err, items) ->
        if err is 'err'
          $issue.append 'Issueを取得できませんでした。'
          return

        showItems items
