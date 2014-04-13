class scene
  constructor: (@name) ->
    self = this
    self._prevScene = false

    # @.battle = RPG.load require("./scene/battle")
    @.intro = RPG.load require("./scene/intro")
    # @.title = RPG.load require("./scene/title")
    # @.world = RPG.load require("./scene/world")

    self
  getScene: (scene) ->
    self = this
    self._project = RPG.manager.registry.acquire("project").value  if self._project is undefined
    for key, s of self._project.scenes
      if key.toLowerCase() is scene.toLowerCase() and s is true
        return true
    return false
  getPreviousScene: () ->
    self = this
    self._prevScene
  setScenes: (scenes) ->
    self = this
    self._project = RPG.manager.registry.acquire("project").value  if self._project is undefined
    if typeof scene is "object"
      for key of scenes
        val = scenes[key]
        @setScene val
    else if typeof scenes is "string"
      for key, s of self._project.scenes
        if key.toLowerCase() is scenes.toLowerCase()
          self._project.scenes[key] = true
        else
          if s is true and key isnt self._prevScene
            self._prevScene = key
          self._project.scenes[key] = false
    return self._project.scenes
module.exports = scene