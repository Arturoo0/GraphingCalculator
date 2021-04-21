local textbox = require('src/textbox')
local checkbox = require('src/checkbox')
local equation = require('src/equation')
local parse = require('src/parse')
local intersects = require('src/utils').intersects

local lg = love.graphics

local EQUATION_COLORS = {
  'green-light',
  'blue-light',
  'yellow-light',
  'orange-light',
  'red-light',
  'purple-light',
  'turquoise-light'
}

local INPUT_BORDER_COLORS = {
  [true] = 'blue-light',
  [false] = 'red-light',
}

local panel = {
  x = 0,
  y = 0,
  width = 300,
  height = 700,
  numInputs = 7,
  visible = false,
  button = {
    x = 10,
    y = 10,
    width = 25,
    height = 25,
  },
  textboxes = {},
  equations = {},
  checkboxes = {},
  areas = {},
}

function panel:load()
  local checkboxImg = lg.newImage('img/check-solid.png')
  for i = 1, self.numInputs do
    self.equations[i] = equation:new {
      color = color:get(EQUATION_COLORS[i])
    }
    self.textboxes[i] = textbox:new {
      width = self.width,
      height = 100,
      y = (i - 1) * 100,
      text = 'y = ',
      font = lg.newFont(18),
      onChange = function(self)
        local validFunction = parse(self:getText())
        if (validFunction) then
          self.target:recomputeCoords(validFunction)
        else
          self.target.valid = false
        end
        panel.areas = grid:renderAndGetAreas(panel.equations)
      end,
      target = self.equations[i],
    }
    self.checkboxes[i] = checkbox:new {
      x = 272,
      y = (i - 1) * 100 + 8,
      width = 20,
      height = 20,
      img = checkboxImg,
      fillColor = color:get('green-light'),
      fillColorHover = color:get('green-dark'),
      onChange = function(self)
        self.target.showIntegral = self:getValue()
        panel.areas = grid:renderAndGetAreas(panel.equations)
      end,
      target = self.equations[i],
    }
  end
  self.button.icon = {}
  local icon = self.button.icon
  icon.img = lg.newImage('img/open.png')
  icon.scaleX = self.button.width / icon.img:getWidth()
  icon.scaleY = self.button.height / icon.img:getHeight()
end

function panel:update(dt)
  if (not self.visible) then return end
  for i = 1, self.numInputs do
    self.textboxes[i]:update(dt)
    self.checkboxes[i]:update(dt)
  end
end

function panel:draw()
  if (not self.visible) then
    local button = self.button
    color:set('black-light')
    lg.draw(button.icon.img, button.x, button.y, 0, button.icon.scaleX, button.icon.scaleY)
    return
  end
  color:set('white-light')
  lg.rectangle('fill', 0, 0, self.width, self.height)
  local isValid = false
  for i = 1, self.numInputs do
    isValid = self.equations[i].valid
    self.textboxes[i].focusBorderColor = color:get(INPUT_BORDER_COLORS[isValid], 0.75)
    self.textboxes[i]:draw()
    self.checkboxes[i]:draw()
    if (self.areas[i]) then
      color:set(EQUATION_COLORS[i])
      lg.print('= ' .. self.areas[i], self.textboxes[i].x, self.textboxes[i].y)
    end
  end
end

function panel:keypressed(key)
  if (not self.visible) then return end
  for i = 1, self.numInputs do
    self.textboxes[i]:keypressed(key)
  end
end

function panel:textinput(key)
  if (not self.visible) then return end
  for i = 1, self.numInputs do
    self.textboxes[i]:getInput(key)
  end
end

function panel:mousepressed(x, y, button)
  if (not self.visible) then return end
  for i = 1, self.numInputs do
    self.textboxes[i]:mousepressed(x, y, button)
  end
end

function panel:mousereleased(x, y, button)
  if (button ~= 1) then return end
  local target = (self.visible) and self or self.button
  self.visible = intersects(x, y, target)
  if (not self.visible) then return end
  for _, cb in ipairs(self.checkboxes) do
    cb:mousereleased(x, y, button)
  end
end

function panel:getEquations()
  return self.equations
end

return panel
