class scene
  constructor: (@name) ->
    self = this

    @.battle = RPG.load require("./scene/battle")
    @.intro = RPG.load require("./scene/intro")
    @.title = RPG.load require("./scene/title")
    @.world = RPG.load require("./scene/world")

    self
module.exports = scene