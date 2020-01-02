-- Author: Bruce Berrios
-- Description: Camera class

local lg, lm, lk = love.graphics, love.mouse, love.keyboard

local camera = {
  x = 0,
  y = 0,

  speed = 500,

  velX = 0,
  velY = 0,

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

function camera:control(dt)

  local wIsDown = lk.isDown("w")
  local aIsDown = lk.isDown("a")
  local sIsDown = lk.isDown("s")
  local dIsDown = lk.isDown("d")

  self.velY = (wIsDown) and -self.speed or 0
  self.velY = (sIsDown) and self.speed or self.velY
  self.velX = (aIsDown) and -self.speed or 0
  self.velX = (dIsDown) and self.speed or self.velX

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
  else
    self.wasClicked = false

    self:control(dt)

    self.x = self.x + self.velX * dt
    self.y = self.y + self.velY * dt
  end

  self.x = clamp(self.x, self.boundaries.minX, self.boundaries.maxX)
  self.y = clamp(self.y, self.boundaries.minY, self.boundaries.maxY)

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