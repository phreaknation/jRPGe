class initialize
  constructor: (@parent) ->
    self = this
    return RPG.instance  if RPG and RPG.instance
    self.parent = @parent
    @parent.instance = @parent

    self.setOptions = ({@options}) ->
      @options ?= {}
      self.options = @options
      self

    self.setupControls = ->
      if initialize.parent.isMobile
        initialize.upsert "keyboard", false, true
        initialize.upsert "mouse", false, true
        initialize.parent.proc().JSON "configs/touch", (data) ->
          #initialize.parent.actions = data;
          #initialize.parent.keyboard.initialize();
          initialize.upsert "touch", true
          return
      else
        initialize.upsert "touch", false, true
        initialize.parent.proc().JSON "configs/keyboard", (data) ->
          initialize.registry.register "actions", data
          initialize.parent.keyboard.initialize()
          return
        if initialize.parent.isMouseEnabled
          initialize.parent.proc().JSON "configs/mouse", (data) ->
          return


      #initialize.parent.actions = data;
      #initialize.parent.keyboard.initialize();

    self.setBaseOptions = (argument) ->
      # load default settings
      initialize.parent.proc().json "configs/base.json", (data) ->
        @callback = (data) ->
          initialize.registry.register "characters", data
          count = initialize.get("characters")
          count--
          if count is 0
            initialize.upsert "characters", true
          else
            initialize.upsert "characters", count
          return
        initialize.registry.register "defaults", data
        initialize.upsert "defaultOptions", true
        # initialize.upsert("characters", 0); character count
        # load default characters
        for i of data.characters
          name = data.characters[i]
          initialize.parent.proc().JSON "characters/" + name + "/character.json", @callback
        return
      return

    self.checkLoading = (toCheck) ->
      status = true
      for i of toCheck
        item = toCheck[i]
        status = false  if item isnt true
      status

    self.load = ->
      parent = self.parent
      stage = parent.manager().registry().acquire("stage")

      if stage
        stage parent.options.color or 0x80A0F0, RPG.isDevMode

        renderer = parent.manager().registry().acquire("renderer")
        if render
          renderer parent.options.width or 1024, parent.options.height or 768
          parent.animate()  if parent.options.start isnt `undefined` and parent.options.start
          return
        return
      return

    self

module.exports = initialize


###
"isDevMode": queryString()['dev'] || false,
"isMobile": queryString()['mobile'] || false,
"isPathingEnabled": queryString()['pathingenabled'] || true,
"isMouseEnabled": queryString()['mouseenabled'] || true,
"isAnimating": false,
###

#
#
#// worldName = get default world that is current loaded
#    proc().JSON("world/" + worldName, function(data) {
#        var world = parent.worlds[data.name] = data,
#            map,
#            tileset;
#
#        parent.worlds._current = data.name
#        parent.set.map(world, data.maps._initializeial);
#
#        parent.load.map(data.maps._initializeial, data.name, function() {
#            var group = [];
#            map = parent.get.currentMap(world);
#            tileset = parent.get.currentTileset(world, map, 0);
#            parent.render.map(world, map, tileset);
#
#            // load background audio
#            for (i in parent.get.currentMap(world).general.backgroundMusic) {
#                var track = parent.get.currentMap(world).general.backgroundMusic[i];
#                //group.push(new buzz.sound("assets/resources/music/" + track, { "formats": ["mp3","oog", "wav", "aac"] }));
#                parent.audio.background = new buzz.sound("assets/resources/music/" + track, {
#                    "formats": ["mp3", "oog", "wav", "aac"]
#                });
#            }
#            //parent.audio.background = new buzz.group(group);
#
#            world.group.position = parent.get.currentMap(world).general.start_position
#        });
#
#        for (i in parent.layers) {
#            parent.layers[i] = new PIXI.DisplayObjectContainer();
#            parent.get.Stage().addChild(parent.layers[i]);
#        }
#        self.upsert("world", true);
#    });
#
#

#
#
#oRPG.load.map(oRPG.world.name, 0, function() {
#    oRPG.load.tileset(oRPG.world.name, 0);
#});
#var t = setInterval(function() {
#    // TODO: Need to have RPG.initialize produce a loaded variable
#    if (oRPG.world.maps[0].map != null && oRPG.world.maps[0].tileset != null) {
#
#        // Setup scaling and filters
#        oRPG.world.scaleFactor = 2;
#
#        oRPG.world.filters = {
#            pixelate: new PIXI.PixelateFilter(),
#            blur: new PIXI.BlurFilter()
#        };
#
#        oRPG.world.filters.pixelate.size = 1.5;
#        oRPG.world.filters.blur.blue = 1.5;
#
#        // Do map stuff
#        oRPG.render.map(oRPG.world, 0);
#
#        // Load in player
#        oRPG.world.characters["Terra"] = oRPG.objects[0][0] = PIXI.Sprite.fromFrame('terra_idle_south.png');
#        oRPG.world.currentCharacter = oRPG.world.characters["Terra"];
#        oRPG.world.currentCharacter.scale.x = oRPG.world.scaleFactor;
#        oRPG.world.currentCharacter.scale.y = oRPG.world.scaleFactor;
#        oRPG.world.currentCharacter.anchor.x = 0.5;
#        oRPG.world.currentCharacter.anchor.y = 1;
#        oRPG.set.playerLocation(0);
#
#
#
#
#        clearInterval(t);
#    }
#}, 10);
#