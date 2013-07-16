# Description:
#   Allow Hubot to show what's lurking behind a CloudApp link.
#   Updated 7/2013 to only grab links that are inline in a message.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   http://cl.ly/* - Detects the drop's type and displays it or prints its content if it's an image or text file respectively
#
# Author:
#   lmarburger

module.exports = (robot) ->
  robot.hear /([\s\S]*)(https?:\/\/(cl.ly|mcph.at|kvg.me|benm.in|prstp.me|anvl.me)\/image\/[A-Za-z0-9]+)(\/[^\/]+)?([\s\S]*)/i, (msg) ->
    return if msg.match[4]  # Ignore already embedded images.
    return if msg.match[1] == "" && msg.match[5] == "" # Ignore messages that flint will auto embed (just the image)

    link = msg.match[2]
    msg
      .http(link)
      .headers(Accept: "application/json")
      .get() (err, res, body) ->
        unless res.statusCode is 200
          msg.send "No drop at #{link}! It may have been deleted."
          return

        drop = JSON.parse body
        switch drop.item_type
          when 'image'
            msg.send drop.content_url
          when 'text'
            send_drop_content msg, drop.content_url

send_drop_content = (msg, url) ->
  msg
    .http(url)
    .get() (err, res, body) ->
      if res.statusCode is 302
        # Follow the breadcrumbs of redirects.
        send_drop_content msg, res.headers.location
      else
        body += "\n" unless ~body.indexOf("\n")
        msg.send body
