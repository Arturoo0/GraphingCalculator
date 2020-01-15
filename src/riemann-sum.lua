
local lg = love.graphics
local drawIntegral = require "src/integral"

local riemann = {

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
  end

  -- blue
  if eq:getColor() == color:get("blue-light") then
    drawIntegral(eq)
  end

  -- yellow
  if eq:getColor() == color:get("yellow-light") then
    drawIntegral(eq)
  end

  -- orange
  if eq:getColor() == color:get("orange-light") then
    drawIntegral(eq)
  end

  -- red
  if eq:getColor() == color:get("red-light") then
    drawIntegral(eq)
  end

  -- purple
  if eq:getColor() == color:get("purple-light") then
    drawIntegral(eq)
  end

  -- turquoise
  if eq:getColor() == color:get("turquoise-light") then
    drawIntegral(eq)
  end

end

return riemann
