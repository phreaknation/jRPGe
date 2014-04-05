class proc
  constructor: (@name) ->
    self = this

    @.project = RPG.load require("./proc/project")

    self
module.exports = proc

# proc.map = (name, worldName, callback) ->
#   $.ajax(
#     url: "/assets/resources/maps/" + name.toLowerCase() + "/map.json"
#     dataType: "json"
#     async: false
#   ).done (data) ->
#     tileset = null
#     RPG.fn.worlds[worldName].maps[data.general.name] = data
#     RPG.fn.worlds[worldName].maps._current = data.general.name
#     for tileset of data.general.tilesets
#       RPG.fn.load.tileset data.general.tilesets[tileset], data.general.name, data.general.name
#     callback()  if callback isnt undefined and typeof callback is "function"
#     return

#   return

# proc.tileset = (name, worldName, mapName) ->
#   $.ajax(
#     url: "/assets/resources/tilesets/" + name.toLowerCase() + "/tileset.json"
#     dataType: "json"
#     async: false
#   ).done (data) ->
#     RPG.fn.worlds[worldName].tilesets[name] = data
#     RPG.fn.draw.grid parseInt(data.tile_size) * RPG.fn.config.scaleFactor, RPG.fn.worlds[worldName].maps[mapName].general.map_size  if RPG.fn.isDevMode
#     return

#   return

# proc.tile = (tileset, tileTexture, tileProperties, group) ->
#   tile = tileset.tiles[tileProperties.name] = {}

#   # types: 0: static, 1: Auto-Tile 3x4, 2: animation 4x2
#   if parseInt(tileProperties.attributes.type) is 1
#     tile[group[0]] = new PIXI.Texture(tileTexture,
#       x: RPG.fn.convert.GridToPixel(tileProperties.position.x)
#       y: RPG.fn.convert.GridToPixel(tileProperties.position.y)
#       width: parseInt(tileset.tile_size)
#       height: parseInt(tileset.tile_size)
#     )
#     tile[group[1]] = new PIXI.Texture(tileTexture,
#       x: RPG.fn.convert.GridToPixel(tileProperties.position.x)
#       y: RPG.fn.convert.GridToPixel(parseInt(tileProperties.position.y) + 1)
#       width: parseInt(tileset.tile_size)
#       height: parseInt(tileset.tile_size)
#     )
#     tile[group[2]] = new PIXI.Texture(tileTexture,
#       x: RPG.fn.convert.GridToPixel(parseInt(tileProperties.position.x))
#       y: RPG.fn.convert.GridToPixel(parseInt(tileProperties.position.y) + 2)
#       width: parseInt(tileset.tile_size)
#       height: parseInt(tileset.tile_size)
#     )
#     tile[group[3]] = new PIXI.Texture(tileTexture,
#       x: RPG.fn.convert.GridToPixel(parseInt(tileProperties.position.x))
#       y: RPG.fn.convert.GridToPixel(parseInt(tileProperties.position.y) + 1)
#       width: parseInt(tileset.tile_size)
#       height: parseInt(tileset.tile_size)
#     )
#     tile[group[4]] = new PIXI.Texture(tileTexture,
#       x: RPG.fn.convert.GridToPixel(parseInt(tileProperties.position.x) + 1)
#       y: RPG.fn.convert.GridToPixel(parseInt(tileProperties.position.y) + 1)
#       width: parseInt(tileset.tile_size)
#       height: parseInt(tileset.tile_size)
#     )
#     tile[group[5]] = new PIXI.Texture(tileTexture,
#       x: RPG.fn.convert.GridToPixel(parseInt(tileProperties.position.x) + 2)
#       y: RPG.fn.convert.GridToPixel(parseInt(tileProperties.position.y) + 1)
#       width: parseInt(tileset.tile_size)
#       height: parseInt(tileset.tile_size)
#     )
#     tile[group[6]] = new PIXI.Texture(tileTexture,
#       x: RPG.fn.convert.GridToPixel(parseInt(tileProperties.position.x))
#       y: RPG.fn.convert.GridToPixel(parseInt(tileProperties.position.y) + 2)
#       width: parseInt(tileset.tile_size)
#       height: parseInt(tileset.tile_size)
#     )
#     tile[group[7]] = new PIXI.Texture(tileTexture,
#       x: RPG.fn.convert.GridToPixel(parseInt(tileProperties.position.x) + 1)
#       y: RPG.fn.convert.GridToPixel(parseInt(tileProperties.position.y) + 2)
#       width: parseInt(tileset.tile_size)
#       height: parseInt(tileset.tile_size)
#     )
#     tile[group[8]] = new PIXI.Texture(tileTexture,
#       x: RPG.fn.convert.GridToPixel(parseInt(tileProperties.position.x) + 2)
#       y: RPG.fn.convert.GridToPixel(parseInt(tileProperties.position.y) + 2)
#       width: parseInt(tileset.tile_size)
#       height: parseInt(tileset.tile_size)
#     )
#     tile[group[9]] = new PIXI.Texture(tileTexture,
#       x: RPG.fn.convert.GridToPixel(parseInt(tileProperties.position.x))
#       y: RPG.fn.convert.GridToPixel(parseInt(tileProperties.position.y) + 3)
#       width: parseInt(tileset.tile_size)
#       height: parseInt(tileset.tile_size)
#     )
#     tile[group[10]] = new PIXI.Texture(tileTexture,
#       x: RPG.fn.convert.GridToPixel(parseInt(tileProperties.position.x) + 1)
#       y: RPG.fn.convert.GridToPixel(parseInt(tileProperties.position.y) + 3)
#       width: parseInt(tileset.tile_size)
#       height: parseInt(tileset.tile_size)
#     )
#     tile[group[11]] = new PIXI.Texture(tileTexture,
#       x: RPG.fn.convert.GridToPixel(parseInt(tileProperties.position.x) + 2)
#       y: RPG.fn.convert.GridToPixel(parseInt(tileProperties.position.y) + 3)
#       width: parseInt(tileset.tile_size)
#       height: parseInt(tileset.tile_size)
#     )
#   tile

# proc.JSON = (file, callback) ->
#   $.ajax(
#     url: "/assets/resources/" + file
#     dataType: "json"
#   ).done (data) ->
#     callback data  if callback isnt undefined and typeof callback is "function"
#     return
#   return