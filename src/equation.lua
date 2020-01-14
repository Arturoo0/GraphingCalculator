-- Author: Bruce Berrios
-- Description: An equation class

local lg = love.graphics

local grid = require("src/grid")

local NUM_COORDS = 200002
local set = rawset

local equation = {}
equation.__index = equation

function equation:new(properties)
  local properties = properties or {}

  local eq = {
    coords = {},
    func = properties.func or function(x) return x end,
    color = properties.color or {1, 0, 0, 1},
    valid = false,
    showIntegral = false,
  }

  return setmetatable(eq, equation)
end

function equation:recomputeCoords(func)
  for i = 1, NUM_COORDS do self.coords[i] = nil end

  self.valid = true
  self.func = func

  local index = 1

  for x = -50, 50, 0.001 do
    set(self.coords, index, ((grid.tileSize / 2) * x) + grid.halfWidth)
    set(self.coords, index + 1, -((grid.tileSize / 2) * self.func(x)) + grid.halfHeight)

    index = index + 2
  end
end

function equation:getCoords()
  return self.coords
end

function equation:getRenderComponents()
  return self.coords, self.color
end

function equation:isValid()
  return self.valid
end

function equation:drawIntegral()
  return self.showIntegral
end

return equation
