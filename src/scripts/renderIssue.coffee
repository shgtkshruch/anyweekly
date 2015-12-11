$ = require 'jquery'
_ = require 'underscore'

module.exports = (err, items, templatePrefix, issueTitle) ->
  if err is 'err'
    $issue.append 'Issueを取得できませんでした。'
    return

  $issue = $ '#issue'
  $ul = $ '<ul class="issue__container"></ul>'
  compiled = _.template $('#'+ templatePrefix + '-template').text()

  items.forEach (item) ->
    $ul.append compiled item
  $issue.html $ul
  $issue.prepend '<h1 class="issue__title">' + issueTitle + ' Weekly</h1>'
  $issue.fadeToggle()
