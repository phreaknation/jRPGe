class events extends RPG::manager
  constructor: (@name) ->
    self = this
    self
module.exports = events


#  get: (key) ->
#    return RPG.initialize.queue[key]  if RPG.initialize.queue[key] isnt `undefined`
#    false
#  upsert: (key, value, remove) ->
#    if remove isnt `undefined` and remove is true
#      delete (RPG.initialize.queue[key])  if RPG.initialize.queue[key] isnt `undefined`
#    else
#      RPG.initialize.queue[key] = value
#      RPG.initialize.load()  if RPG.initialize.checkLoading()
#    return