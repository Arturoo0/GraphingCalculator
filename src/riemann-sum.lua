
local lg = love.graphics
local drawIntegral = require "src/integral"

local riemann = {

  textX = 1100


}

-- colors - Green -
-- colors - blue
-- colors - yellow
-- colors - orange
-- colors - red -
-- colors - purple
-- colors - turquoise

function riemann.printRiemann(eq)

  -- green
  if eq:getColor() == color:get("green-light") then
    drawIntegral(eq)
    lg.print("GREEN", riemann.textX, 890, r, 2.0)
  end

  -- blue
  if eq:getColor() == color:get("blue-light") then
    drawIntegral(eq)
    lg.print("BLUE", riemann.textX, 910, r, 2.0)
  end

  -- yellow
  if eq:getColor() == color:get("yellow-light") then
    drawIntegral(eq)
    lg.print("Yellow", riemann.textX, 930, r, 2.0)
  end

  -- orange
  if eq:getColor() == color:get("orange-light") then
    drawIntegral(eq)
    lg.print("Orange", riemann.textX, 950, r, 2.0)
  end

  -- red
  if eq:getColor() == color:get("red-light") then
    drawIntegral(eq)
    lg.print("Red", riemann.textX, 970, r, 2.0)
  end

  -- purple
  if eq:getColor() == color:get("purple-light") then
    drawIntegral(eq)
    lg.print("Purple", riemann.textX, 990, r, 2.0)
  end

  -- turquoise
  if eq:getColor() == color:get("turquoise-light") then
    drawIntegral(eq)
    lg.print("turquoise", riemann.textX, 1010, r, 2.0)
  end

end

return riemann
