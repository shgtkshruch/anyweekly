cheerio = require 'cheerio'

module.exports = (cb) ->
  items = []

  feed = new google.feeds.Feed 'http://html5weekly.com/rss'
  feed.setNumEntries 1
  feed.load (result) ->
    if result.error
      cb 'err', null
      return

    $ = cheerio.load result.feed.entries[0].content

    # top
    $target = $ 'table table:nth-child(2) tr:nth-child(2) table:first-child'
    while $target.next().next().text().indexOf('Jobs') is -1
      if $target.find('tr td div:nth-child(2)').text().indexOf('Sponsored') > -1
        $target = $target.next()
        continue

      if $target.text().length > 0
        item = {}
        item.heading = $target.find('tr > td > div:first-child > a').text()
        item.link = $target.find('tr > td > div:first-child > a').attr('href')
        item.text = $target.find('tr > td > div:nth-child(3)').text()
        item.author = $target.find('tr > td > div:nth-child(2)').text()
        items.push item

      $target = $target.next()

    # brief
    $ 'table table:nth-child(2) tr:nth-child(2) ul:last-child > li'
      .each (i, elm) ->
        if $(@).find('> span > span').text().indexOf('SPONSOR') > -1
          return

        item = {}
        item.heading = $(@).find('> a').text()
        item.link = $(@).find('> a').attr('href')
        item.author = $(@).find('> span:last-child').text()
        text = $(@).find('> span:nth-last-child(2)').text()
        item.text = if text.length > 10 then text else ""
        items.push item

    cb null, items

