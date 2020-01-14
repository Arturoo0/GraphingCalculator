
--author: Arturo Portelles
-- Integration

lg = love.graphics

-- 100,000 points 25,000 boxes 50,000 coordinates

local function getTrueX(x)
  trueX = ((x - grid.halfWidth) * 2) / grid.tileSize
  return trueX
end

local function getTrueY(y)
  trueY = ((y - grid.halfHeight / -1) * 2) / grid.tileSize
  return trueY
end

local function computeIntegral(equation)
  sum = 0

  for i = 1, 100000, 2 do
    sum = sum + (getTrueX(equation.coords[i + 2]) - getTrueX(equation.coords[i])) * getTrueY(equation.coords[i + 1])
  end

  return sum
end

function Integral(equation)

  for i = 1, 200000, 800 do
    if(coords[i + 1] >= 0) then
      lg.rectangle("line", coords[i], grid.halfHeight, coords[i + 4] - coords[i], -(875) - (-coords[i + 1]))
    end
  end

  lg.setColor(0,0,0)
  lg.print(computeIntegral(equation), 875)

end
