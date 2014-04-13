         _  _______     _______     ______
        (_)|_   __ \   |_   __ \  .' ___  |
        __   | |__) |    | |__) |/ .'   \_|
       [  |  |  __ /     |  ___/ | |   ____
     _  | | _| |  \ \_  _| |_    \ `.___]  |
    [ \_| ||____| |___||_____|    `._____.'
     \____/
     ________                   _
    |_   __  |                 (_)
      | |_ \_| _ .--.   .--./) __   _ .--.  .---.
      |  _| _ [ `.-. | / /'`\;[  | [ `.-. |/ /__\\
     _| |__/ | | | | | \ \._// | |  | | | || \__.,
    |________|[___||__].',__` [___][___||__]'.__.'
                      ( ( __))

Generated With: http://patorjk.com/software/taag/

About RPG Engine
======================================
jRPG Engine is an open source project for creating Canvas/WebGL (j)RPG styled games made with node, coffeescript, and a few other tools

RPG Engine External Requirements
--------------------------------------
1.  [NodeJS](http://www.nodejs.org/)
2.  [CoffeeScript](http://www.coffeescript.org/)
3.  [PixiJS](http://www.pixijs.com/)

Build TweenJS with TickerJS for tweening
--------------------------------------
1.  Download the ticker file here: https://github.com/CreateJS/EaselJS/tree/master/src/easeljs/utils/Ticker.js
2.  Download the TweenJS source here: https://github.com/CreateJS/TweenJS
3.  Copy Ticker.js in src/tweenjs
4.  Add "../src/tweenjs/Ticker.js", right after "../src/createjs/events/EventDispatcher.js", in build/config.json
5.  Run grunt build

Build RPG Engine
--------------------------------------
### Update and Install the pre-req modules in the root folder.
> npm i

### Run coffeescript to build the javascript sources and watch for updates.
> coffee -o src/scripts -cw src/coffee/

### Run gulp in watch mode to compile sources and place into directories specified in gulpfile.js.
> gulp watch

### Include into you game
#### minified
    <script src="path/to/rpg.min.js"></script>
#### development
    <script src="path/to/rpg.dev.js"></script>

### Current Features
---------------------------------------
Currently under heavy redesign so all current features have been shifted as there they will be rewritten in coffeescript.



### Planned Features
---------------------------------------
* Keyboard Inputs
* Character Animation
* Map Loading
* Tilesets
* Simple Collision Detection
* Step Counting
* Debugging
* Mouse Inputs
* Touch Imputs
* Backgrounds - Map Based
* Paralax Backgrounds - Map Based
* Simple Pathing
* Weighted Pathing
* Step Counting
* Global Events
* Triggered Events
* Character Loading
* TMX Map Loading
* Particles(?)

### Planned Tools
---------------------------------------
* Character Generator
* Resource Manager
* TMX Map Converter
* Database Manager
 * Actor Editor
 * Class Editor
 * Skill Editor
 * Items Editor
 * Weapons Editor
 * Armors Editor
 * Enemies Editor
 * Troops Editor
 * States Editor
 * Animations Editor
 * Tilesets Editor
 * Common Events Editor
 * System Editor
 * Phrase Editor



### Possible Tools
---------------------------------------
* Map Manager
 * Map Editor
   * Pens
   * Pencil
   * Rectangle
   * Circle
   * Fill
   * Shadow
* Region Editor
* Event Editor
* Auto Tiling
* Auto Shadows
* Common Events Editor
* System Editor
* Terms Editor