
local grid = {
  size = 35,
}

function grid:draw()
  currentX = 0
  currentY = 0

  for i = 1, 50 do
    for i = 1, 50 do
      love.graphics.setColor(0,0,0)
      love.graphics.rectangle("line", currentX, currentY, self.size, self.size)
      currentX = currentX + self.size
    end
    currentX = 0
    currentY = currentY + self.size
  end
end

return grid
