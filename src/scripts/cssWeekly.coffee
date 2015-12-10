cheerio = require 'cheerio'

module.exports = (cb) ->
  items = []

  feed = new google.feeds.Feed 'http://feeds.feedburner.com/CSS-Weekly'
  feed.setNumEntries 1
  feed.load (result) ->
    if result.error
      cb 'err', null
      return

    $ = cheerio.load result.feed.entries[0].content

    $target = $('h2').eq(0)

    while $target.text().indexOf('Sponsor') is -1
      if $target.is 'h2'
        item = {}
        item.title = $target.text()
        item.link = $target.find('a').attr('href')
        item.img = $target.next().find('img').attr('src')
        item.text = $target.next().next().text()
        items.push item

      $target = $target.next()

    # Articles & Tutorials
    $target = $('h1').eq(1)
    while $target.text().indexOf('Jobs') is -1
      if $target.is 'h2'
        item = {}
        item.title = $target.text()
        item.link = $target.find('a').attr('href')
        item.text = $target.next().text()
        item.img = ""
        items.push item

      $target = $target.next()

    # Tooles
    $target = $('h1').eq(3)
    while $target.text().indexOf('Inspiration') is -1
      if $target.is 'h2'
        item = {}
        item.title = $target.text()
        item.link = $target.find('a').attr('href')
        item.text = $target.next().text()
        item.img = ""
        items.push item

      $target = $target.next()

    # Inspiration
    $target = $('h1').eq(4)
    while $target.text().indexOf('Until Next Week') is -1
      if $target.is 'h2'
        item = {}
        item.title = $target.text()
        item.link = $target.find('a').attr('href')
        item.img = $target.next().find('img').attr('src')
        item.text = $target.next().next().text()
        item.img = ""
        items.push item

      $target = $target.next()

    cb null, items
