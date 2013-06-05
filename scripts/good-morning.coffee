# Description:
#   Displays a good morning summary message
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Notes:
#
#
# Author:
#   jeffmcfadden

module.exports = (robot) ->
  robot.hear /(good morning)/i, (msg) ->
    name = msg.message.user.name
    if name == 'Jeff McFadden'
      good_morning_jeff_mcfadden robot, msg, name
    else
      good_morning_unknown


# check cache, get data, store data, invoke callback.
good_morning_unknown = (robot, msg, username) ->
  a = 1+1
  #Do nothing, basically


good_morning_jeff_mcfadden = (robot, msg, username) ->
  good_morning_message = ""

  weather_api_url = "https://api.forecast.io/forecast/70e2c5f55ac79f93b5a8c408eb8a713e/33.6751,-112.2309"

  msg.send "Good morning, " + username + "!"

  msg.send "Here's the upcoming weather:"

  msg
    .http(weather_api_url)
    .get() (err, res, body) ->
      data = JSON.parse(body)

      # error
      if data.response?.error?
        msg.send data.response.error.description
      else
        line_1 = "";
        line_2 = "";
        line_3 = "";

        limit_output = 5;

        for e in data['daily']['data']
          DAYS = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
          d = new Date( e['time'] * 1000 );

          line_1 += DAYS[d.getDay()] + '' + ' | ';
          if Math.round( e['temperatureMax'] ) > 100
            space = ''
          else
            space = ' '

          line_2 += space + Math.round( e['temperatureMax'] )  + ' | ';
          line_3 += ' ' + Math.round( e['temperatureMin'] )  + ' | ';

        output = line_1 + "\n" + line_2 + "\n" + line_3;
        msg.send output
