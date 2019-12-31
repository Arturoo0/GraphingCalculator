
local lg = love.graphics

local grid = {
  size = 35,
  width = 1750,
  height = 1750,
  halfWidth = 875,
  halfHeight = 875,
  tiles = 50,
}

function grid:draw()

  color:set("black-dark", 0.35)

  local currentX = 0
  local currentY = 0
  local counter = 0

  for i = 1, self.tiles do

    if (counter == 5) then
      lg.setLineWidth(3)

      lg.line((i - 1) * self.size, 0, (i - 1) * self.size, self.width)
      lg.line(0, currentY, self.height, currentY)

      counter = 0
    end

    lg.setLineWidth(1)

    for i = 1, self.tiles do
      lg.rectangle("line", currentX, currentY, self.size, self.size)

      currentX = currentX + self.size
    end

    counter = counter + 1
    currentX = 0
    currentY = currentY + self.size

  end

  lg.setLineWidth(5)
  lg.line(0, self.halfHeight, self.width, self.halfHeight)
  lg.line(self.halfWidth, 0, self.halfWidth, self.height)

end

return grid
