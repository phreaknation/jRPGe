class utilities
  constructor: (@name) ->
    self = this

    @.convert = RPG.load require("./utilities/convert")
    @.debug = RPG.load require("./utilities/debug")
    # @.detect = RPG.load require("./utilities/detect")
    # @.file = RPG.load require("./utilities/file")
    @.misc = RPG.load require("./utilities/misc")
    # @.timex = RPG.load require("./utilities/timex")

    self
module.exports = utilities