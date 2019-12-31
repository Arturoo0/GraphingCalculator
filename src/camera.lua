-- Author: Bruce Berrios
-- Description: Camera class

local lg, lm = love.graphics, love.mouse

local camera = {
  x = 0,
  y = 0,

  boundaries = {
    minX = 0,
    maxX = 0,
    minY = 0,
    maxY = 0,
  },

  initialX = 0,
  initialY = 0,

  clickedX = 0,
  clickedY = 0,

  wasClicked = false,
}

function camera:setBoundaries(bounds)
  self.boundaries.minX = bounds.minX or self.boundaries.minX
  self.boundaries.minY = bounds.minY or self.boundaries.minY
  self.boundaries.maxX = bounds.maxX or self.boundaries.maxX
  self.boundaries.maxY = bounds.maxY or self.boundaries.maxY
end

function camera:setPosition(x, y)
  self.x, self.y = x, y
end

local function clamp(x, min, max)

  x = (x < min) and min or x
  x = (x > max) and max or x

  return x
end

function camera:update(dt)

  local mouseX, mouseY = lm.getPosition()

  if(lm.isDown(1)) then

    if(not self.wasClicked) then
      self.initialX = self.x
      self.initialY = self.y
      self.clickedX = mouseX
      self.clickedY = mouseY

      self.wasClicked = true
    end

    local dx = (self.clickedX - mouseX)
    local dy = (self.clickedY - mouseY)

    self.x = self.initialX + dx * 1.5
    self.y = self.initialY + dy * 1.5

    self.x = clamp(self.x, self.boundaries.minX, self.boundaries.maxX)
    self.y = clamp(self.y, self.boundaries.minY, self.boundaries.maxY)

  else
    self.wasClicked = false
  end

end

function camera:set()
  lg.push()
  lg.translate(-self.x, -self.y)
end

function camera:unset()
  lg.translate(self.x, self.y)
  lg.pop()
end

return camera