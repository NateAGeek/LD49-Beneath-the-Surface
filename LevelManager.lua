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
  WaterShader = love.graphics.newShader("shaders/Water.ps")
  WaterShaderMap = love.graphics.newImage(Settings["WaterMap"])
  totalTime = 0.0

  obj.load = function()
    Level.load()
    Collision.loadStaticMap()
    EntityMan.load()
    Player = EntityMan.getPlayer()
    --WaterShader:send("WaterMap", WaterShaderMap)
  end

  obj.update = function(dt)
    totalTime = totalTime + dt + 0.2
    WaterShader:send("time", totalTime)
    --WaterShader:send("Player_pos", {Player.getX()-(Player.getWidth()/2), Player.getY()-(Player.getHeight()/2)})
    print("Player.x: "..Player.getX()-(Player.getWidth()/2)..", Player.y:".. Player.getY()-(Player.getHeight()/2))
    Level.update(dt)
    EntityMan.update(dt)
  end

  obj.draw = function()
    love.graphics.setCanvas(Canvas)
      Canvas:clear()
        Camera.moveCenter(-Player.getX()-(Player.getWidth()/2), -Player.getY()-(Player.getHeight()/2))
        love.graphics.push()
        Level.draw()
        EntityMan.draw()
    love.graphics.setCanvas()
    love.graphics.pop()
    love.graphics.origin()
    love.graphics.setShader(WaterShader)
    love.graphics.draw(Canvas)
    love.graphics.setShader()
  end

  return obj
end

function love.keypressed(key, isrepeat)
  if key == "w" and Player.onGround() then
    Player.jump()
  end

end
