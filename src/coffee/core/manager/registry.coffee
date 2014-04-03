class registry
  constructor: (@name) ->
    self = this
    self._storage ?= {}
    if self._storage is undefined or self._storage?
      self.name ?= "Registry Manager" if not @name and @name?
      self.desc ?= "#{@name} is to help with managing various registers, global, and locals for jRPG"
    self
  acquire: (@key) ->
    self = this
    return self._storage[@key]  if @key isnt undefined and self._storage[@key] isnt undefined
    false
  acquireAll: () ->
    self = this
    return self._storage if self._storage isnt undefined
    false
  clearAll: (@isClear, @sClear) ->
    self = this
    if @isClear is true and @sClear is 'CLEAR'
      delete self._storage
      return true
    false
  expose: (@isVerbose) ->
    self = this
    for key of self._storage
      store[key] = self._storage[key]
      console.log store[key]  if isVerbose
    store
  register: (@key, @value, @type = null, @overwrite = true) ->
    self = this
    if @key isnt undefined and @value isnt undefined
      if @overwrite is true or (@overwrite is false and self._storage[@key] is undefined)
        self._storage[@key] =
          value: @value
          type: @type
        return self._storage[@key]
  unregister: (@key) ->
    self = this
    if self._storage[@key] isnt undefined
      delete self._storage[@key]
      return true
    false
module.exports = registry