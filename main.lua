function love.load()
  require"LevelManager"
  --love.graphics.setWireframe(true)
  Level = LevelManager.new(1)
  Level.load()
  --love.graphics.setBackgroundColor(255, 255, 255)

end

function love.update(dt)
  Level.update(dt)
end

function love.draw()
  Level.draw()

end
