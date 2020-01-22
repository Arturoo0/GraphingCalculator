
local lg = love.graphics
local floor = math.floor

local riemann = {
  textX = 1100
}

local function drawRiemann(equation)

  local coords = equation:getCoords()

  for i = 1, 200000, 800 do
    lg.rectangle("line", coords[i], grid.halfHeight, coords[i + 4] - coords[i], -(875) - (-(coords[i + 1])))
  end

  lg.setColor(0,0,0)
  -- lg.print("Definite Integral " .. truncate(computeRiemannSum(equation.func)), 805, 540, r, 1.40, 1.40)
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

  -- green
  if eq:getColor() == color:get("green-light") then
    drawRiemann(eq)
    lg.print(": " .. computeRiemannSum(eq:getFunc()), riemann.textX, 890, r, 2.0)
  end

  -- blue
  if eq:getColor() == color:get("blue-light") then
    drawRiemann(eq)
    lg.print("BLUE", riemann.textX, 910, r, 2.0)
  end

  -- yellow
  if eq:getColor() == color:get("yellow-light") then
    drawRiemann(eq)
    lg.print("Yellow", riemann.textX, 930, r, 2.0)
  end

  -- orange
  if eq:getColor() == color:get("orange-light") then
    drawRiemann(eq)
    lg.print("Orange", riemann.textX, 950, r, 2.0)
  end

  -- red
  if eq:getColor() == color:get("red-light") then
    drawRiemann(eq)
    lg.print("Red", riemann.textX, 970, r, 2.0)
  end

  -- purple
  if eq:getColor() == color:get("purple-light") then
    drawRiemann(eq)
    lg.print("Purple", riemann.textX, 990, r, 2.0)
  end

  -- turquoise
  if eq:getColor() == color:get("turquoise-light") then
    drawRiemann(eq)
    lg.print("turquoise", riemann.textX, 1010, r, 2.0)
  end

end

return riemann
