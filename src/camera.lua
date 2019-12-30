-- Author: Bruce Berrios
-- Description: Camera class

local lg, lm = love.graphics, love.mouse

local camera = {
  x = 0,
  y = 0,

  initialX = 0,
  initialY = 0,

  clickedX = 0,
  clickedY = 0,

  wasClicked = false,
}

function camera:setPosition(x, y)
  self.x, self.y = x, y
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

    self.x = self.initialX + dx
    self.y = self.initialY + dy

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