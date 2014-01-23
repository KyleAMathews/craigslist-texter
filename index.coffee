FeedParser = require('feedparser')
request = require('request')
_ = require('underscore')
winston = require('winston')

# Setup twilio client.
twilioClient = require('twilio')()

links = {}

sendSMS = (body) ->
  twilioClient.sms.messages.create({
    body: body
    to: process.env.TO_NUMBER,
    from: process.env.FROM_NUMBER
  }, (err, message) ->
    if err
      winston.error err
    else
      winston.log 'sent message', message
  )

pollCraigslist = ->
  request(process.env.RSS_LINK)
    .pipe(new FeedParser())
    .on('error', (error) ->
      console.log 'error', error
    )
    .on('meta', (meta) ->
      newPostings = []
      results = _.map(meta['rdf:items']['seq']['li'], (item) -> return item['@']['resource'])

      # If the app was just started, don't text any posts. Instead, add all the
      # links to the links object and sms that things are working correctly.
      if _.keys(links).length is 0
        links[result] = 'added' for result in results
        sendSMS("The craigslist texting app is setup and running correctly! It will
          search every minute for new posts.")
      else
        for result in results
          if result not of links
            newPostings.push result
            links[result] = 'sent'

        # Send new posts to phone number
        if newPostings.length > 0
          for post in newPostings
            sendSMS("New room postings for inner sunset: #{ post }")
        else
          console.log 'no new postings'
    )

pollCraigslist()
setInterval(pollCraigslist, 60000)
