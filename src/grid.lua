
local grid = {
  size = 35,
}

function grid:draw()

  color:set("black-dark")

  currentX = 0
  currentY = 0
  counter = 0

  for i = 1, 50 do

    if (counter == 5) then
      love.graphics.setLineWidth(3)
      love.graphics.line((i - 1) * self.size, 0, (i - 1) * self.size, self.size * 50)

      love.graphics.line(0, currentY, self.size * 50, currentY)
      counter = 0
    end

    love.graphics.setLineWidth(1)

    for i = 1, 50 do
      love.graphics.rectangle("line", currentX, currentY, self.size, self.size)

      currentX = currentX + self.size
    end

    counter = counter + 1
    currentX = 0
    currentY = currentY + self.size

  end

  love.graphics.setLineWidth(4)
  love.graphics.line(0, 875, 1750, 875)
  love.graphics.line(875, 0, 875, 1750)


end

return grid
