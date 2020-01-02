
-- Author : Arturo Portelles
-- Grid layout and scale

local lg = love.graphics

local grid = {
  tileSize = 35,
  width = 1750,
  height = 1750,
  halfWidth = 875,
  halfHeight = 875,
  tiles = 50,
  scale = 10
}

function grid:draw()

  color:set("black-dark", 0.35)

  local currentX = 0
  local currentY = 0
  local counter = 0
  local yAxisTemp = self.halfHeight + (self.height/self.scale)
  local xAxisTemp = 0

  for i = 1, self.tiles do

    if (counter == 5) then
      lg.setLineWidth(3)

      lg.line((i - 1) * self.tileSize, 0, (i - 1) * self.tileSize, self.width)
      lg.line(0, currentY, self.height, currentY)

      counter = 0
    end

    lg.setLineWidth(1)

    for i = 1, self.tiles do
      lg.rectangle("line", currentX, currentY, self.tileSize, self.tileSize)

      currentX = currentX + self.tileSize
    end

    counter = counter + 1
    currentX = 0
    currentY = currentY + self.tileSize

  end

  for i = 1,5 do -- bottom y axis
    if (i == 5) then
      lg.print(-(i * self.scale), self.halfWidth + 5, yAxisTemp - 15, r, 1)
    else
      lg.print(-(i * self.scale), self.halfWidth + 5, yAxisTemp + 3, r, 1)
      yAxisTemp = yAxisTemp + 175
    end
  end

  yAxisTemp = 0

  for i = 5,1,-1 do -- top y axis
    lg.print((i * self.scale), self.halfWidth + 5, yAxisTemp + 3, r, 1)
    yAxisTemp = yAxisTemp + 175
  end

  for i = 5,1,-1 do -- left x axis
    lg.print(-(i * self.scale), xAxisTemp + 7, yAxisTemp + 3, r, 1)
    xAxisTemp = xAxisTemp + 175
  end

  xAxisTemp = xAxisTemp + 175

  for i = 1,5 do -- right x axis
    if (i == 5) then
      lg.print((i * self.scale), xAxisTemp - 17, yAxisTemp + 3, r, 1)
    else
      lg.print((i * self.scale), xAxisTemp + 7, yAxisTemp + 3, r, 1)
      xAxisTemp = xAxisTemp + 175
    end
  end

  lg.setLineWidth(5)
  lg.line(0, self.halfHeight, self.width, self.halfHeight)
  lg.line(self.halfWidth, 0, self.halfWidth, self.height)

end

return grid
