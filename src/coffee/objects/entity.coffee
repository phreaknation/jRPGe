class entity
  constructor: (@name) ->
    self = this
    self
  npc: ->
    rq = require("./entity_npc")
    new rq()
  pc: ->
    rq = require("./entity_pc")
    new rq()
module.exports = entity