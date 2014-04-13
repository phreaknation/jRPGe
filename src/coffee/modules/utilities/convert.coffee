class convert
  constructor: (@name) ->
    self = this
    self
  gridToPixel: (coord, useScaleFactor) ->
    project = RPG.manager.registry.acquire("project")
    parseInt(coord) * RPG.utilities.misc.cellSpacing(useScaleFactor)
  pixelToGrid: (coord, useScaleFactor) ->
    project = RPG.manager.registry.acquire("project")
    Math.ceil parseInt(coord) / RPG.utilities.misc.cellSpacing(useScaleFactor)
module.exports = convert