FeedParser = require('feedparser')
request = require('request')
_ = require('underscore')
winston = require('winston')

# Setup twilio client.
twilioClient = require('twilio')()

links = {}

# if new, text
request(process.env.RSS_LINK)
  .pipe(new FeedParser())
  .on('error', (error) ->
    console.log 'error', error
  )
  .on('meta', (meta) ->
    newAds = []
    results = _.map(meta['rdf:items']['seq']['li'], (item) -> return item['@']['resource'])
    for result in results
      if result not in links
        newAds.push result
        links[result] = 'sent'

    # Send new ads to phone number
    if newAds.length > 0
      for ad in newAds
        console.log 'new ad:', ad
        #twilioClient.sms.messages.create({
          #body: "New room postings for inner sunset: #{ ad }",
          #to: process.env.TO_NUMBER,
          #from: process.env.FROM_NUMBER
        #}, (err, message) ->
          #if err
            #winston.error err
          #else
            #winston.log 'sent message', message
        #)
  )
