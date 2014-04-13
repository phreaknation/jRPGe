class manager
  constructor: () ->
    self = this

    # @.events = RPG.load require("./manager/events")
    @.phrase = RPG.load require("./manager/phrase")
    @.resources = RPG.load require("./manager/resources")

    self
module.exports = manager