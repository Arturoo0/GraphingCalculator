
--author: Arturo Portelles
-- Integration
local floor = math.floor
local lg = love.graphics

local function getTrueX(x)
  trueX = ((x - grid.halfWidth) * 2) / grid.tileSize
  return trueX
end

local function getTrueY(y)
  trueY = ((y - grid.halfHeight) * -2) / grid.tileSize
  return trueY
end

local function computeIntegral(coords)
  sum = 0

  for i = 1, 200000, 2 do
    sum = sum + (getTrueX(coords[i + 2]) - getTrueX(coords[i])) * getTrueY(coords[i + 1])
  end

  return sum
end

function Integral(equation)

  coords = equation:getCoords()

  for i = 1, 200000, 800 do
      lg.rectangle("line", coords[i], grid.halfHeight, coords[i + 4] - coords[i], -(875) - (-(coords[i + 1])))
  end

  lg.setColor(0,0,0)
  lg.print(floor(computeIntegral(coords) * 1000)/1000, 875)

end
