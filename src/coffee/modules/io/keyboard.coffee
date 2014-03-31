class keyboard
  constructor: (@name) ->
    self = this
    @hasKeyPressed = false
    @keyWait = 20
    @lookup = {}
    @pressed = {}

    self
  setupListeners: () ->
    document.addEventListener "keydown", ((event) ->
      console.log @
      @getKey event.which, true
      return
    ), false
    document.addEventListener "keyup", ((event) ->
      RPG.fn.keyboard.set.key event.which, false
      return
    ), false
  getKeyID: (@key) ->
    self = this
    for id of self.lookup
      if self.lookup[id] is key
        keyID = id
        break
    return keyID  if keyID isnt null
    false
  getKey = (@keyID) ->
    self = this
    key = RPG.fn.keyboard.keys.lookup[keyID]
    return key  if key isnt `undefined`
    false
    setKey = (@key, @mode) ->
    self = this
    RPG.fn.keyboard.keys.pressed[key] = false  if RPG.fn.keyboard.keys.pressed[key] is `undefined`
    RPG.fn.keyboard.keys.pressed[key] = mode
    return

module.exports = keyboard
# if RPG.fn.keyboard.hasKeyPressed
#     setTimeout (->
#         RPG.fn.keyboard.hasKeyPressed = false
#         return
#     ), RPG.fn.keyboard.keyWait
# else
#     RPG.fn.keyboard.hasKeyPressed = RPG.fn.keyboard.update()