class manager
  constructor: () ->
    self = this

    @.registry = RPG.load require("./manager/registry")

    self
module.exports = manager