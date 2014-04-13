class render
  constructor: (@name) ->
    self = this
    self
  tile: (tileset, tileTexture, tileProperties, group) ->
    # Need to find a better place for this and also a better way of doing it.
    tile = tileset.tiles[tileProperties.name] = {}

    # types: 0: static, 1: Auto-Tile 3x4, 2: animation 4x2
    if parseInt(tileProperties.attributes.type) is 1
      tile[group[0]] = new PIXI.Texture(tileTexture,
        x: RPG.utilities.convert.gridToPixel(tileProperties.position.x)
        y: RPG.utilities.convert.gridToPixel(tileProperties.position.y)
        width: parseInt(tileset.tile_size)
        height: parseInt(tileset.tile_size)
      )
      tile[group[1]] = new PIXI.Texture(tileTexture,
        x: RPG.utilities.convert.gridToPixel(tileProperties.position.x)
        y: RPG.utilities.convert.gridToPixel(parseInt(tileProperties.position.y) + 1)
        width: parseInt(tileset.tile_size)
        height: parseInt(tileset.tile_size)
      )
      tile[group[2]] = new PIXI.Texture(tileTexture,
        x: RPG.utilities.convert.gridToPixel(parseInt(tileProperties.position.x))
        y: RPG.utilities.convert.gridToPixel(parseInt(tileProperties.position.y) + 2)
        width: parseInt(tileset.tile_size)
        height: parseInt(tileset.tile_size)
      )
      tile[group[3]] = new PIXI.Texture(tileTexture,
        x: RPG.utilities.convert.gridToPixel(parseInt(tileProperties.position.x))
        y: RPG.utilities.convert.gridToPixel(parseInt(tileProperties.position.y) + 1)
        width: parseInt(tileset.tile_size)
        height: parseInt(tileset.tile_size)
      )
      tile[group[4]] = new PIXI.Texture(tileTexture,
        x: RPG.utilities.convert.gridToPixel(parseInt(tileProperties.position.x) + 1)
        y: RPG.utilities.convert.gridToPixel(parseInt(tileProperties.position.y) + 1)
        width: parseInt(tileset.tile_size)
        height: parseInt(tileset.tile_size)
      )
      tile[group[5]] = new PIXI.Texture(tileTexture,
        x: RPG.utilities.convert.gridToPixel(parseInt(tileProperties.position.x) + 2)
        y: RPG.utilities.convert.gridToPixel(parseInt(tileProperties.position.y) + 1)
        width: parseInt(tileset.tile_size)
        height: parseInt(tileset.tile_size)
      )
      tile[group[6]] = new PIXI.Texture(tileTexture,
        x: RPG.utilities.convert.gridToPixel(parseInt(tileProperties.position.x))
        y: RPG.utilities.convert.gridToPixel(parseInt(tileProperties.position.y) + 2)
        width: parseInt(tileset.tile_size)
        height: parseInt(tileset.tile_size)
      )
      tile[group[7]] = new PIXI.Texture(tileTexture,
        x: RPG.utilities.convert.gridToPixel(parseInt(tileProperties.position.x) + 1)
        y: RPG.utilities.convert.gridToPixel(parseInt(tileProperties.position.y) + 2)
        width: parseInt(tileset.tile_size)
        height: parseInt(tileset.tile_size)
      )
      tile[group[8]] = new PIXI.Texture(tileTexture,
        x: RPG.utilities.convert.gridToPixel(parseInt(tileProperties.position.x) + 2)
        y: RPG.utilities.convert.gridToPixel(parseInt(tileProperties.position.y) + 2)
        width: parseInt(tileset.tile_size)
        height: parseInt(tileset.tile_size)
      )
      tile[group[9]] = new PIXI.Texture(tileTexture,
        x: RPG.utilities.convert.gridToPixel(parseInt(tileProperties.position.x))
        y: RPG.utilities.convert.gridToPixel(parseInt(tileProperties.position.y) + 3)
        width: parseInt(tileset.tile_size)
        height: parseInt(tileset.tile_size)
      )
      tile[group[10]] = new PIXI.Texture(tileTexture,
        x: RPG.utilities.convert.gridToPixel(parseInt(tileProperties.position.x) + 1)
        y: RPG.utilities.convert.gridToPixel(parseInt(tileProperties.position.y) + 3)
        width: parseInt(tileset.tile_size)
        height: parseInt(tileset.tile_size)
      )
      tile[group[11]] = new PIXI.Texture(tileTexture,
        x: RPG.utilities.convert.gridToPixel(parseInt(tileProperties.position.x) + 2)
        y: RPG.utilities.convert.gridToPixel(parseInt(tileProperties.position.y) + 3)
        width: parseInt(tileset.tile_size)
        height: parseInt(tileset.tile_size)
      )
    return tile
module.exports = render