module.exports = (robot) ->
  robot.respond /what up(.*)/i, (msg) ->
    giveStatus(msg)

  robot.respond /what's up(.*)/i, (msg) ->
    giveStatus(msg)

  robot.respond /status (.*)/i, (msg)->
    text = msg.match[1].trim()

    addStatus(msg, text)
    msg.send 'Roger.'

  addStatus = (msg, text) ->
    key = determineRoomKey(msg)
    data = robot.brain.get(key)
    unless data instanceof Array
      data = []
    data.push message
    robot.brain.set(key, data)

  giveStatus = (msg) ->
    roomName = msg.match[1].trim()
    roomName = msg.message.room if roomName == ''

    data = robot.brain.get(determineRoomKey(msg, msg.match[1]))
    msg.send "Status messages for #{roomName}"
    for message in data
      msg.send(message)

  determineRoomKey = (msg, roomName) ->
    "status_log_#{determineRoomName(msg, roomName)}"

  determineRoomName = (msg, roomName) ->
    if roomName == undefined || roomName.trim() == ''
      roomName = msg.message.room

    roomName.toLowerCase()
