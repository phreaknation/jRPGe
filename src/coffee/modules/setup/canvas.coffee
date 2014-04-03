class canvas
  constructor: () ->
    self = this
    self
  stage: (@color = 0x80A0F0) ->
    @stage = new PIXI.Stage(@color, @isDevMode) # set  to global
    @stage
  renderer: (@width = 1024, @height = 768) ->
    @renderer = PIXI.autoDetectRenderer(@width, @height) # set renderer to global
    @renderer

module.exports = canvas