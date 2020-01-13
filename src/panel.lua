-- Author: Arturo Portelles
-- Pop up panel

local textbox = require("src/textbox")
local equation = require("src/equation")
local parse = require("src/parse")

local lg = love.graphics

local EQUATION_COLORS = {
  "green-light",
  "blue-light",
  "yellow-light",
  "orange-light",
  "red-light",
  "purple-light",
  "turquoise-light"
}

local INPUT_BORDER_COLORS = {
  [true] = "blue-light",
  [false] = "red-light",
}

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
  previousInputs = {},
  renderKeys = {},
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
    self.previousInputs[i] = self.textboxes[i]:getText()

    self.equations[i] = equation:new {
      color = color:get(EQUATION_COLORS[i])
    }

    self.renderKeys[i] = false
  end

  self.button.icon = {}

  local icon = self.button.icon

  icon.img = lg.newImage("img/open.png")
  icon.scaleX = self.button.width / icon.img:getWidth()
  icon.scaleY = self.button.height / icon.img:getHeight()
end

function panel:update(dt)
  if(not self.status) then return end

  local needRender = false

  for i = 1, self.numInputs do
    self.textboxes[i]:update(dt)

    local textboxInput = self.textboxes[i]:getText()

    if (textboxInput ~= self.previousInputs[i]) then
      needRender = true
      self.renderKeys[i] = true
    end
  end

  if(needRender) then
    self:renderToGrid()
  end
end

function panel:renderToGrid()
  local callRender = false

  for i, v in ipairs(self.renderKeys) do
    if(v) then
      local textboxInput = self.textboxes[i]:getText()
      local func = parse(textboxInput)

      if(func) then
        self.equations[i]:recomputeCoords(func)
        self.previousInputs[i] = textboxInput
        self.renderKeys[i] = false
        callRender = true
      else
        self.equations[i].valid = false
      end
    end
  end

  if(callRender) then
    grid:render(self.equations)
  end
end

function panel:draw()
  local button = self.button

  if (self.status) then
    color:set("white-light")
    lg.rectangle("fill", 0, 0, self.width, self.height)

    local isValid = false

    for i = 1, self.numInputs do
      isValid = self.equations[i].valid
      self.textboxes[i].focusBorderColor = color:get(INPUT_BORDER_COLORS[isValid], 0.75)

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
