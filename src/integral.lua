
--author: Arturo Portelles
-- Integration

local equation = require "src/equation"
lg = love.graphics

local eq = equation:new {
  --color = color:get("orange-light"),
  grid = grid,
  func = function(x)
    return (x^2) - 3
  end
}

local coords = eq:getCoords()
local trueCoords = eq:getTrueCoords()
sum = 0

-- 100,000 points 25,000 boxes 50,000 coordinates

local function getTrueX(x)
  trueX = ((x - grid.halfWidth) * 2) / grid.tileSize
  return trueX
end

local function getTrueY(y)
  trueY = ((y - grid.halfHeight / -1) * 2) / grid.tileSize
  return trueY
end

function computeIntegral()
  sum = 0

  for i = 1, 100000, 2 do
    --sum = sum + ((getTrueX(coords[i + 4]) - getTrueX(coords[i])) * (-(875) - (-getTrueY(coords[i]))))
    sum = sum + (trueCoords[i + 2] - trueCoords[i]) * (trueCoords[i + 1])
  end

  return sum
end

function draw()
  eq:draw()

  for i = 1, 200000, 800 do
    if(coords[i + 1] >= 0) then
      lg.rectangle("line", coords[i], grid.halfHeight, coords[i + 4] - coords[i], -(875) - (-coords[i + 1]))
    end
  end

  lg.setColor(0,0,0)
  lg.print(computeIntegral(), 875)

end
