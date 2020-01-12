-- Author: Arturo Portelles
-- Pop up panel

local textbox = require("src/textbox")
local equation = require("src/equation")
local parser = require("src/parser")

local lg = love.graphics

local panel = {
  x = 0,
  y = 0,
  width = 300,
  height = 700,
  numInputs = 7,
  status = false,
  button = {
    x = 10,
    y = 10,
    width = 25,
    height = 25,
  },
  textboxes = {},
  equations = {},
}

function panel:load()
  for i = 1, self.numInputs do
    self.textboxes[i] = textbox:new {
      width = self.width,
      height = 100,
      y = (i - 1) * 100,
      text = "y = ",
      font = lg.newFont(18)
    }
    self.equations[i] = equation:new()
  end

  self.button.icon = {}

  local icon = self.button.icon

  icon.img = lg.newImage("img/open.png")
  icon.scaleX = self.button.width / icon.img:getWidth()
  icon.scaleY = self.button.height / icon.img:getHeight()
end

function panel:update(dt)
  if(not self.status) then return end

  for i = 1, self.numInputs do
    self.textboxes[i]:update(dt)
  end
end

function panel:draw()
  local button = self.button

  if (self.status) then
    color:set("white-light")
    lg.rectangle("fill", 0, 0, self.width, self.height)
    for i = 1, self.numInputs do
      self.textboxes[i]:draw()
    end
  else
    color:set("black-light")
    lg.draw(button.icon.img, button.x, button.y, 0, button.icon.scaleX, button.icon.scaleY)
  end
end

function panel:keypressed(key)
  if(not self.status) then return end

  for i = 1, self.numInputs do
    self.textboxes[i]:keypressed(key)
  end
end

function panel:textinput(key)
  if(not self.status) then return end

  for i = 1, self.numInputs do
    self.textboxes[i]:getInput(key)
  end
end

function panel:mousepressed(x, y, button)
  if(not self.status) then return end

  for i = 1, self.numInputs do
    self.textboxes[i]:mousepressed(x, y, button)
  end
end

local function intersects(x, y, box)
  local intersectsX = (x >= box.x and x <= (box.x + box.width))
  local intersectsY = (y >= box.y and y <= (box.y + box.height))

  return intersectsX and intersectsY
end

function panel:mousereleased(x, y, button)
  if(button ~= 1) then return end

  local target = (self.status) and self or self.button

  self.status = intersects(x, y, target)
end

function panel:getEquations()
  return self.equations
end

return panel
