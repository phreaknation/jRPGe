class ui
  constructor: (@name) ->
    self = this

    @.menu = RPG.load require("./ui/menu")
    @.messages = RPG.load require("./ui/messages")

    self
module.exports = ui