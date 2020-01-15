
local lg = love.graphics
local color = require("src/color")

local riemann = {

}
-- colors - Green -
-- colors - blue
-- colors - yellow
-- colors - orange
-- colors - red -
-- colors - purple
-- colors - turquoise

local function printRiemann(equation)

  -- green
  if equation.getColor == parseRGBA(parseHex("#2ecc71")) or equation.getColor == parseRGBA(parseHex("#27ae60")) then
    lg.print(drawIntegral(equation), 0 , 0)
  end

  -- blue
  if equation.getColor == parseRGBA(parseHex("#3498db")) or equation.getColor == parseRGBA(parseHex("#2980b9")) then
    lg.print(drawIntegral(equation), 20 , 20)
  end

  -- yellow
  if equation.getColor == parseRGBA(parseHex("#f1c40f")) or equation.getColor == parseRGBA(parseHex("#f39c12")) then
    lg.print(drawIntegral(equation), 40 , 40)
  end

  -- orange
  if equation.getColor == parseRGBA(parseHex("#e67e22")) or equation.getColor == parseRGBA(parseHex("#d35400")) then
    lg.print(drawIntegral(equation), 60 , 60)
  end

  -- red
  if equation.getColor == parseRGBA(parseHex("#e74c3c")) or equation.getColor == parseRGBA(parseHex("#c0392b")) then
    lg.print(drawIntegral(equation), 80 , 80)
  end

  -- purple
  if equation.getColor == parseRGBA(parseHex("#9b59b6")) or equation.getColor == parseRGBA(parseHex("#8e44ad")) then
    lg.print(drawIntegral(equation), 80 , 80)
  end

  -- turquoise
  if equation.getColor == parseRGBA(parseHex("#1abc9c")) or equation.getColor == parseRGBA(parseHex("#16a085")) then
    lg.print(drawIntegral(equation), 80 , 80)
  end

end

return riemann
