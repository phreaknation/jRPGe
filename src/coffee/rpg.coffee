window.RPG = class RPG
  constructor: () ->
      self = this
      # check to see if we already have RPG and return created object if we do
      return window.RPG._instance    if window.RPG and window.RPG._instance
      # create an instance of ourselves for future reference.
      @._instance = self
      self._verbose = arguments[0]['verbose']|| false
      if self._verbose
        console.info "Loaded RPG"
      window.RPG = self
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

#objects
#        characters
#        npcs
#