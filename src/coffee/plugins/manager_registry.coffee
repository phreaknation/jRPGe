class registry extends RPG::manager
  constructor: () ->
    self = this
    self.name = "Registry Manager"
    self.desc = "#{@name} is to help with managing various registers, global, and locals for jRPG"
    @storage ?= {}
    self

  acquire: (key) ->
    return @storage[key]  if key isnt `undefined` and @storage[key] isnt `undefined`
    false

  expose: (isVerbose) ->
    store = {}
    for key of @storage
      store[key] = @storage[key]
      console.log store[key]  if isVerbose
    store

  register: (key, value) ->
    if key isnt `undefined` and value isnt `undefined`
      @storage[key] = value
      return @storage[key]
    false

  unregister: (key) ->
    if @storage[key] isnt `undefined`
      delete @storage[key]

      return true
    false
module.exports = new registry