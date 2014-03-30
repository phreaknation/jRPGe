class utilities
  constructor: (@name) ->
    self = this

    @.debug = RPG.load require("./utilities/debug")
    @.detect = RPG.load require("./utilities/detect")
    @.file = RPG.load require("./utilities/file")

    self
module.exports = utilities