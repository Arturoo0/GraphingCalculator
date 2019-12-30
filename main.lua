
local grid = require "src/grid"

function love.load()
  love.graphics.setBackgroundColor(1,1,1)
end

function love.update(dt)
end

function love.draw()
  grid:draw()
end
