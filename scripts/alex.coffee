module.exports = (robot) ->
  robot.respond /what up(.*)/i, (msg) ->
    room_name = msg.match[1].trim()
    room_name = msg.message.room if room_name == ''

    data = robot.brain.get("status_log_#{room_name}")
    msg.send "Status messages for #{room_name}"
    for message in data
      msg.send(message)

  robot.respond /status (.*)/i, (msg)->
    text = msg.match[1].trim()
    room = msg.message.room

    add_to_room(room, text)
    msg.send 'Roger.'

  robot.respond /why.*/i, (msg)->
    msg.send 'Because'

  add_to_room = (room, message) ->
    key = "status_log_#{room}"
    console.log key
    data = robot.brain.get(key)
    unless data instanceof Array
      data = []
    data.push message
    robot.brain.set(key, data)

