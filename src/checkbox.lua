-- Author: Bruce Berrios
-- Description: A checkbox class

local lg = love.graphics

local checkbox = {}

checkbox.__index = checkbox

function checkbox:new(properties)
  local properties = properties or {}

  local cb = {
    x = properties.x or 0,
    y = properties.y or 0,
    width = properties.width or 50,
    height = properties.height or 50,
    borderColor = properties.borderColor or {0, 0, 0, 1},
    borderWeight = properties.borderWeight or 1,
    fillColor = properties.fillColor or {0, 0, 1, 1},
    roundness = properties.roundness or 5,
    value = properties.value or false,
  }

  if(properties.img) then
    cb.icon = {
      img = properties.img,
      imgColor = properties.imgColor or {1, 1, 1, 1},
      scaleX = (cb.width / properties.img:getWidth()) * 0.75,
      scaleY = (cb.height / properties.img:getHeight()) * 0.75,
    }

    cb.icon.width = properties.img:getWidth() * cb.icon.scaleX
    cb.icon.height = properties.img:getHeight() * cb.icon.scaleY
  end

  if(properties.text) then
    cb.caption = {
      text = properties.text or "Hello World!",
      color = properties.textColor or {0, 0, 0},
      font = properties.font or lg.getFont(),
      marginLeft = properties.textMarginLeft or 12,
      marginTop = properties.textMarginTop or 2,
    }

  end

  return setmetatable(cb, checkbox)
end

local function intersects(x, y, box)
  local intersectsX = (x >= box.x and x <= box.x + box.width)
  local intersectsY = (y >= box.y and y <= box.y + box.height)

  return intersectsX and intersectsY
end

function checkbox:draw()
  lg.push("all")

  if(self.value) then
    lg.setColor(self.fillColor)
    lg.rectangle("fill", self.x, self.y, self.width, self.height, self.roundness, self.roundness)

    if(self.icon) then
      lg.setColor(self.icon.imgColor)

      local centerX = self.x + ((self.width * 0.5) - (self.icon.width * 0.5))
      local centerY = self.y + ((self.height * 0.5) - (self.icon.height* 0.5))

      lg.draw(self.icon.img, centerX, centerY, 0, self.icon.scaleX, self.icon.scaleY)
    end
  end

  lg.setColor(self.borderColor)
  lg.setLineWidth(self.borderWeight)
  lg.rectangle("line", self.x, self.y, self.width, self.height, self.roundness, self.roundness)

  if(self.caption) then
    lg.setColor(self.caption.color)
    lg.setFont(self.caption.font)
    lg.print(self.caption.text, self.x + self.width + self.caption.marginLeft, self.y + self.caption.marginTop)
  end

  lg.pop()
end

function checkbox:getValue()
  return self.value
end

function checkbox:mousereleased(x, y, button)
  if(button ~= 1) then return end

  if(intersects(x, y, self)) then
    self.value = not self.value
  end
end

return checkbox