
-- Author: Arturo Portelles
-- Pop up panel

local lg = love.graphics

panel = {
  width = 300,
  height = 600,
  status = false,
  buttonSize = 20,
  buttonX = 5,
  buttonY = 5,
  X = 0,
  Y = 0
}

function panel:mousereleased(x,y,button)

  -- saves reused expressions
  local Xcondition = (x >= self.buttonX and x <= (self.buttonX + self.buttonSize))
  local Ycondition = (y >= self.buttonY and y <= (self.buttonY + self.buttonSize))

  if (Xcondition and Ycondition) then
    if (button == 1 and self.status == false) then
      self.status = true
    end
  end

  Xcondition = ((x >= self.X and x <= (self.X + self.width)))
  Ycondition = ((y >= self.Y and y <= (self.Y + self.height)))

  if (self.status == true) then
    if (not (Xcondition and Ycondition)) then
      self.status = false
    end
  end
end

function panel:draw()

  if (self.status == true) then
    color:set("white-light")
    lg.rectangle("fill", 0, 0, self.width, self.height)
  else
    color:set("black-light")
    lg.rectangle("fill", self.buttonX, self.buttonY, self.buttonSize, self.buttonSize)
  end

end