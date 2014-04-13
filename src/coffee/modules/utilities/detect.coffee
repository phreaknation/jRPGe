class detect
  constructor: (@name) ->
    self = this
    self
  userAgentContains: (@string) ->
    navigator.userAgent.indexOf(@string) != -1
  canPlayMP3: () ->

  canPlayOOG: () ->

  supportsWebSocket: () ->
    (window.WebSocket isnt undefined) || (window.MozWebSocket isnt undefined)
  supportsPerformance: () ->
    window.performance isnt undefined
module.exports = detect