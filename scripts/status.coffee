module.exports = (robot) ->

  key = 'teeder_status'
  maxMessageLength = 140
  maxMessageHistory = 100
  defaultResponseSize = 5


  robot.respond /(.*)/i, (msg) ->
    message =  msg.match[1].trim().substring(0,maxMessageLength)
    if message.match /wha/
      getStatus(msg)
    else
      msg.send message
      putStatus(message)

  putStatus = (message, text) ->
    data = robot.brain.get(key)
    unless data instanceof Array
      data = []
    data.unshift message
    robot.brain.set(key, data.slice(0,defaultResponseSize))

  getStatus = (msg) ->
    data = robot.brain.get(key).slice(0, defaultResponseSize).reverse()
    for message in data
      msg.send(message)
