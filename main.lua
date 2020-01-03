--
-- local lg = love.graphics
--
-- WIDTH = lg:getWidth()
-- HEIGHT = lg:getHeight()
-- HALF_WIDTH = WIDTH * 0.5
-- HALF_HEIGHT = HEIGHT * 0.5
--
-- color = require("src/color")
-- local grid = require("src/grid")
-- local camera = require("src/camera")
--
-- local graphCanvas = lg.newCanvas(grid.width, grid.height)
--
-- function love.load()
--
--   color:init {
--     ["black-light"] = "#353b48",
--     ["black-dark"] = "#2f3640",
--     ["green-light"] = "#2ecc71",
--     ["green-dark"] = "#27ae60",
--     ["blue-light"] = "#3498db",
--     ["blue-dark"] = "#2980b9",
--     ["yellow-light"] = "#f1c40f",
--     ["yellow-dark"] = "#f39c12",
--     ["orange-light"] = "#e67e22",
--     ["orange-dark"] = "#d35400",
--     ["red-light"] = "#e74c3c",
--     ["red-dark"] = "#c0392b",
--     ["purple-light"] = "#9b59b6",
--     ["purple-dark"] = "#8e44ad",
--     ["white-light"] = "#ecf0f1",
--     ["white-dark"] = "#bdc3c7",
--     ["turquoise-light"] = "#1abc9c",
--     ["turquoise-dark"] = "#16a085"
--   }
--
--   camera:setPosition(grid.halfWidth - HALF_WIDTH, grid.halfHeight - HALF_HEIGHT)
--
--   camera:setBoundaries {
--     minX = 0,
--     minY = 0,
--     maxX = grid.width - WIDTH,
--     maxY = grid.height - HEIGHT
--   }
--
--   color:setBackground("white-light")
--
--   local coords = {}
--
--   local function func(x)
--     return x^3
--   end
--
--   for x = -50, 50, 0.001 do
--     coords[#coords + 1] = ((grid.tileSize / 2) * x) + grid.halfWidth
--     coords[#coords + 1] = -((grid.tileSize / 2) * func(x)) + grid.halfHeight
--   end
--
--   graphCanvas:renderTo(function()
--     lg.clear()
--     lg.setPointSize(6)
--     color:set("purple-dark")
--     lg.points(coords)
--   end)
-- end
--
-- function love.update(dt)
--   camera:update(dt)
-- end
--
-- local coords = {}
--
-- function love.draw()
--   camera:set()
--
--   grid:draw()
--
--   color:set("white-light")
--
--   lg.setBlendMode("alpha", "premultiplied")
--   lg.draw(graphCanvas)
--   lg.setBlendMode("alpha")
--
--   camera:unset()
--
--   color:set("black-dark")
--   lg.print(love.timer.getFPS())
-- end


local textbox = require("src/textbox")

local myTB = textbox:new{
  y = 150,
  font = love.graphics.newFont(32)
}

function love.load(arg)
  love.keyboard.setKeyRepeat(true)
end

function love.update(dt)
  myTB:update(dt)
end

function love.textinput(key)
  myTB:getInput(key)
end

function love.keypressed(key)
  myTB:keypressed(key)
end

function love.draw()
  myTB:draw()
end
