$ = require 'jquery'
_ = require 'underscore'

javascriptWeekly = require './weekly/javascript.coffee'
cssWeekly = require './weekly/css.coffee'

$issue = $ '#issue'

google.load 'feeds', 1

$ '#select'
  .change (e) ->
    e.preventDefault()

    $issue.empty()
    weekly  = $(@).val()

    if weekly is 'javascript'
      javascriptWeekly (err, items) ->
        if err is 'err'
          $issue.append 'Issueを取得できませんでした。'
          return

        $ul = $ '<ul class="issue__container"></ul>'
        compiled = _.template $('#javascript-template').text()

        items.forEach (item) ->
          $ul.append compiled item
        $issue.html $ul
        $issue.prepend '<h1 class="issue__title">JavaScript Weekly</h1>'

    else if weekly is 'css'
      cssWeekly (err, items) ->
        if err is 'err'
          $issue.append 'Issueを取得できませんでした。'
          return

        $ul = $ '<ul class="issue__container"></ul>'
        compiled = _.template $('#css-template').text()

        items.forEach (item) ->
          $ul.append compiled item
        $issue.html $ul
        $issue.prepend '<h1 class="issue__title">CSS Weekly</h1>'
