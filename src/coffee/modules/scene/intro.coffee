class intro
  constructor: (@name) ->
    self = this
    self._stage = null
    self._scene = new PIXI.DisplayObjectContainer()
    self._screens = {}
    self._screensCurrent = -1
    self._screensOrder = []
    self._whenFinished = null
    self._wait = 500
    self._waiting = false
    self
  add: (@name, @resource) ->
    self = this
    # @resource
    scr =
      texture: PIXI.Texture.fromImage(@resource.value)
      shown: false
    scr.sprite = new PIXI.Sprite(scr.texture)
    scr.sprite.buttonMode = true
    scr.sprite.interactive = true
    scr.sprite.visible = false
    # scr.sprite.mouseupoutside = scr.sprite.touchendoutside
    scr.sprite.mouseup = scr.sprite.touchend = (data) ->
      # Need to transition then hide completely
      self.showNext()
      return
    self._screensOrder.push(@name)
    self._screens[@name] = scr
    self._scene.addChild(scr.sprite)
    return
  start: () ->
    self = this
    RPG.scene.setScenes("intro")
    self._stage = RPG.manager.registry.acquire("stage").value
    self._stage.addChild self._scene
    self.showNext()
    self._waiting = true
    return
  getScreenByID: (@index) ->
    self = this
    sceneName = self._screensOrder[@index]
    self._screens[sceneName]
  showNext: () ->
    self = this
    if RPG.scene.getScene("intro")
      if self._waiting is true
        return false
      currentScreen = self.getScreenByID(self._screensCurrent)
      nextScreen = self.getScreenByID(self._screensCurrent+1)
      if nextScreen isnt undefined and nextScreen.sprite isnt undefined
        if nextScreen.sprite.visible is false
          nextScreen.sprite.visible = true
      if currentScreen isnt undefined and currentScreen.sprite isnt undefined
        if currentScreen.sprite.visible is true
          currentScreen.visible = false
      self._waiting = true
      setTimeout (->
        self._waiting = false
        self._screensCurrent += 1
      ), self._wait
      self._whenFinished()  if self._screensCurrent >= self._screensOrder.length
      return true
    return false
  whenFinished: (callback) ->
    self = this
    if typeof callback is 'function'
      self._whenFinished = ->
        self._scene.visible = false
        callback()
    return

module.exports = intro