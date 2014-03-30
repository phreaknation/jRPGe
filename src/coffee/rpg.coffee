window.RPG = class RPG
  constructor:   ->
    self = this

    # check to see if we already have RPG and return created object if we do
    return window.RPG._instance  if window.RPG and window.RPG._instance
    # create an instance of ourselves for future reference.
    @._instance = self

    self

  # extend an object with another object
  @extend = () ->
    # need to shorten this method of checking for overwrite. Unsure with coffeescript atm
    if typeof arguments[arguments.length-1] is 'boolean'
      @overwrite = arguments[arguments.length-1]
      delete arguments[arguments.length-1]

    # set default returned object
    primary = arguments[0]

    # loop over each argument to write to primary
    for index, obj of arguments
      for key, func of obj
        # overwrite keys
        if @overwrite is true
          primary[key] = obj[key]
        # do not overwrite keys
        else
          # check to make sure key is not in primary
          if primary.hasOwnProperty(key) isnt true
            primary[key] = obj[key]
    primary

  # load and create an object from a module/plugin
  @load = (module, args = null) ->
    r = new module(args)
    return r

# Load Core Modules
RPG::initialize = RPG.load require("./core/initialize"), RPG
RPG::manager = RPG.load require("./core/manager")
RPG::proc = RPG.load require("./core/proc")
RPG::render = RPG.load require("./core/render")
RPG::animate = RPG.load require("./core/animate")
# Load Plugin Modules
RPG::utilities = RPG.load require("./modules/utilities")
RPG::setup = RPG.load require("./modules/setup")
RPG::io = RPG.load require("./modules/io")
RPG::ui = RPG.load require("./modules/ui")
RPG::scene = RPG.load require("./modules/scene")
RPG::entity = RPG.load require("./modules/entity")
RPG::manager = RPG.extend RPG::manager, RPG.load(require("./modules/manager"))

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