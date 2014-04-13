class misc
  constructor: (@name) ->
    self = this
    self
  cellSpacing: (useScaleFactor) ->
    scaleFactor = 1
    scaleFactor = parseInt(RPG.scene.world._project.scaleFactor)  if useScaleFactor isnt undefined and useScaleFactor isnt 1
    parseInt(RPG.scene.world._tilesets[RPG.scene.world.getCurrentMap().general.tilesets[0]].data.tile_size) * scaleFactor
  capitalize: (string) ->
    string.charAt(0).toUpperCase() + string.slice(1)
  checkCollision: (sprite, nextPosition) ->
    self = this
    if self._project is undefined
      self._project = RPG.manager.registry.acquire("project").value
    cellSpacing = RPG.utilities.misc.cellSpacing(true)
    gridTile = [
      8 * self._project.scaleFactor
      12 * self._project.scaleFactor
    ]

    # need to get a way to grab a tile a bit more smoother
    firstTile = RPG.scene.world.getTileByID(0)
    position =
      x: ((sprite.position.x - gridTile[0]) + (cellSpacing * nextPosition.x)) - parseInt(firstTile.position.x)
      y: ((sprite.position.y - gridTile[1]) + (cellSpacing * nextPosition.y)) - parseInt(firstTile.position.y)
    nextTile = RPG.scene.world.getTile(position)

    isPassable = false

    isPassable = true  if nextTile and (nextTile.attributes.passable is `undefined` or nextTile.attributes.passable is true)

    # check if a sprite is in that spot and if that sprite is passable
    isPassable
module.exports = misc
