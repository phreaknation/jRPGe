class phrase
  constructor: (@name) ->
    self = this
    self._storage ?= {}
    if self._storage is undefined or self._storage?
      self.name ?= "Phrase Manager" if not @name and @name?
      self.desc ?= "#{@name} is to help with managing various types of resource for jRPG"
    self
  translate: (@sentence) -># TODO: need some cleanup
    self = this
    pos =
      current: -1
      start: -1
      end: -1
    retStr = @sentence

    for index, char of @sentence
      pos.current = parseInt(index)
      if char is "{"
        pos.start = parseInt(index)
      if pos.start isnt -1 and char is "}"
        pos.end = parseInt(index)
      if pos.start isnt -1 and pos.end isnt -1
        phrase = @sentence.slice(pos.start + 1, pos.end)
        pos.start = -1
        pos.end = -1
        repStr = self.acquire(phrase)
        if repStr isnt undefined
          retStr = retStr.replace("{" + phrase + "}", repStr)
      continue
    return retStr
  acquire: (@key) ->
    self = this
    if @key isnt undefined and self._storage[@key] isnt undefined
      return self._storage[@key]
    false
  clearAll: (@isClear, @sClear) ->
    self = this
    if @isClear is true and @sClear is 'CLEAR'
      delete self._storage
      self._storage = {}
      return true
    false
  register: (@key, @value, @overwrite = true) ->
    self = this
    if @key isnt undefined and @value isnt undefined
      if @overwrite is true or (@overwrite is false and self._storage[@key] is undefined)
        self._storage[@key] = @value
        return self._storage[@key]
    false
  unregister: (@key) ->
    self = this
    if self._storage[@key] isnt undefined
      ret = self._storage[@key]
      delete self._storage[@key]
      return ret
    false
module.exports = phrase