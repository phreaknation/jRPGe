class messages
  constructor: (@name) ->
    self = this
    self._wait = 500
    self
  _buildDialog: (@name, @type) ->
    self = this
    dialog = $('<div id="dialog_' + @name + '" class="ui dialog hidden" />')
    dialog.attr('data-wait', "true")
    if @type isnt undefined and typeof @type is 'string'
      dialog.addClass(@type)
    footer = $('<footer></footer>')
    nextSlide = $("<div class=\"button close\" />").appendTo(footer).click(->
      $this = $(this)
      dialogName = $this.parents('.ui.dialog').attr("id").replace('dialog_', '')
      self.nextMessage(dialogName)
    )
    prevSlide = $('<div class="button prev hidden">Previous</div>').appendTo(footer).click(->
      $this = $(this)
      dialogName = $this.parents('.ui.dialog').attr("id").replace('dialog_', '')
      self.prevMessage(dialogName)
    )
    dialog.prepend('<header></header>')
    dialog.append('<section class="content"></section>')
    dialog.append(footer)
    dialog
  createDialog: (@name, @messages) ->
    self = this
    if $('div#dialog_' + @name).length isnt 0
      RPG.utilities.debug.log('WARNING: A dialog with the name "' + @name + '" already exists', "warn")
      return false
    if typeof @messages is 'string'
      if @messages is '' or @messages.length is 0
        return false
      @messages = [@messages]
    if typeof @messages is 'object'
      if @messages.length is 0
        return false
      dialog = self._buildDialog(@name)
      content = dialog.find('section.content')
      for index, message of @messages
        escaped = $('<div>').text(message).text()
        msgArea = $('<div class="message hidden" />').html(escaped.replace(/\n/g, '<br />'))
        content.append(msgArea)
      content.children('.message').first().removeClass('hidden')
      button = dialog.children('footer').children('div.button.close')
      if content.children('.message').length is 1
        button.addClass('close').removeClass('next').text('Close')
      else if content.children('.message').length > 1
        button.addClass('next').removeClass('close').text('Next')
      dialog.appendTo('#game_overlay')
      return dialog
    return false
  getActiveDialogName: () ->
    self = this
    activeDialog =  $('section#game_overlay .ui.dialog').not('.hidden')
    if parseInt(activeDialog.length) isnt 0
      return activeDialog.attr('id')
    return false
  getDialog: (@name) ->
    $('div#dialog_' + @name)
  showDialog: (@name, @callback) ->
    self = this
    self._activeDialogName = @name
    if @callback isnt undefined
      self._whenFinished = @callback
    $('section#game_overlay').addClass('open')
    dialog = $('section#game_overlay > div#dialog_' + self._activeDialogName)
    dialog.removeClass('hidden').attr('data-wait', "true")
    setTimeout (->
      $('section#game_overlay > div#dialog_' + self._activeDialogName).attr('data-wait', 'false')
    ), self._wait
    RPG.scene.setScenes("dialog")
    # hack to prevent sticky key syndrome
    oRPG.io.keyboard._binds['f10_pause'].pressed = false
    return
  hideDialog: (@name) ->
    self = this
    dialog = $('section#game_overlay > div#dialog_' + @name)
    if dialog.attr('data-wait') is 'true'
      return false
    else
      dialog.addClass('hidden')
      dialog.attr('data-wait', "true")
      if $('section#game_overlay').children('*').not('.hidden').length is 0
        $('section#game_overlay').removeClass('open')
        RPG.animate.start();
        RPG.scene.setScenes("dialog");
    return
  nextMessage: (@name) ->
    self = this
    dialog = $('div#' + self.getActiveDialogName())
    if dialog.attr('data-wait') is 'true'
      return false
    content = dialog.find('section.content')
    currentSlide = content.find('.message').not('.hidden')
    nextSlide = currentSlide.next()
    nextButton = dialog.find('footer .button.next')
    closeButton = dialog.find('footer .button.close')
    prevButton = dialog.find('footer .button.prev')
    if parseInt(nextSlide.length) isnt 0
      if nextButton.hasClass('hidden')
        return false
      currentSlide.addClass('hidden')
      nextSlide.removeClass('hidden')
      if prevButton.hasClass('hidden')
        prevButton.removeClass('hidden')
      if parseInt(nextSlide.index()) is parseInt(content.children().last().index())
        nextButton.removeClass('next').addClass('close').text('Close')
      else
        if not content.find('footer .button.next').hasClass('next')
          closeButton.removeClass('close').addClass('next').text('Next')
      dialog.attr('data-wait', 'true')
      setTimeout (->
        dialog.attr('data-wait', 'false')
      ), self._wait
      return nextSlide
    else
      if closeButton.hasClass('hidden')
        return false
      if parseInt(closeButton.length) isnt 0
        self.hideDialog(self.getActiveDialogName().replace('dialog_', ''))
        setTimeout (->
          content.find('.message').not('.hidden').addClass('hidden')
          content.find('.message').first().removeClass('hidden')
          if parseInt(content.find('.message').length) > 1
            closeButton.removeClass('close').addClass('next').text('Next')
          prevButton.addClass('hidden')
        ), 500
        RPG.scene.setScenes(RPG.scene.getPreviousScene())
        if typeof self._whenFinished is 'function'
          self._whenFinished()
          self._whenFinished = null
    return false
  prevMessage: (@name) ->
    self = this
    dialog = $('div#dialog_' + @name.replace('dialog_', ''))
    if dialog.attr('data-wait') is 'true'
      return false
    content = dialog.find('section.content')
    currentSlide = content.find('.message').not('.hidden')
    prevSlide = currentSlide.prev()
    nextButton = dialog.find('footer .button.next')
    closeButton = dialog.find('footer .button.close')
    prevButton = dialog.find('footer .button.prev')
    if prevButton.hasClass('hidden')
      return false
    if parseInt(currentSlide.length) isnt 0 and parseInt(currentSlide.index()) isnt 0
      currentSlide.addClass('hidden')
      prevSlide.removeClass('hidden')
      if parseInt(prevSlide.index()) is 0
        prevButton.addClass('hidden')
      if closeButton.length isnt 0 and parseInt(prevSlide.index()) isnt parseInt(content.children().last().index())
        closeButton.removeClass('close').addClass('next').text('Next')
      dialog.attr('data-wait', 'true')
      setTimeout (->
        dialog.attr('data-wait', 'false')
      ), self._wait
      return prevSlide
    return false
module.exports = messages