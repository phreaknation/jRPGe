class world
  constructor: (@name) ->
    self = this
    self._scene = [
      new PIXI.DisplayObjectContainer() # background
      new PIXI.DisplayObjectContainer() # floor
      new PIXI.DisplayObjectContainer() # grid
      new PIXI.DisplayObjectContainer() # sprites
      new PIXI.DisplayObjectContainer() # ceiling
    ]
    self._tilesets = {}
    self
  setWorld: () ->
    self = this

    self._stage = RPG.manager.registry.acquire("stage").value
    self._project = RPG.manager.registry.acquire("project").value
    self._world = self._project.worlds._current = self._project.worlds[self._project.worlds._initial]
    for index in self._scene
      index.visible = false
      self._stage.addChild index

    if self._world.maps._current is undefined or self._world.maps._current is null
      self.setMap(self._world.maps[self._world.maps._initial])
    for name, index in self._world.maps._list
      map = self._world.maps[name]
      self.setTilesets(map.general.tilesets)
    self._t = setInterval (->
      if self._tilesets[map.general.tilesets[0]].texture.width isnt undefined
        self.renderMap(self.getCurrentMap())
        clearInterval self._t
    ), 10
    return
  getCurrentMap: () ->
    self = this
    self._world.maps._current
  setMap: (map) ->
    self = this
    self._world.maps._current = map
    return
  toggleMap: () ->
    self = this
    for index in self._scene
      index.visible = !index.visible
      self._stage.addChild index
  renderMap: (map) ->
    self = this
    tileset = self._tilesets[map.general.tilesets[0]]
    self._project
    background = PIXI.Texture.fromImage("assets/projects/" + oRPG.scene.world._project.shortName + "/backgrounds/" + map.data.backgrounds)
    bgSprite = new PIXI.Sprite(background)
    self._scene[0].addChild bgSprite
    for y of map.data.floor
      row = map.data.floor[y].split(",")
      for x of row
        tile = row[x]
        self.renderTile(tileset.data, tileset.texture, 1, tile, x, y)
    return
  setTilesets: (mapTilesets) ->
    self = this
    for name, index in mapTilesets
      self._tilesets[name] =
        texture: new PIXI.Texture.fromImage("/assets/projects/" + self._project.projectName  + "/tilesets/" + name + "/tileset.png")
        data: self._project.tilesets[name]
    return
  getTile: (@position) ->
    self = this
    layers = [
      "background"
      "floor"
      "sprites"
      "ceiling"
    ]
    layerID = 1
    p2g = RPG.utilities.convert.pixelToGrid
    map = self.getCurrentMap()
    tileset = self._tilesets[map.general.tilesets[0]]
    if map.data[layers[layerID]][p2g(@position.y, true)] isnt undefined
      row = map.data[layers[layerID]][p2g(@position.y, true)]
      rowSplit = row.split(",")
      if rowSplit[p2g(@position.x, true)] isnt undefined
        tileType = rowSplit[p2g(@position.x, true)][0]
        if tileType isnt undefined
          tile = tileset.data.regions[tileType]
    tile || false
  getTileByID: (@index) ->
    self = this
    self._scene[1].children[0]
  renderTile: (data, texture, layerID, tile, x, y) ->
    self = this
    a = tile.split(":")[0]
    b = tile.split(":")[1]
    tileProperties = data.regions[a]
    tileSprite = null
    group_B = [
      "default"
      "blank"
      "cross"
      "top_left"
      "top_center"
      "top_right"
      "middle_left"
      "middle_center"
      "middle_right"
      "bottom_left"
      "bottom_center"
      "bottom_right"
    ]
    data.tiles = {}  if data.tiles is undefined
    tile = RPG._instance.render.tile(data, texture, tileProperties, group_B)  if data.tiles[tileProperties.name] is undefined
    tileSprite = new PIXI.Sprite(data.tiles[tileProperties.name][group_B[b]])
    tileSprite.scale.y = tileSprite.scale.x = self._project.scaleFactor
    self._scene[1].addChild tileSprite
    tileSprite.position.x = RPG.utilities.convert.gridToPixel(x) * self._project.scaleFactor
    tileSprite.position.y = RPG.utilities.convert.gridToPixel(y) * self._project.scaleFactor
    return
  moveMap: (@direction, @isSprinting) ->
    self = this
    if isSprinting
      speed = self._project.moveSpeed[1]
    else
      speed = self._project.moveSpeed[0]
    for index, tile of RPG.scene.world._scene[1].children
      # console.log index, tile
      if @direction is "north"
        position =
          x: 0
          y: 1
      else if @direction is "south"
        position =
          x: 0
          y: -1
      else if @direction is "east"
        position =
          x: -1
          y: 0
      else if @direction is "west"
        position =
          x: 1
          y: 0
      tileset = self._tilesets[self.getCurrentMap().general.tilesets[0]]
      self.moveTile(tile, position, speed)
    return true
  moveTile: (@tile, @position, @speed) ->
    self = this
    x = parseInt(@tile.position.x) + (parseInt(@position.x) * parseInt(RPG.utilities.misc.cellSpacing(true)))
    y = parseInt(@tile.position.y) + (parseInt(@position.y) * parseInt(RPG.utilities.misc.cellSpacing(true)))
    if parseInt(@position.x) isnt 0
      return new Tween(@tile, "position.x", x, speed, true)
    else if parseInt(@position.y) isnt 0
      return new Tween(@tile, "position.y", y, speed, true)
    return false
module.exports = world