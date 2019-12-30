
local grid = require "src/grid"

function love.load()
  love.window.setMode(700, 700, {
    display = 2
  })
  love.graphics.setBackgroundColor(1,1,1)
end

function love.update(dt)
end

function love.draw()
  grid:draw()
end
