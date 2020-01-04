
local lg = love.graphics
local insert = table.insert

local equation = {}

equation.__index = equation

function equation:new(properties)
  local eq = {
    coords = {},
    func = properties.func or function(x) return x^2 end,
    grid = properties.grid,
    color = properties.color or {1, 0, 0, 1}
  }

  eq.canvas = lg.newCanvas(eq.grid.width, eq.grid.height)

  for x = -50, 50, 0.001 do
    insert(eq.coords, ((eq.grid.tileSize / 2) * x) + eq.grid.halfWidth)
    insert(eq.coords, -((eq.grid.tileSize / 2) * eq.func(x)) + eq.grid.halfHeight)
  end

  eq.canvas:renderTo(function()
    lg.clear()
    lg.setPointSize(4)
    lg.setColor(eq.color)
    lg.points(eq.coords)
  end)

  return setmetatable(eq, equation)
end

function equation:draw()
  lg.setColor(1, 1, 1, 1)
  lg.setBlendMode("alpha", "premultiplied")
  lg.draw(self.canvas)
  lg.setBlendMode("alpha")
end

function equation:getCoords()
  return self.coords
end

return equation