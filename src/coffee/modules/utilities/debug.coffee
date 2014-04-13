class debug
  constructor: (@level = "info") ->
    self = this
    ###
    levels
      log
      info
      debug
      warn
      error
    ###
    self.level = @level
    self
  log: (@message, @type, @stacktrace) ->
    self = this
    if RPG._verbose is undefined or RPG._verbose is false
      return
    if window.console isnt undefined and window.console.log isnt undefined
      if typeof @type isnt 'string'
        if @type isnt undefined
          @stacktrace = @type
          @type = self.level
      switch @type
        when "info"
          console.info message
        when "debug"
          console.debug message
        when "warn"
          console.warn message
        when "error"
          if @stacktrace isnt undefined and @stacktrace is true
            trace = printStackTrace()
            console.error message, trace.join('\n\n')
            console.error '-----------------------------'
          else
            console.error message
        else
          console.log message

module.exports = debug