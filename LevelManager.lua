LevelManager = {}
require"MapLoader"
require"CollisionManager"
require"EntityManager"
require"CameraControls"

Level = {}
Collision = {}
EntityMan = {}
Camera = {}

Player = {}

LevelManager.new = function(lid)
  local obj = {}
  local Settings = love.filesystem.load("levels/"..lid.."/mapSettings.lua")()
  local Level = MapLoader.new(Settings)
  Collision = CollisionManager.new(Settings)
  EntityMan = EntityManager.new(Settings)
  Camera = CameraControls.new(Settings)

  obj.load = function()
    Level.load()
    Collision.loadStaticMap()
    EntityMan.load()
    Player = EntityMan.getPlayer()
  end

  obj.update = function(dt)
    Level.update(dt)
    EntityMan.update(dt)
  end

  obj.draw = function()
    Camera.moveCenter(-Player.getX()-(Player.getWidth()/2), -Player.getY()-(Player.getHeight()/2))
    Level.draw()
    EntityMan.draw()
  end

  return obj
end
