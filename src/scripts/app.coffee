$ = require 'jquery'
_ = require 'underscore'

javascriptWeekly = require './javascriptWeekly.coffee'
cssWeekly = require './cssWeekly.coffee'
showItems = require './showItems.coffee'

$issue = $ '#issue'

google.load 'feeds', 1

$ '#submit'
  .click (e) ->
    e.preventDefault()

    $issue.empty()
    weekly  = $('#select').val()

    if weekly is 'javascript'
      javascriptWeekly (err, items) ->
        if err is 'err'
          $issue.append 'Issueを取得できませんでした。'
          return

        showItems items
    else if weekly is 'css'
      cssWeekly (err, items) ->
        if err is 'err'
          $issue.append 'Issueを取得できませんでした。'
          return

        compiled = _.template $('#css-template').text()
        items.forEach (item) ->
          $issue.append compiled item

