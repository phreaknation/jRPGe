class setup
  constructor: (@name) ->
    self = this

    @.canvas = RPG.load require("./setup/canvas")

    self
module.exports = setup