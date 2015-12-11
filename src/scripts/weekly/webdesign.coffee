cheerio = require 'cheerio'
moment = require 'moment'

module.exports = (cb) ->
  issue = {}
  issue.items = []

  feed = new google.feeds.Feed 'http://feeds.feedburner.com/webdesignweekly'
  feed.setNumEntries 1
  feed.load (result) ->
    if result.error
      cb 'err', null
      return

    entry = result.feed.entries[0]
    issue.title = result.feed.title
    issue.num = entry.title.match(/#(\d+)$/)[1]
    issue.date = moment(new Date(entry.publishedDate)).format('MMMM D, YYYY')

    $ = cheerio.load result.feed.entries[0].content

    $target = $('h2').eq(0)
    while $target.text().indexOf('Articles') is -1
      if $target.is('h3') or $target.is('h4')
        item = {}
        item.heading = $target.text()
        item.link = $target.find('a').attr('href')
        item.text = if $target.next().is('p') then $target.next().text() else ""
        issue.items.push item

      $target = $target.next()

    $target = $target.next()
    while !$target.is('h2')
      if $target.is('h3') or $target.is('h4')
        item = {}
        item.heading = $target.text()
        item.link = $target.find('a').attr('href')
        item.text = if $target.next().is('p') then $target.next().text() else ""
        issue.items.push item

      $target = $target.next()

    $target = $target.next()
    while !$target.is('h2')
      if $target.is('h3') or $target.is('h4')
        item = {}
        item.heading = $target.text()
        item.link = $target.find('a').attr('href')
        item.text = if $target.next().is('p') then $target.next().text() else ""
        issue.items.push item

      $target = $target.next()

    $target = $target.next()
    while !$target.is('h2')
      if $target.is('h3') or $target.is('h4')
        item = {}
        item.heading = $target.text()
        item.link = $target.find('a').attr('href')
        item.text = if $target.next().is('p') then $target.next().text() else ""
        issue.items.push item

      $target = $target.next()

    cb null, issue
