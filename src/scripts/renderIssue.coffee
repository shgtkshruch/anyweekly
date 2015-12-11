$ = require 'jquery'
_ = require 'underscore'

module.exports = (err, issue, templatePrefix) ->
  $issue = $ '#issue'

  if err is 'err'
    $issue.append 'Issueを取得できませんでした。'
    return

  $ul = $ '<ul class="issue__container"></ul>'
  bodyTemplate = _.template $('#'+ templatePrefix + '-template').text()
  titleTemplate = _.template $('#title-template').text()

  issue.items.forEach (item) ->
    $ul.append bodyTemplate item
  $issue.html $ul
  $issue.prepend titleTemplate issue
  $issue.fadeToggle()
