class io
  constructor: (@name) ->
    self = this

    @.joypad = RPG.load require("./io/joypad")
    @.keyboard = RPG.load require("./io/keyboard")
    @.mouse = RPG.load require("./io/mouse")
    @.touch = RPG.load require("./io/touch")

    self
module.exports = io