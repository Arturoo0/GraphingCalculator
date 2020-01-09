-- Author: Bruce Berrios
-- Description: A textbox class for user input

local utf8 = require("utf8")

local lg = love.graphics
local concat, len, sub, offset = table.concat, utf8.len, string.sub, utf8.offset
local cos, max, min, floor = math.cos, math.max, math.min, math.floor

local textbox = {}

textbox.__index = textbox

function textbox:new(properties)
  local properties = properties or {}

  local tb = {
    x = properties.x or 0,
    y = properties.y or 0,
    text = properties.text or "Hello World!",
    font = properties.font or lg:getFont(),
    backgroundColor = properties.backgroundColor or {1, 1, 1, 1},
    textColor = properties.textColor or {0, 0, 0, 1},
    focusBorderColor = properties.focusBorderColor or {0, 0.75, 1, 0.5},
    focusBorderWeight = properties.focusBorderWeight or 3,
    borderColor = properties.borderColor or {0.25, 0.25, 0.25, 0.25},
    borderWeight = properties.borderWeight or 3,
    focus = false,
    offset = 0,
    maxinput = properties.maxinput or 140,
  }

  tb.maxCharacterWidth = tb.font:getWidth("W|")
  tb.fontHeight = tb.font:getHeight()

  tb.width = properties.width or tb.font:getWidth(tb.text) * 2
  tb.height = properties.height or tb.fontHeight * 1.4

  tb.paddingTop = properties.paddingTop or (tb.height * 0.5) - (tb.fontHeight * 0.5)
  tb.paddingLeft = properties.paddingLeft or 12

  tb.cursor = {
    x = 0,
    y = tb.y + tb.paddingTop - 2,
    color = properties.cursorColor or {0.25, 0.25, 0.25, 1},
    alphaTimer = 0,
    position = len(tb.text)
  }

  tb.textLen = tb.cursor.position

  tb.offsetX = tb.x + tb.offset + tb.paddingLeft

  return setmetatable(tb, self)
end

function textbox:update(dt)
  if(not self.focus) then return end

  local cursor = self.cursor

  cursor.alphaTimer = cursor.alphaTimer + dt
  cursor.color[4] = 1 * cos(7 * cursor.alphaTimer) + 1

  if(cursor.position > 0) then
    local widthBefore = self.font:getWidth(sub(self.text, 1, cursor.position))
    local newSubText
    if(self.x > self.offsetX + widthBefore - self.maxCharacterWidth) then
      newSubText = sub(self.text, 1, cursor.position - 1)
      self.offset = -self.font:getWidth(newSubText) + self.maxCharacterWidth
    elseif(self.x + self.width < self.offsetX + widthBefore + self.maxCharacterWidth) then
      newSubText = sub(self.text, 1, cursor.position + 1)
      self.offset = self.width - self.font:getWidth(newSubText) - self.maxCharacterWidth
    end
  else
    self.offset = 0
  end

  self.offsetX = self.x + self.paddingLeft + min(self.offset, 0)
  cursor.x = self.offsetX + self.font:getWidth(sub(self.text, 1, cursor.position)) - 4
end

function textbox:draw()
  lg.push("all")

  lg.setColor(self.backgroundColor)
  lg.rectangle("fill", self.x, self.y, self.width, self.height)

  lg.setFont(self.font)
  lg.setColor(self.textColor)

  lg.setScissor(self.x, self.y, self.width, self.height)
  lg.print(self.text, self.offsetX, self.y + self.paddingTop)
  lg.setScissor()

  if(self.focus) then
    lg.setColor(self.cursor.color)
    lg.print("|", self.cursor.x, self.cursor.y)

    lg.setColor(self.focusBorderColor)
    lg.setLineWidth(self.focusBorderWeight)
    lg.rectangle("line", self.x, self.y, self.width, self.height)
  else
    lg.setColor(self.borderColor)
    lg.setLineWidth(self.borderWeight)
    lg.rectangle("line", self.x, self.y, self.width, self.height)
  end

  lg.pop()
end

function textbox:getInput(key)
  if(not self.focus) then return end

  if(self.textLen >= self.maxinput) then return end

  local cursor = self.cursor

  local textBefore = sub(self.text, 1, cursor.position)
  local textAfter = sub(self.text, cursor.position + 1, self.textLen)

  self.text = concat{textBefore, key, textAfter}
  self.textLen = len(self.text)

  cursor.position = cursor.position + 1
end

local function intersects(x, y, box)
  local intersectsX = (x >= box.x and x <= box.x + box.width)
  local intersectsY = (y >= box.y and y <= box.y + box.height)

  return intersectsX and intersectsY
end

local function map(x, min, max, min1, max2)
  local percentRange = (x - min) / (max - min)
  return (percentRange * (max2 - min1)) + min1
end

function textbox:mousepressed(x, y, button)
  if(button ~= 1) then return end

  local oldFocus = self.focus
  self.focus = intersects(x, y, self)

  if(self.focus) then
    local minX = self.offsetX
    local maxX = self.offsetX + self.font:getWidth(self.text)
    local normalize = map(x, minX, maxX, 0, self.textLen)

    self.cursor.position = max(min(floor(normalize), self.textLen), 0)
    self.cursor.alphaTimer = ((not oldFocus) and 0) or self.cursor.alphaTimer
  end
end

function textbox:keypressed(key)
  if(not self.focus) then return end

  local cursor = self.cursor

  if(key == "backspace") then
    local textBefore = sub(self.text, 1, cursor.position)
    local textAfter = sub(self.text, cursor.position + 1, self.textLen)

    local byteoffset = offset(textBefore, -1)

    if (byteoffset) then
      textBefore = sub(textBefore, 1, byteoffset - 1)
      self.text = concat{textBefore, textAfter}
      self.textLen = len(self.text)
      cursor.position = cursor.position - 1
    end
  end

  if(key == "left") then
    cursor.position = max(cursor.position - 1, 0)
  elseif(key == "right") then
    cursor.position = min(cursor.position + 1, self.textLen)
  end
end

function textbox:getText()
  return self.text
end

return textbox