
local lg = love.graphics
local color = require("src/color")
require "src/integral"

local riemann = {

}
-- colors - Green -
-- colors - blue
-- colors - yellow
-- colors - orange
-- colors - red -
-- colors - purple
-- colors - turquoise

function riemann.printRiemann(equation)

  -- green
  if equation.getColor == color.parseRGBA(color.parseHex("#2ecc71")) or equation.getColor == color.parseRGBA(color.parseHex("#27ae60")) then
    drawIntegral(equation)
  end

  -- blue
  if equation.getColor == color.parseRGBA(color.parseHex("#3498db")) or equation.getColor == color.parseRGBA(color.parseHex("#2980b9")) then
    drawIntegral(equation)
  end

  -- yellow
  if equation.getColor == color.parseRGBA(color.parseHex("#f1c40f")) or equation.getColor == color.parseRGBA(color.parseHex("#f39c12")) then
    drawIntegral(equation)
  end

  -- orange
  if equation.getColor == color.parseRGBA(color.parseHex("#e67e22")) or equation.getColor == color.parseRGBA(color.parseHex("#d35400")) then
    drawIntegral(equation)
  end

  -- red
  if equation.getColor == color.parseRGBA(color.parseHex("#e74c3c")) or equation.getColor == color.parseRGBA(color.parseHex("#c0392b")) then
    drawIntegral(equation)
  end

  -- purple
  if equation.getColor == color.parseRGBA(color.parseHex("#9b59b6")) or equation.getColor == color.parseRGBA(color.parseHex("#8e44ad")) then
    drawIntegral(equation)
  end

  -- turquoise
  if equation.getColor == color.parseRGBA(color.parseHex("#1abc9c")) or equation.getColor == color.parseRGBA(color.parseHex("#16a085")) then
    drawIntegral(equation)
  end

end

return riemann
