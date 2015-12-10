$ = require 'jquery'

module.exports = (items) ->
  $issue = $ '#issue'
  $ul = $ '<ul></ul>'

  items.forEach (item) ->
    $li = $ '<li></li>'

    $title = $ '<a></a>'
    $title.attr 'href', item.link
    $title.text item.title

    $text = $ '<p></p>'
    $text.html item.text

    $author = $ '<p></p>'
    $author.text item.author

    $li.append $title
    $li.append $text
    $li.append $author
    $ul.append $li

  $issue.append $ul
