-- Author: Arturo Portelles
-- Pop up panel

local textbox = require("src/textbox")
local equation = require("src/equation")

local lg = love.graphics

local panel = {
  x = 0,
  y = 0,
  width = 300,
  height = 300,
  status = false,
  buttonSize = 20,
  buttonX = 5,
  buttonY = 5,
  textboxes = {},
  equations = {}
}

function panel:load()
  for i = 1, 3 do
    self.textboxes[i] = textbox:new {
      width = self.width,
      height = 100,
      y = (i - 1) * 100,
      font = lg.newFont(32)
    }
  end

  for i = 1, 3 do
    self.equations[i] = equation:new()
  end
end

function panel:update(dt)
  if(self.status) then
    for i = 1, #self.textboxes do
      self.textboxes[i]:update(dt)
    end
  end
end

function panel:draw()
  if (self.status) then
    color:set("white-light")
    lg.rectangle("fill", 0, 0, self.width, self.height)
    for i = 1, #self.textboxes do
      self.textboxes[i]:draw()
    end
  else
    color:set("black-light")
    lg.rectangle("fill", self.buttonX, self.buttonY, self.buttonSize, self.buttonSize)
  end
end

function panel:keypressed(key)
  if(not self.status) then return end
  for i = 1, #self.textboxes do
    self.textboxes[i]:keypressed(key)
  end
end

function panel:textinput(key)
  if(not self.status) then return end
  for i = 1, #self.textboxes do
    self.textboxes[i]:getInput(key)
  end
end

function panel:mousepressed(x, y, button)
  if(not self.status) then return end
  for i = 1, #self.textboxes do
    self.textboxes[i]:mousepressed(x, y, button)
  end
end

function panel:mousereleased(x, y, button)
  -- saves reused expressions
  local intersectsX = (x >= self.buttonX and x <= (self.buttonX + self.buttonSize))
  local intersectsY = (y >= self.buttonY and y <= (self.buttonY + self.buttonSize))

  if (intersectsX and intersectsY) then
    if (button == 1 and self.status == false) then
      self.status = true
    end
  end

  intersectsX = ((x >= self.x and x <= (self.x + self.width)))
  intersectsY = ((y >= self.y and y <= (self.y + self.height)))

  if (self.status) then
    if (not (intersectsX and intersectsY)) then
      self.status = false
    end
  end
end

return panel