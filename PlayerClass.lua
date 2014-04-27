PlayerClass = {}

PlayerClass.new = function(init_x, init_y)
  local obj = {}
  local x = init_x
  local y = init_y
  local image = love.graphics.newImage("GFX/Player.png")
  local speed = 2
  local scale = 2
  local width = 32 * scale
  local height = 32 * scale
  local DirectionSine = {x = 0, y = 0}
  local OffsetX = 0 * scale
  local OffsetY = 0 * scale
  local vel = {x = 0, y = 0}
  local acc = {x = 0, y = 10}
  local mov = {x = 0, y = 0}
  local direction = "right"
  local onGround = false

  -- local spriteQuads = {
  --   right = {
  --     love.graphics.newQuad(0, 0, 32, 32, image:getWidth(), image:getHeight());
  --   },
  --   left = {
  --     love.graphics.newQuad(32, 0, 32, 32, image:getWidth(), image:getHeight());
  --   }
  -- }

  obj.load = function()
    image:setFilter("nearest", "nearest")
  end

  obj.update = function(dt)


    y = y + math.floor(vel.y * speed * dt)

    if Collision.staticMapCollision(x+OffsetX, y+OffsetY, width, height) then
      if DirectionSine.y > 0 then
        vel.y = 0;
        y = math.floor((y + height + OffsetY) / 32) * 32 - (height + OffsetY) - 1
        onGround = true
      else
        vel.y = 0;
        y = math.floor((y + OffsetY)/ 32) * 32 + 32 - OffsetY
        onGround = true
      end
    end

    x = x + vel.x

    if Collision.staticMapCollision(x+OffsetX, y+OffsetY, width, height) then
      if DirectionSine.x > 0 then
        vel.x = 0;
        x = math.floor((x + width + OffsetX) / 32) * 32 - (width + OffsetX) - 1
      else
        vel.x = 0;
        x = math.floor((x + OffsetX) / 32) * 32 + 32 - OffsetX
      end
    end
    --print("2. y: "..y.." vel.y"..vel.y..", x: "..x.." vel.x: "..vel.x)
    --print("1. y: "..y.." vel.y"..vel.y..", x: "..x.." vel.x: "..vel.x)

    mov.x = 0

    DirectionSine.x = 0
    if vel.y > 0 then
      DirectionSine.y = 1
    else
      DirectionSine.y = -1
    end

    if love.keyboard.isDown("right", "d") then
      mov.x = 1
      DirectionSine.x = 1
      direction = "right"
    end
    if love.keyboard.isDown("left", "a") then
      mov.x = -1
      DirectionSine.x = -1
      direction = "left"
    end

    vel.x = speed * mov.x
    vel.y = vel.y + acc.y

  end

  obj.draw = function()
    love.graphics.draw(image, x, y, 0, scale, scale)
    love.graphics.rectangle("line", x+OffsetX, y+OffsetY, width, height)
  end

  obj.move = function(new_x, new_y)
    x = new_x
    y = new_y
  end

  obj.getX = function()
    return x
  end

  obj.getY = function()
    return y
  end

  obj.getWidth = function()
    return width
  end

  obj.getHeight = function()
    return height
  end

  obj.getScale = function()
    return scale
  end

  obj.getDirectionSine = function()
    return DirectionSine
  end

  obj.setX = function(new_x)
    x = new_x
  end

  obj.setY = function(new_y)
    y = new_y
  end

  obj.setSpeedX = function(s)
    speedx = s
  end

  obj.setSpeedY = function(s)
    speedy = s
  end

  obj.setSpeed = function(s)
    speedy = s
    speedx = s
  end

  obj.jump = function()
    vel.y = -500
    onGround = false
  end

  obj.onGround = function()
    return onGround
  end

  return obj
end
