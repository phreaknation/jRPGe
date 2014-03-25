class animate
  constructor: (@name, stop) ->
    d = new Date()
    t = RPG.fn.t
    hh = d.getHours(t)
    mm = d.getMinutes(t)
    if Object.keys(RPG.fn.worlds).length - 2 > 0
      unless RPG.fn.scene.inTitle
        currTime = performance.now()
        RPG.fn.stats.playtime.totaltimeMS += Math.floor(currTime - RPG.fn.stats.playtime.timepast)
        RPG.fn.stats.playtime.totaltime = RPG.fn.stats.playtime.totaltimeMS / 1000
        RPG.fn.stats.playtime.timepast = performance.now()
      RPG.fn.stats.realtime = hh + ":" + mm
      if RPG.fn.isAnimating is `undefined` or RPG.fn.isAnimating is false
        RPG.fn.isAnimating = true
      else

      requestAnimFrame RPG.fn.animate

      # just for fun, lets rotate mr rabbit a little
      # bunny.rotation += 0.1;
      # pixelate.size.x = Math.round((Math.random() * 2) + 4);
      # pixelate.size.y = Math.round((Math.random() * 2) + 4);

      # bunny.filters = [pixelate];

      # console.log(stage.getBounds().width);
      # render the stage
      Tween.runTweens()
      RPG.fn.get.Renderer().render RPG.fn.get.Stage().stage
      if RPG.fn.keyboard.hasKeyPressed
        setTimeout (->
          RPG.fn.keyboard.hasKeyPressed = false
          return
        ), RPG.fn.keyboard.keyWait
      else
        RPG.fn.keyboard.hasKeyPressed = RPG.fn.keyboard.update()
    else
      requestAnimFrame RPG.fn.animate
    self
module.exports = animate