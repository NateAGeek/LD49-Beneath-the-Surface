MapLoader = {}

MapLoader.new = function(settings)
  local obj = {}

  local mapImage = love.image.newImageData(settings["map"])
  local mapWidth = mapImage:getWidth()
  local mapHeight = mapImage:getHeight()

  local TilesImage = love.graphics.newImage(settings["tile"])
  local TilesImageWidth = TilesImage:getWidth()
  local TilesImageHeight = TilesImage:getHeight()
  local tileWidth = settings["TileWidth"]
  local tileHeight = settings["TileHeight"]
  local tileScaleX = settings["TileScaleX"]
  local tileScaleY = settings["TileScaleY"]
  local Tiles = {}

  local mapData = {}

  obj.load = function()
  TilesImage:setFilter("nearest", "nearest")

    for y = 0, (TilesImageHeight/tileHeight) do
      for x = 0, (TilesImageWidth/tileWidth) do
        table.insert(Tiles, love.graphics.newQuad(x*tileWidth, y*tileHeight, tileWidth, tileHeight, TilesImageWidth, TilesImageHeight))
      end
    end

    for x = 0, mapWidth-1 do
      mapData[x] = {}
      for y = 0, mapHeight-1 do
        r, g, b = mapImage:getPixel(x, y)
        mapData[x][y] = getTileID(r, g, b)
      end
    end
  end

  obj.update = function(dt)

  end

  obj.draw = function()
    for x = 0, mapWidth-1 do
      for y = 0, mapHeight-1 do
        love.graphics.draw(TilesImage, Tiles[mapData[x][y]], x*tileWidth*tileScaleX, y*tileHeight*tileScaleY, 0, tileScaleX, tileScaleY)
      end
    end
  end

  return obj
end

function getTileID(r, g, b)
  if r == 255 and g == 255 and b == 255 then
    return 1
  end
  if r == 0 and g == 0 and b == 0 then
    return 2
  end
end
