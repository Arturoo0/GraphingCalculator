local lg = love.graphics
local floor = math.floor

local function drawRiemann(equation)
  local coords = equation:getCoords()
  for i = 1, 200000, 800 do
    local x = coords[i]
    local y = grid.halfHeight
    local x2 = coords[i + 4] - coords[i]
    local y2 = -grid.halfWidth + coords[i + 1]
    lg.rectangle('line', x, y, x2, y2)
  end
end

local function truncate(x)
  return floor(x * 1000) / 1000
end

local function computeRiemannSum(func)
  local sum = 0
  local y = 0
  for x = -50, 50, 0.001 do
    y = func(x)
    sum = sum + ((x + 0.001) - x) * y
  end
  return truncate(sum)
end

local function drawRiemannAndGetArea(eq, num)
  drawRiemann(eq)
  return computeRiemannSum(eq:getFunc())
end

return drawRiemannAndGetArea
