class render
  constructor: (@name) ->
    self = this
    self
  render.map = (world, map, tileset) ->
    tileTexture = new PIXI.Texture.fromImage("/assets/resources/tilesets/" + map.general.tilesets[0].toLowerCase() + "/tileset.png")
    t = setInterval(->
      if tileTexture.width isnt `undefined` and tileTexture.height isnt `undefined`
        for y of map.data.floor
          row = map.data.floor[y].split(",")
          for x of row
            tile = row[x]
            RPG.fn.draw.tile tileset, tileTexture, 1, tile, x, y
        clearInterval t
      return
    , 10)
    return

  render.grid = (cellSpacing, map_size) ->
    i = undefined
    graphics = undefined
    width = (RPG.fn.convert.GridToPixel(map_size.x, true))
    height = (RPG.fn.convert.GridToPixel(map_size.y, true))
    i = 0
    while i < height + 1
      graphics = new PIXI.Graphics()
      graphics.lineStyle 1.0 + ((i % 10) is 0)
      graphics.beginFill 0x00FF00
      graphics.moveTo 0, i
      graphics.lineTo width, i
      graphics.endFill()
      RPG.fn.add.toLayers "floor", graphics
      i += cellSpacing
    i = 0
    while i < width + 1
      graphics = new PIXI.Graphics()
      graphics.lineStyle 1.0 + ((i % 10) is 0)
      graphics.beginFill 0x00FF00
      graphics.moveTo i, 0
      graphics.lineTo i, height
      graphics.endFill()
      RPG.fn.add.toLayers "floor", graphics
      i += cellSpacing
    return

  render.tile = (tileset, tileTexture, layerID, tile, x, y) ->
    a = tile.split(":")[0]
    b = tile.split(":")[1]
    tileProperties = tileset.regions[a]
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
    tileset.tiles = {}  if tileset.tiles is `undefined`
    tile = RPG.fn.load.tile(tileset, tileTexture, tileProperties, group_B)  if tileset.tiles[tileProperties.name] is `undefined`
    tileSprite = new PIXI.Sprite(tileset.tiles[tileProperties.name][group_B[b]])
    tileSprite.scale.x = RPG.fn.config.scaleFactor
    tileSprite.scale.y = RPG.fn.config.scaleFactor
    RPG.fn.layers[layerID].addChild tileSprite
    tileSprite.position.x = RPG.fn.convert.GridToPixel(x) * RPG.fn.config.scaleFactor
    tileSprite.position.y = RPG.fn.convert.GridToPixel(y) * RPG.fn.config.scaleFactor
    return

  render.screen = (screen, isVisible, callback) ->
    if typeof isVisible is "function"
      callback = isVisible
      isVisible = null
    guid = screen.data("guid")
    if $(".screen[data-guid=\"" + guid + "\"]").length is 0
      $("body").append screen
    else
      if isVisible
        $(".screen[data-guid=\"" + guid + "\"]").removeClass "hidden"
      else
        $(".screen[data-guid=\"" + guid + "\"]").addClass "hidden"
    callback()  if typeof callback is "function"
    return

  render.menu = (isVisible, callback) ->
    padding = 25 # goes into theme
    parent = window.RPG.fn
    exists = false
    menu = null
    i = undefined
    if typeof isVisible is "function"
      callback = isVisible
      isVisible = null
    if Object.keys(parent.objects[3]).length > 0
      for i of parent.objects[3]
        child = parent.objects[3][i]
        if child.hasClass("menu", "main")
          exists = true
          menu = child
      i = null
    if exists
      if isVisible isnt `undefined` and isVisible is false
        RPG.fn.ui.toggle.menu menu, false
      else
        RPG.fn.ui.toggle.menu menu, true
      menu
    else
      menu = $("<div class=\"menu main hidden\" />")
      menu_panel = $("<div class=\"panel submenu main\" />")
      location_panel = $("<div class=\"panel location\" />")
      info_panel = $("<div class=\"panel info\" />")
      character_panel = $("<div class=\"panel character\" />")

      ul = $("<ul />").append("<li class=\"item Items clickable\">Items</li>").append("<li class=\"item Abilities clickable\">Abilities</li>").append("<li class=\"item Equip clickable\">Equip</li>").append("<li class=\"item Status clickable\">Status</li>").append("<li class=\"item Config clickable\">Config</li>").append("<li class=\"item Save clickable\">Save</li>")
      menu_panel.append ul
      ul = $("<ul />").append("<li class=\"item world repose\">World of Repose</li>").append("<li class=\"item world discord hidden\">World of Discord</li>").append("<li class=\"item world harmony hidden\">World of Harmony</li>")
      location_panel.append ul
      ul = $("<ul />").append("<li class=\"item Time\">Time<span class=\"pull-right\">0</span></li>").append("<li class=\"item Steps\">Steps<span class=\"pull-right\">0</span></li>").append("<li class=\"item Currency\">GP<span class=\"pull-right\">0</span></li>")
      info_panel.append ul
      world = RPG.fn.get.currentWorld()
      for i of world.group.party
        character = world.group.party[i]
        character_panel.append().append $("<ul />").append(RPG.fn.ui.character(character))
      i = null
      menu.append(menu_panel, location_panel, info_panel, character_panel).appendTo "body"
      RPG.fn.ui.toggle.menu menu, true
      parent.objects[3].main = menu
      menu

  render.message = (text, location) ->
    height = 200
    padding = 25
    parent = window.RPG.fn
    box = new PIXI.Graphics()
    box.beginFill parent.theme.backgroundColor
    box.lineStyle 5, parent.theme.borderColor
    if location isnt `undefined` and location.length is 4
      box.position.x = location[0]
      box.position.y = location[1]
      box.drawRect 0, 0, location[2], location[3]
    else
      box.drawRect padding, parent.get.Renderer().height - (height + padding), parent.get.Renderer().width - (padding * 2), height
    box.endFill()
    return
module.exports = render