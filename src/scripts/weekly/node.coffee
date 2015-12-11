cheerio = require 'cheerio'
moment = require 'moment'

module.exports = (cb) ->
  issue = {}
  issue.items = []

  feed = new google.feeds.Feed 'http://nodeweekly.com/rss'
  feed.setNumEntries 1
  feed.load (result) ->
    if result.error
      cb 'err', null
      return

    entry = result.feed.entries[0]
    issue.title = result.feed.title
    issue.num = entry.link.match(/\/(\d+)$/)[1]
    issue.date = moment(new Date(entry.publishedDate)).format('MMMM D, YYYY')

    $ = cheerio.load result.feed.entries[0].content

    # top
    $target = $ 'table table:nth-child(2) tr:nth-child(2) > td > div:first-child'
    while $target.text().indexOf('Jobs') is -1
      if $target.find('> span').text().indexOf('Sponsored') > -1
        $target = $target.next()
        continue

      if $target.is 'div'
        item = {}
        item.author = $target.text()
        item.heading = $target.next().find('div:first-child').text()
        item.link = $target.next().find('div:first-child > a').attr('href')
        item.text = $target.next().find('div:last-child').html()
        issue.items.push item

      $target = $target.next()

    # brief
    $ 'table table:nth-child(2) tr:nth-child(2) > td > ul:last-child > li'
      .each (i, elm) ->
        if $(@).find('> span:last-child > span').text().indexOf('Sponsored') > -1
          return

        item = {}
        item.heading = $(@).find('> a:first-child').text()
        item.link = $(@).find('> a:first-child').attr('href')
        item.author = $(@).find('> span:last-child').text()
        text = $(@).find('> span:nth-last-child(2)').text()
        item.text = if text.length > 10 then text else ""
        issue.items.push item

    cb null, issue
