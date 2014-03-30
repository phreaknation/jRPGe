class canvas
  constructor: (@width = 1024, @height =768, @color = 0x80A0F0, @isDevMode = false, @start = false) ->
    self = this
    # set globals
    stage = new PIXI.Stage(@color, @isDevMode) # set  to global
    if stage and stage isnt 'undefined'
      renderer = new PIXI.autoDetectRenderer(@width, @height) # set renderer to global
      if renderer
        RPG.animate()  if start isnt `undefined` and start is true
    self

module.exports = canvas