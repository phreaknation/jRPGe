class animate
  constructor: () ->
    @_isStarted = false
    self
  start: ->
    self = this
    self._isStarted = true
    self._isStarted
  stop: ->
    self = this
    self._isStarted = false
    self._isStarted
  run: (@stage, @renderer, @preRender, @postRender) ->
    self = this
    if @stage is undefined or @renderer is undefined
      console.log "Stage or Renderer has failed"
      return false
    if self._isStarted is true
      # Do time stuff
      # console.log(oRPG.utilities.timex.getTimePast(true));
      @preRender()  if @preRender isnt undefined
      requestAnimFrame ->
        self.run(stage, renderer, preRender, postRender)
        return
      Tween.runTweens()
      @postRender()  if @postRender isnt undefined
      @renderer.render(@stage)
    else
      requestAnimFrame ->
        self.run(stage, renderer, preRender, postRender)
        return

module.exports = animate