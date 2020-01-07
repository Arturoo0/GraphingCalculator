
local lg = love.graphics
local insert = table.insert

local grid = require("src/grid")

local equation = {}

equation.__index = equation

function equation:new(properties)

  local properties = properties or {}

  local eq = {
    coords = {},
    func = properties.func or function(x) return x^2 end,
    color = properties.color or {1, 0, 0, 1}
  }

  for x = -50, 50, 0.001 do
    insert(eq.coords, ((grid.tileSize / 2) * x) + grid.halfWidth)
    insert(eq.coords, -((grid.tileSize / 2) * eq.func(x)) + grid.halfHeight)
  end

  return setmetatable(eq, equation)
end

function equation:getCoords()
  return self.coords
end

function equation:getRenderComponents()
  return self.coords, self.color
end

return equation
