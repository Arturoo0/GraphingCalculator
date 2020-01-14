
--author: Arturo Portelles
-- Integration
local floor = math.floor
local lg = love.graphics

local function computeRiemannSum(func)
  local sum = 0
  local y = 0

  for x = -50, 50, 0.001 do
    y = func(x)
    sum = sum + ((x + 0.001) - x) * y
  end

  return sum
end

local function truncate(x)
  return floor(x * 1000) / 1000
end

local function drawIntegral(equation)

  local coords = equation:getCoords()

  for i = 1, 200000, 800 do
    lg.rectangle("line", coords[i], grid.halfHeight, coords[i + 4] - coords[i], -(875) - (-(coords[i + 1])))
  end

  lg.setColor(0,0,0)
  lg.print("Definite Integral " .. truncate(computeRiemannSum(equation.func)), 805, 540, r, 1.40, 1.40)

end

return drawIntegral