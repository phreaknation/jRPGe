window.RPG = class RPG
  constructor: (@options, @callback) ->
    self = this
    # self.initialize(self).setOptions(@options)
    # self.initialize(self).load()
    self.scene().world()

    callback()  if callback isnt `undefined` and typeof callback is "function"
    self

  initialize: (@self) ->
    rq = require("./core/initialize")
    new rq(@self)
  proc: ->
    rq = require("./core/proc")
    new rq()
  render: ->
    rq = require("./core/render")
    new rq()
  animate: ->
    rq = require("./core/animate")
    new rq()
  scene: ->
    rq = require("./objects/scene")
    new rq()
  entity: ->
    rq = require("./objects/entity")
    new rq()
  io: ->
    rq = require("./plugins/io")
    new rq()
  manager: ->
    rq = require("./plugins/manager")
    new rq()
  ui: ->
    rq = require("./plugins/ui")
    new rq()
  utilities: ->
    rq = require("./plugins/utilities")
    new rq()

# plugins
# RPG::io = require("./plugins/io")
# RPG::io:: =
#   joypad: require("./plugins/io_joypad")
#   keyboard: require("./plugins/io_keyboard")
#   mouse: require("./plugins/io_mouse")
#   touch: require("./plugins/io_touch")

# RPG::manager = require("./plugins/manager")
# RPG::manager:: =
#   events: require("./plugins/manager_events")
#   phrase: require("./plugins/manager_phrase")
#   registry: require("./plugins/manager_registry")
#   resources: require("./plugins/manager_resources")
# RPG::manager::resources:: =
#   importer: require("./plugins/manager_resources_importer")
# RPG::manager::resources::importer =
#   jRPG: require("./plugins/manager_resources_importer_jRPG")
#   tmx: require("./plugins/manager_resources_importer_tmx")

# RPG::ui = require("./plugins/ui")
# RPG::ui:: =
#   menu: require("./plugins/ui_menu")
#   messages: require("./plugins/ui_messages")
# RPG::ui::menu:: =
#   battle: require("./plugins/ui_menu_battle")
#   main: require("./plugins/ui_menu_main")
#   selection: require("./plugins/ui_menu_selection")
#   title: require("./plugins/ui_menu_title")
# RPG::ui::messages:: =
#   chat: require("./plugins/ui_messages_chat")
#   informational: require("./plugins/ui_messages_informational")

# RPG::utilities = require("./plugins/utilities")
# RPG::utilities:: =
#   debug: require("./plugins/utilities_debug")
#   detect: require("./plugins/utilities_detect")
#   file: require("./plugins/utilities_file")
# #
#layers //new PIXI.DisplayObjectContainer()
#    background
#    floor
#    grid
#    sprites
#    tiles
#objects
#    characters
#    npcs
#