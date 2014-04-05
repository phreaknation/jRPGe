class keyboard
  constructor: (@name) ->
    self = this
    @_keyWait = 20
    @_lookup =
      8: "backspace"
      9: "tab"
      13: "enter"
      16: "shift"
      17: "ctrl"
      18: "alt"
      19: "pause"
      20: "caps-lock"
      27: "escape"
      32: "space"
      33: "page-up"
      34: "page-down"
      35: "end"
      36: "home"
      37: "arrow-left"
      38: "arrow-up"
      39: "arrow-right"
      40: "arrow-down"
      44: "print-screen"
      45: "insert"
      46: "delete"
      48: "0"
      49: "1"
      50: "2"
      51: "3"
      52: "4"
      53: "5"
      54: "6"
      55: "7"
      56: "8"
      57: "9"
      65: "A"
      66: "B"
      67: "C"
      68: "D"
      69: "E"
      70: "F"
      71: "G"
      72: "H"
      73: "I"
      74: "J"
      75: "K"
      76: "L"
      77: "M"
      78: "N"
      79: "O"
      80: "P"
      81: "Q"
      82: "R"
      83: "S"
      84: "T"
      85: "U"
      86: "V"
      87: "W"
      88: "X"
      89: "Y"
      90: "Z"
      112: "f1"
      113: "f2"
      114: "f3"
      115: "f4"
      116: "f5"
      117: "f6"
      118: "f7"
      119: "f8"
      120: "f9"
      121: "f10"
      122: "f11"
      123: "f12"
      144: "number-lock"
      145: "scroll-lock"
      188: "lt"
      190: "gt"
      191: "question-mark"
      192: "tilde"
      219: "left-bracket"
      220: "pipe"
      221: "right-bracket"
      222: "quote"
    @_actions = {}
    @_binds = {}
    self
  setupListeners: () ->
    self = this
    document.addEventListener "keydown", ((event) ->
      self.setKey event.which, true
      return
    ), false
    document.addEventListener "keyup", ((event) ->
      self.setKey event.which, false
      return
    ), false
  bindAction: (@action, @binding) ->
    self = this
    if @action isnt undefined
      self._actions[@action] = @binding
  bindKey: (@keyID, @action) ->
    self = this
    if @keyID isnt undefined
      self._binds[action] =
        name: @keyID
        action: @action
        pressed: false
        timePressed: 0
        clearPressed: ->
          setTimeout (->
            self.setKey @keyID, false
            return
          ), self._keyWait
  bindsLookup: (@keyID) ->
    self = this
    binds = []
    for name, key of self._binds
      binds.push(key)  if self._lookup[@keyID] is key.name
    return binds
  getKey: (@keyID) ->
    self = this
    key = self._lookup[@keyID]
    return key  if key isnt undefined
    false
  getKeyID: (@key) ->
    self = this
    for id of self._lookup
      if self._lookup[id] is @key
        keyID = id
        break
    return keyID  if keyID isnt null
    false
  setKey: (@keyID, @mode) ->
    self = this
    return false  if @keyID is undefined or @keyID is undefined
    keys = self.bindsLookup(@keyID)
    if keys.length isnt 0
      for key, index in keys
        if key.pressed isnt @mode
          if @mode is true
            key.timePressed = Math.round(performance.now())
          else
            key.clearPressed()
          key.pressed = @mode
    return
  isPressed: (@name) ->
    self = this
    return false  if @name is undefined
    if self._binds[@name] isnt undefined
      self._binds[@name].pressed = false  if self._binds[@name].pressed is undefined
      self._binds[@name].pressed
    else
      false
  # now we want to set up monitoring of the key to turn it off. Needs to be
  # expanded to have pressed state not turning it off if depresed
  monitorKeys: () ->
    self = this
    for bind, key of self._binds
      continue  if bind is undefined and bind is 'undefined'
      if key.pressed is true
        self.triggerKey key
    return
  triggerKey: (@key) -> # trigger currently is being fired in a loop.
    self = this
    if key.action isnt undefined
      self._actions[key.action]()
    key.clearPressed()
module.exports = keyboard

# if RPG.fn.keyboard.is(RPG.fn.actions.left)
#   if RPG.fn.keyboard.is(RPG.fn.actions.sprint)
#     if RPG.fn.checkCollision(player,
#       x: -1
#       y: 0
#     )
#       RPG.fn.player.walk "west", true
#     else
#       RPG.fn.player.face "west"
#   else
#     if RPG.fn.checkCollision(player,
#       x: -1
#       y: 0
#     )
#       RPG.fn.player.walk "west", false
#     else
#       RPG.fn.player.face "west"
#   keyPressed = true
# return