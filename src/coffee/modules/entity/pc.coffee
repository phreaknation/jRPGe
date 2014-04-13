class pc
  constructor: (@name) ->
    self = this
    self._animation =
      walk:
        step: 1
        count: 0
        direction: 1
    self
  getSprite: () ->
    self = this
    self._sprite
  setSprite: (characterName) ->
    self = this
    self._project = RPG.manager.registry.acquire("project").value
    self._world = self._project.worlds._current
    self._map = self._world.maps._current
    self._characterName = characterName
    self._sprite = PIXI.Sprite.fromFrame(characterName + '_idle_south.png');
    self._sprite.scale.x = self._project.scaleFactor
    self._sprite.scale.y = self._project.scaleFactor
    self._sprite.anchor.x = 0.5;
    self._sprite.anchor.y = 1;
    self._sprite.visible = false
    self._stage = RPG.manager.registry.acquire("stage").value
    RPG.scene.world._scene[3].addChild self._sprite
  setLocation: (coordPosition) ->
    self = this
    gridTile = [
      8 * self._project.scaleFactor
      12 * self._project.scaleFactor
    ]
    self._sprite.position.x = RPG.utilities.convert.gridToPixel(parseInt(coordPosition.x), true) + gridTile[0]
    self._sprite.position.y = RPG.utilities.convert.gridToPixel(parseInt(coordPosition.y), true) + gridTile[1]
  face: (direction) ->
    self = this
    if self._animation.walk.count is 1
      self.getSprite().texture = PIXI.Texture.fromFrame(self._characterName + "_idle_" + direction + ".png")
  move: (sprite, direction, isSprinting, isMoonWalking) ->
    self = this
    coord = null
    cellSpacing = RPG.utilities.misc.cellSpacing(true)
    speed = null
    if direction is "west"
      coord = "x"
      if isMoonWalking
        distance = (sprite.position.x + cellSpacing)
      else
        distance = (sprite.position.x - cellSpacing)
    else if direction is "east"
      coord = "x"
      distance = (sprite.position.x + cellSpacing)
      if isMoonWalking
        distance = (sprite.position.x - cellSpacing)
      else
        distance = (sprite.position.x + cellSpacing)
    else if direction is "north"
      coord = "y"
      if isMoonWalking
        distance = (sprite.position.y + cellSpacing)
      else
        distance = (sprite.position.y - cellSpacing)
    else
      coord = "y"
      if isMoonWalking
        distance = (sprite.position.y - cellSpacing)
      else
        distance = (sprite.position.y + cellSpacing)
    if isSprinting
      speed = self._project.moveSpeed[1]
    else
      speed = self._project.moveSpeed[0]
    self._world.group.stepCount++
    # new Tween(sprite, "position." + coord, distance, speed, true)
  walk: (direction, isSprinting) ->
    self = this
    directions = [
      "north"
      "south"
      "east"
      "west"
    ]
    keys = [
      "arrow-up"
      "arrow-down"
      "arrow-right"
      "arrow-left"
    ]
    cellSpacing = null

    if $.inArray(direction, directions) is -1
      return false

    direction = direction.toLowerCase()

    # Create a Tween to make your Sprite move to position.x = 100 within 60 frames, starting instantly
    if self._animation.walk.step is 1
      self._animation.walk.step = 0
      cellSpacing = RPG.utilities.misc.cellSpacing(true)
      if self._animation.walk.count is 0
        self.getSprite().texture = PIXI.Texture.fromFrame(self._characterName + "_walk_" + direction + "_1.png")
        self._animation.walk.count = 1
      else if self._animation.walk.count is 1 or self._animation.walk.count is 3
        if self._animation.walk.count is 1
          self._animation.walk.count = 2
        else if self._animation.walk.count is 3
          self._animation.walk.count = 0
        self.getSprite().texture = PIXI.Texture.fromFrame(self._characterName + "_idle_" + direction + ".png")
      else if self._animation.walk.count is 2
        self._animation.walk.count = 3
        self.getSprite().texture = PIXI.Texture.fromFrame(self._characterName + "_walk_" + direction + "_2.png")
      # moveSprite = self.move(self.getSprite(), direction, isSprinting)
      moveMap = RPG.scene.world.moveMap(direction, isSprinting)
      if isSprinting
        speed = self._project.moveSpeed[1]
      else
        speed = self._project.moveSpeed[0]
      moveSprite = new Tween(self.getSprite(), "", 0, speed, true)
      moveSprite.setOnComplete (->
        key = keys[directions.indexOf(direction)]
        # self.getSprite().coordinate =
        #   x: Math.round((self.getSprite().position.x) / (cellSpacing))
        #   y: Math.round((self.getSprite().position.y) / (cellSpacing))
        self.getSprite().texture = PIXI.Texture.fromFrame(self._characterName + "_idle_" + direction + ".png")
        self._animation.walk.step = 1
        return
      ), self.getSprite()
    # Optional add bouncing, easing..
    #tween.easing = Tween.circOut();
    # Optional add a callback
    #tween.setOnComplete(alert, "done");
    #bunny.position.x -= 5;
    return false
  show: () ->
    self = this
    self._sprite.visible = true
  hide: () ->
    self = this
    self._sprite.visible = false
module.exports = pc