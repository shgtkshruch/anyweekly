cheerio = require 'cheerio'
moment = require 'moment'

module.exports = (cb) ->
  issue = {}
  issue.items = []

  feed = new google.feeds.Feed 'http://javascriptweekly.com/rss'
  feed.setNumEntries 1
  feed.load (result) ->
    if result.error
      cb 'err', null
      return

    entry = result.feed.entries[0]
    issue.title = result.feed.title
    issue.num = entry.title.match(/\s(\d+)$/)[1]
    issue.date = moment(new Date(entry.publishedDate)).format('MMMM D, YYYY')

    $ = cheerio.load result.feed.entries[0].content

    # top
    $ 'table table:nth-child(2) div:first-child'
      .each (i, elm) ->
        if $(@).next().next().text().indexOf('Sponsored') > -1
          return

        item = {}
        item.heading = $(@).find('a').text()
        item.link = $(@).find('a').attr('href')
        item.text = $(@).next().html()
        item.author = $(@).next().next().text()
        issue.items.push item

    # brief
    $ 'table table:nth-child(2) ul:last-child'
      .find 'li'
      .each (i, elm) ->
        if $(@).find('span:last-child').text().indexOf('Sponsored') > -1
          return

        item = {}
        item.heading = $(@).find('> a').text()
        item.link = $(@).find('> a').attr('href')

        text = $(@).find('span:nth-last-child(2)').text()
        if text.length > 10
          item.text = text
        else
          item.text = ""

        item.author = $(@).find('span:last-child').text()

        issue.items.push item

    cb null, issue
