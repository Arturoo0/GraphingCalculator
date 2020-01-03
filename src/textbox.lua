-- Author: Bruce Berrios
-- Description: A textbox class for user input
local lg = love.graphics
local concat = table.concat

local textbox = {}

textbox.__index = textbox

function textbox:new(properties)

  local tb = {
    x = properties.x or 0,
    y = properties.y or 0,
    text = properties.text or "Hello World!",
    font = properties.font or lg:getFont(),
    buffer = {},
    backgroundColor = properties.backgroundColor or {1, 1, 1, 1}
    textColor = properties.textColor or {0, 0, 0, 1}
  }

  tb.width = properties.width or tb.font:getWidth("w") * 12
  tb.height = properties.height or tb.font:getHeight() * 1.2

  return setmetatable(tb, textbox)
end

function textbox:draw()

end

function textbox:getInput(t)
end

function textbox:getText()
  return concat(self.buffer)
end

return textbox