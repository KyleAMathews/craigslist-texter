craigslist-texter
=================

Poll a criagslist rss feed and text new postings as they show up

Requires a Twilio account and number to send the SMS messages

Run `npm install` to install the node dependencies.

Start the app like:
````
TWILIO_ACCOUNT_SID=get_from_twilio.com TWILIO_AUTH_TOKEN=get_from_twilio.com RSS_LINK='http://sfbay.craigslist.org/search/hhh?query=soma&format=rss&maxAsk=1700' TO_NUMBER='+YOUR_NUMBER' FROM_NUMBER='+YOUR_TWILIO_NUMBER' coffee index.coffee
````
