class resources
  constructor: (@name) ->
    self = this
    self._storage ?= {}
    if self._storage is undefined or self._storage?
      self.name ?= "Resource Manager" if not @name and @name?
      self.desc ?= "#{@name} is to help with managing various types of resource for jRPG"
    self
  acquire: (@key, @withType) ->
    self = this
    if @key isnt undefined and self._storage[@key] isnt undefined
      if @withType isnt undefined and @withType is true
        return [
          self._storage[@key].value
          self._storage[@key].type
        ]
      else
        return self._storage[@key].value
    false
  clearAll: (@isClear, @sClear) ->
    self = this
    if @isClear is true and @sClear is 'CLEAR'
      delete self._storage
      self._storage = {}
      return true
    false
  register: (@key, @value, @type = null, @overwrite = true) ->
    self = this
    if @key isnt undefined and @value isnt undefined
      if @overwrite is true or (@overwrite is false and self._storage[@key] is undefined)
        self._storage[@key] =
          value: @value
          type: @type
        return self._storage[@key]
    false
  unregister: (@key) ->
    self = this
    if self._storage[@key] isnt undefined
      ret = [
        self._storage[@key].value
        self._storage[@key].type
      ]
      delete self._storage[@key]
      return ret
    false
module.exports = resources