-- Author: Bruce Berrios
-- Description: A textbox class for user input

local utf8 = require("utf8")

local lg = love.graphics
local concat, len, sub = table.concat, string.len, string.sub
local cos = math.cos

local textbox = {}

textbox.__index = textbox

function textbox:new(properties)

  local tb = {
    x = properties.x or 0,
    y = properties.y or 0,
    text = properties.text or "Hello World!",
    font = properties.font or lg:getFont(),
    backgroundColor = properties.backgroundColor or {1, 1, 1, 1},
    textColor = properties.textColor or {0, 0, 0, 1},
    focus = true,
  }

  tb.fontHeight = tb.font:getHeight()

  tb.width = properties.width or tb.font:getWidth(tb.text) * 2
  tb.height = properties.height or tb.fontHeight * 1.2

  tb.cursor = {
    x = 0,
    y = 0,
    alpha = 1,
    alphaTimer = 0,
    position = len(tb.text)
  }

  return setmetatable(tb, textbox)
end

function textbox:update(dt)
  if(self.focus) then
    self.cursor.alphaTimer = self.cursor.alphaTimer + dt
    self.cursor.alpha = 1 * cos(7 * self.cursor.alphaTimer) + 1
  else
    self.cursor.alphaTimer = 0
  end
end

function textbox:draw()
  lg.push("all")

  lg.setColor(self.backgroundColor)
  lg.rectangle("fill", self.x, self.y, self.width, self.height)

  lg.setFont(self.font)
  lg.setColor(self.textColor)
  lg.print(self.text, self.x, self.y)

  if(self.focus) then
    lg.setColor(0, 0, 0, self.cursor.alpha)
    lg.print("|", self.x + self.font:getWidth(self.text:sub(1, self.cursor.position)) - 2, self.y)
  end

  lg.pop()
end

function textbox:getInput(key)
  if(not self.focus) then return end

  local cursor = self.cursor

  local textBefore = sub(self.text, 1, cursor.position)
  local textAfter = sub(self.text, cursor.position + 1, len(self.text))

  self.text = textBefore .. key .. textAfter

  cursor.position = cursor.position + 1
end

function textbox:keypressed(key)
  if(not self.focus) then return end

  local cursor = self.cursor

  if(key == "backspace") then
    local textBefore, textAfter
    textBefore = sub(self.text, 1, cursor.position)
    textAfter = sub(self.text, cursor.position + 1, len(self.text))

    local byteoffset = utf8.offset(textBefore, -1)

    if (byteoffset) then
      textBefore = sub(textBefore, 1, byteoffset - 1)
      self.text = textBefore .. textAfter
      cursor.position = cursor.position - 1
    end
  end

  if(key == "left") then
    cursor.position = cursor.position - 1
  elseif(key == "right") then
    cursor.position = cursor.position + 1
  end

  local textLength = len(self.text)

  cursor.position = (cursor.position > textLength) and textLength or cursor.position
  cursor.position = (cursor.position < 0) and 0 or cursor.position
end

function textbox:getText()
  return self.text
end

return textbox