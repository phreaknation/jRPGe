class registry
  constructor: (@name) ->
    self = this
    if RPG._storage is undefined or RPG._storage?
      self.name ?= "Registry Manager" if not @name and @name?
      self.desc ?= "#{@name} is to help with managing various registers, global, and locals for jRPG"
      RPG._storage ?= {}
    self.acquire = (@key) ->
      return RPG._storage[@key]  if @key isnt 'undefined' and RPG._storage[@key] isnt 'undefined'
      false
    self.clearStorage = (@isClear, @sClear) ->
      if @isClear is true and @sClear is 'CLEAR'
        delete RPG._storage
        return true
      false

    self.expose = (@isVerbose) ->
      for key of RPG._storage
        store[key] = RPG._storage[key]
        console.log store[key]  if isVerbose
      store
    self.register = (@key, @value) ->
      if @key isnt 'undefined' and @value isnt 'undefined'
        RPG._storage[@key] = @value
        return RPG._storage[@key]
      false
    self.unregister = (@key) ->
      if RPG._storage[@key] isnt 'undefined'
        delete RPG._storage[@key]
        return true
      false
    self
module.exports = registry