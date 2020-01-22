
local lg = love.graphics
local floor = math.floor

local riemann = {
  textX = 1130
}

local function drawRiemann(equation)
  local coords = equation:getCoords()

  for i = 1, 200000, 800 do
    local x = coords[i]
    local y = grid.halfHeight

    local x2 = coords[i + 4] - coords[i]
    local y2 = -grid.halfWidth + coords[i + 1]

    lg.rectangle("line", x, y, x2, y2)
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

function riemann.printRiemann(eq)
  local eqColor = eq:getColor()

  -- green
  if eqColor== color:get("green-light") then
    drawRiemann(eq)
    color:set("green-dark")
    lg.print(": " .. computeRiemannSum(eq:getFunc()), riemann.textX, 1040, r, 2.0)
  end

  -- blue
  if eqColor== color:get("blue-light") then
    drawRiemann(eq)
    color:set("blue-light")
    lg.print(": " .. computeRiemannSum(eq:getFunc()), riemann.textX, 1065, r, 2.0)
  end

  -- yellow
  if eqColor== color:get("yellow-light") then
    drawRiemann(eq)
    color:set("yellow-light")
    lg.print(": " .. computeRiemannSum(eq:getFunc()), riemann.textX, 1090, r, 2.0)
  end

  -- orange
  if eqColor== color:get("orange-light") then
    drawRiemann(eq)
    color:set("orange-light")
    lg.print(": " .. computeRiemannSum(eq:getFunc()), riemann.textX, 1115, r, 2.0)
  end

  -- red
  if eqColor== color:get("red-light") then
    drawRiemann(eq)
    color:set("red-light")
    lg.print(": " .. computeRiemannSum(eq:getFunc()), riemann.textX, 1140, r, 2.0)
  end

  -- purple
  if eqColor== color:get("purple-light") then
    drawRiemann(eq)
    color:set("purple-light")
    lg.print(": " .. computeRiemannSum(eq:getFunc()), riemann.textX, 1165, r, 2.0)
  end

  -- turquoise
  if eqColor== color:get("turquoise-light") then
    drawRiemann(eq)
    color:set("turquoise-light")
    lg.print(": " .. computeRiemannSum(eq:getFunc()), riemann.textX, 1190, r, 2.0)
  end
end

return riemann
