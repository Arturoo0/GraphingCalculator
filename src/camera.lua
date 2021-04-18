local lg, lm, lk = love.graphics, love.mouse, love.keyboard
local max, min = math.max, math.min

local camera = {
  x = 0,
  y = 0,
  speed = 500,
  velX = 0,
  velY = 0,
  scale = 1,
  maxZoom = 2,
  minZoom = 0.5,
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
  local wIsDown = lk.isDown('w')
  local aIsDown = lk.isDown('a')
  local sIsDown = lk.isDown('s')
  local dIsDown = lk.isDown('d')
  self.velY = (wIsDown) and -self.speed or 0
  self.velY = (sIsDown) and self.speed or self.velY
  self.velX = (aIsDown) and -self.speed or 0
  self.velX = (dIsDown) and self.speed or self.velX
end

function camera:update(dt)
  local mouseX, mouseY = lm.getPosition()
  if (lm.isDown(1)) then
    if (not self.wasClicked) then
      self.initialX = self.x
      self.initialY = self.y
      self.clickedX = mouseX
      self.clickedY = mouseY
      self.wasClicked = true
    end
    local dx = self.clickedX - mouseX
    local dy = self.clickedY - mouseY
    self.x = self.initialX + dx
    self.y = self.initialY + dy
  else
    self.wasClicked = false
    self:control(dt)
    self.x = self.x + self.velX * dt
    self.y = self.y + self.velY * dt
  end
  local scaledMaxX = self.boundaries.maxX - (lg.getWidth() / self.scale)
  local scaledMaxY = self.boundaries.maxY - (lg.getHeight() / self.scale)
  self.x = clamp(self.x, self.boundaries.minX, scaledMaxX)
  self.y = clamp(self.y, self.boundaries.minY, scaledMaxY)
end

function camera:set()
  lg.push()
  lg.scale(self.scale)
  lg.translate(-self.x, -self.y)
end

function camera:unset()
  lg.translate(self.x, self.y)
  lg.pop()
end

function camera:wheelmoved(x, y)
  local oldScale = self.scale
  self.scale = self.scale + (y * 0.016)
  self.scale = max(min(self.scale, self.maxZoom), self.minZoom)
  local mouseX, mouseY = lm.getPosition()
  local dx = (mouseX / self.scale) - (mouseX / oldScale)
  local dy = (mouseY / self.scale) - (mouseY / oldScale)
  self.x = self.x - dx
  self.y = self.y - dy
end

return camera
