class timex
  constructor: () ->
    self = this
    @_timeStarted = performance.now()
    @_timeCurrent = performance.now()
    self
  getTimeStarted: () ->
    self = this
    return self._timeStarted
  getCurrentTime: (@isFormatted) ->
    self = this
    currTime = performance.now()
    @_date = new Date()
    @_time = performance.now()
    if @isFormatted is true
      @_hh = @_date.getHours(@_time)
      @_mm = @_date.getMinutes(@_time)
      return @_hh + ":" + @_mm
    return currTime
  updateCurrentTime: () ->
    self = this
    self._timeCurrent = performance.now()
    return self._timeCurrent
  getTimePast: (@isFormatted) ->
    self = this
    _startTime = new Date self._timeStarted
    _currentTime = new Date self.updateCurrentTime()
    if @isFormatted is true
      # there is a hickup where the values get weird near the change over. 59 = -1, 60 = 0 and then it continues as normal
      @_hh = _currentTime.getHours() - _startTime.getHours()
      @_mm = _currentTime.getMinutes() - _startTime.getMinutes()
      @_ss = _currentTime.getSeconds() - _startTime.getSeconds()
      return @_hh + ":" + @_mm + ":" + @_ss
    else
      return (_currentTime - _startTime) / 1000
module.exports = timex