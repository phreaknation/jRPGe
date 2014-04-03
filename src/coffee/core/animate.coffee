class animate
  constructor: () ->
    @_isStarted = false
    @_preHooks = {}
    @_postHooks = {}
    self
  start: ->
    self = this
    self._isStarted = true
    self._isStarted
  stop: ->
    self = this
    self._isStarted = false
    self._isStarted
  hook: (@name, @action, @isPre = false) ->
    self = this
    return false  if @name is undefined or @action is undefined
    if @isPre is true
      self._preHooks[@name] = @action
    else if @isPre is false
      self._postHooks[@name] = @action
  run: (@stage, @renderer, @preRender, @postRender) ->
    self = this
    if @stage is undefined
      console.log "Stage has failed"
      return false
    else if @renderer is undefined
      console.log "Renderer has failed"
      return false
    if self._isStarted is true
      # Do time stuff
      # console.log(oRPG.utilities.timex.getTimePast(true));
      @preRender()  if @preRender isnt undefined
      for key, obj of self._preHooks
        if typeof obj is 'function'
          obj()
      requestAnimFrame ->
        self.run stage, renderer, preRender, postRender
        return
      Tween.runTweens()
      @postRender()  if @postRender isnt undefined
      @renderer.render(@stage)
    else
      requestAnimFrame ->
        self.run stage, renderer, preRender, postRender
        return

module.exports = animate