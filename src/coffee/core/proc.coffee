class proc
  constructor: (@name) ->
    self = this

    @.project = RPG.load require("./proc/project")

    self
module.exports = proc