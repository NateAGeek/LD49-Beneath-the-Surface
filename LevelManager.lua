LevelManager = {}
require"MapLoader"
require"CollisionManager"
require"EntityManager"
require"CameraControls"

Level = nil
Collision = nil
EntityMan = nil
Camera = nil

Player = nil
Canvas = nil

LevelManager.new = function(lid)
  local obj = {}
  local Settings = love.filesystem.load("levels/"..lid.."/mapSettings.lua")()
  local Level = MapLoader.new(Settings)
  Collision = CollisionManager.new(Settings)
  EntityMan = EntityManager.new(Settings)
  Camera = CameraControls.new(Settings)
  Canvas = love.graphics.newCanvas()

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
    love.graphics.setCanvas(Canvas)
      Canvas:clear()
        Level.draw()
        EntityMan.draw()
      love.graphics.draw(Canvas)
    love.graphics.setCanvas()
  end

  return obj
end

function love.keypressed(key, isrepeat)
  if key == "w" and Player.onGround() then
    Player.jump()
  end

end
