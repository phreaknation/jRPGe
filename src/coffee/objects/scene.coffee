class scene
  constructor: (@name) ->
    self = this
    self
  battle: ->
    rq = require("./scene_battle")
    new rq()
  intro: ->
    rq = require("./scene_intro")
    new rq()
  title: ->
    rq = require("./scene_title")
    new rq()
  world: ->
    rq = require("./scene_world")
    new rq()
module.exports = scene