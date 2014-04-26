EntityManager = {}
require"TheKid"
require"Beds"

EntityManager.new = function(settings)
  local obj = {}
  local Player = TheKid.new(settings["PlayerSpawnX"], settings["PlayerSpawnY"])
  local EntitiesImage = love.image.newImageData(settings["entitymap"])
  local EntitiesWidth = EntitiesImage:getWidth()
  local EntitiesHeight = EntitiesImage:getHeight()
  local Entities = {}

  obj.load = function()
    Player.load()

    for x = 0, EntitiesWidth-1 do
      for y = 0, EntitiesHeight-1 do
        r, g, b = EntitiesImage:getPixel(x, y)
        if r ~= 0 and g ~= 0 and b ~= 0 then
          table.insert(Entities, spawnEntity(r, g, b, x, y))
        end
      end
    end

    for i, en in ipairs(Entities) do
      en.load()
    end
  end

  obj.update = function(dt)
    Player.update(dt)
    for i, en in ipairs(Entities) do
      en.update(dt)
    end
  end

  obj.draw = function()
    Player.draw()
    for i, en in ipairs(Entities) do
      love.graphics.setColor(math.random(0, 255), math.random(0, 255), math.random(0, 255))
      en.draw()
      love.graphics.setColor(255, 255, 255, 255)
    end
  end

  obj.addEntity = function(Entity)
    table.insert(Entities, Entity)
  end

  obj.getPlayer = function()
    return Player
  end

  return obj
end

function spawnEntity(r, g, b, x, y)
  if r == 255 and g == 255 and b == 255 then
    return Beds.new(x*32*2, y*32*2)
  end
  return 0
end
