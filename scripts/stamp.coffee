# Description:
#   A way to interact with the Stamp URI.
#
# Commands:
#   hubot stamp me <keyword> - The Original. Queries Stamp Images for <keyword> and returns a stamp image.
#   hubot stamp list         - Show a list of keywords.

stamps = JSON.parse(process.env.HUBOT_STAMPS)

module.exports = (robot) ->
  robot.respond /stamp me (.*)/i, (msg) ->
    keyword = msg.match[1]
    msg.send stamps[keyword] ? "No stamp for #{keyword}"

  robot.respond /stamp list/i, (msg) ->
    keys = for key, value of stamps
             key
    msg.send keys.join('\n')
