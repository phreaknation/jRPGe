class entity
  constructor: (@name) ->
    self = this

    @.npc = RPG.load require("./entity/npc")
    @.pc = RPG.load require("./entity/pc")

    self
module.exports = entity