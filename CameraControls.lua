CameraControls = {}

CameraControls.new = function(settings)
  local obj = {}

  local winWidth, winHeight = love.graphics.getDimensions()

  local Focus = nil;

  obj.setFocus = function(f)
    Focus = f
  end

  obj.follow = function()
    if Focus ~= nil then
      love.graphics.translate(f.getX()+math.floor(winWidth/2), f.getY()+math.floor(winHeight/2))
    else
      print("Focus is NULL")
    end
  end

  obj.moveCenter = function(x, y)
    love.graphics.translate(x+math.floor(winWidth/2), y+math.floor(winHeight/2))
  end

  obj.move = function(x, y)
    love.graphics.translate(x, y)
  end

  obj.reset = function()
    love.graphics.origin()
  end



  return obj
end
