
local grid = {
  size = 0,
  

}

function grid:draw()
  currentX = 0
  currentY = 0

  for i = 1, 10 do
    for i = 1, 10 do
      love.graphics.rectangle("line", currentX, currentY, self.sizeX, self.sizeY)
      currentX = currentX + self.sizeX
    end
    currentX = 0
    currentY = currentY + self.sizeY
  end
end

return grid
