class initialize
  constructor: (@parent) ->
    self = this
    self
  view: (@renderer) ->
    self = this
    $('body')
      .append(@renderer.view) # Finally lets bring the renderer view into the page so that we can actually see whats going on
      .append($('<section id="game_overlay" />'))
module.exports = initialize
###
"isDevMode": queryString()['dev'] || false,
"isMobile": queryString()['mobile'] || false,
"isPathingEnabled": queryString()['pathingenabled'] || true,
"isMouseEnabled": queryString()['mouseenabled'] || true,
"isAnimating": false,
###