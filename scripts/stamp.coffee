# Description:
#   A way to interact with the Stamp URI.
#
# Commands:
#   hubot stamp me <keyword> - The Original. Queries Stamp Images for <keyword> and returns a stamp image.
#   hubot stamp list         - Show a list of keywords.

stamps = JSON.parse(process.env.HUBOT_STAMPS)

module.exports = (robot) ->
  robot.hear /(stamp|stp) (.*)/i, (msg) ->
    response = if msg.match[2] == 'list'
      keys = for key, value of stamps
               key
      keys.join(',')
    else
      keyword = msg.match[2]
      stamps[keyword] ? "No stamp for #{keyword}"
    msg.send response
