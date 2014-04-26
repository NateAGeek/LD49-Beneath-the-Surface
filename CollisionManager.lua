CollisionManager = {}

CollisionManager.new = function(settings)
  local obj = {}
  local staticCollisionMap = {}

  local collisionMapImage = love.image.newImageData(settings["collisionmap"])
  local collisionMapTileWidth = settings["collisionTileWidth"]
  local collisionMapTileHeight = settings["collisionTileHeight"]
  local collisionMapTileScale = settings["collisionTileScale"]
  local collisionMapWidth = collisionMapImage:getWidth()
  local collisionMapHeight = collisionMapImage:getHeight()

  obj.loadStaticMap = function()
    for x = 0, collisionMapWidth-1 do
      staticCollisionMap[x] = {}
      for y = 0, collisionMapHeight-1 do
        r, g, b = collisionMapImage:getPixel(x, y)
        if r == 0 and b == 0 and g == 0 then
          staticCollisionMap[x][y] = 0
        else
          staticCollisionMap[x][y] = 1
        end
      end
    end
  end

  obj.addStatic = function(x, y)
    staticCollisionMap[x][y] = 1
  end

  obj.removeStatic = function(x, y)
    staticCollisionMap[x][y] = 0
  end

  obj.staticMapCollision = function(x, y, width, height)
    if x < collisionMapWidth*collisionMapTileWidth*collisionMapTileScale and y < collisionMapHeight*collisionMapTileHeight*collisionMapTileScale and y > 0 and x > 0 then
      mapLX = math.floor(x/(collisionMapTileWidth*collisionMapTileScale))
      mapTY = math.floor(y/(collisionMapTileHeight*collisionMapTileScale))
      mapRX = math.floor((x+width)/(collisionMapTileWidth*collisionMapTileScale))
      mapLY = math.floor((y+height)/(collisionMapTileHeight*collisionMapTileScale))
      --print("X: "..x..", Y: "..y)

      if staticCollisionMap[mapLX][mapTY] == 1 or staticCollisionMap[mapRX][mapTY] == 1 or staticCollisionMap[mapLX][mapLY] == 1 then
        --print("MapLX: "..mapLX..", MapTR: "..mapRX..", MapTY: "..mapTY..", MapLY: "..mapLY..", Hit: TRUE")
        return true
      else
        --print("MapLX: "..mapLX..", MapTR: "..mapRX..", MapTY: "..mapTY..", MapLY: "..mapLY..", Hit: FALSE")
        return false
      end
    else
      --print("WTF m8? Fight ME!")
    end
  end

  obj.entityCollision = function(e1, e2, onHit)
    if e1.x > e2.x and e1.x + e1.width*e1.scaleX < e2.x + e2.width*e2.scaleX and e1.y > e2.y and e1.y + e1.height*e1.scaleY < e2.y + e2.height*e2.scaleY then
      onHit()
    end
  end

  obj.AABBCollision = function(x1, y1, width1, height1, x2, y2, width2, height2, onHit)
    if x1 > x2 and x1 + width1 < x2 + width2 and y1 > y2 and y1 + height1 < y2 + height2 then
      onHit()
    end
  end

  return obj
end
