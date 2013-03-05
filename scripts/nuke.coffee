# Description:
#   Display a picture of a nuke if someone says a keyword.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   nuke - Display a random picture of a nuke going off.
#
# Author:
#   Jeff McFadden

nukes = [
  "http://nukephotos.jeffmcfadden.com/001.jpg",
  "http://nukephotos.jeffmcfadden.com/002.jpg",
  "http://nukephotos.jeffmcfadden.com/003.jpg",
  "http://nukephotos.jeffmcfadden.com/004.jpg",
  "http://nukephotos.jeffmcfadden.com/005.jpg",
  "http://nukephotos.jeffmcfadden.com/006.jpg",
  "http://nukephotos.jeffmcfadden.com/007.jpg",
  "http://nukephotos.jeffmcfadden.com/008.jpg",
  "http://nukephotos.jeffmcfadden.com/009.jpg",
  "http://nukephotos.jeffmcfadden.com/010.jpg",
  "http://nukephotos.jeffmcfadden.com/011.jpg",
  "http://nukephotos.jeffmcfadden.com/012.jpg",
  "http://nukephotos.jeffmcfadden.com/013.jpg",
  "http://nukephotos.jeffmcfadden.com/014.jpg",
  "http://nukephotos.jeffmcfadden.com/015.jpg"
]

module.exports = (robot) ->

  words = ["nukes", "nuke", "nuclear", "diaf", "destroy", "destroyed"]
  regex = new RegExp('(?:^|\\s)(' + words.join('|') + ')(?:\\s|\\.|\\?|!|$)', 'i');

  robot.hear regex, (msg) ->
    msg.send msg.random nukes

