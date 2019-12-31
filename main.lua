
local lg = love.graphics

WIDTH = lg:getWidth()
HEIGHT = lg:getHeight()
HALF_WIDTH = WIDTH * 0.5
HALF_HEIGHT = HEIGHT * 0.5

color = require("src/color")
local grid = require("src/grid")
local camera = require("src/camera")

function love.load()

  color:init {
    ["black-light"] = "#353b48",
    ["black-dark"] = "#2f3640",
    ["green-light"] = "#2ecc71",
    ["green-dark"] = "#27ae60",
    ["blue-light"] = "#3498db",
    ["blue-dark"] = "#2980b9",
    ["yellow-light"] = "#f1c40f",
    ["yellow-dark"] = "#f39c12",
    ["orange-light"] = "#e67e22",
    ["orange-dark"] = "#d35400",
    ["red-light"] = "#e74c3c",
    ["red-dark"] = "#c0392b",
    ["purple-light"] = "#9b59b6",
    ["purple-dark"] = "#8e44ad",
    ["white-light"] = "#ecf0f1",
    ["white-dark"] = "#bdc3c7",
    ["turquoise"] = "#1abc9c",
    ["turquoise-dark"] = "#16a085"
  }

  camera:setPosition(grid.halfWidth - HALF_WIDTH, grid.halfHeight - HALF_HEIGHT)

  camera:setBoundaries {
    minX = 0,
    minY = 0,
    maxX = grid.width - WIDTH,
    maxY = grid.height - HEIGHT
  }

  color:setBackground("white-light")
end

function love.update(dt)
  camera:update(dt)
end

function love.draw()
  camera:set()

  grid:draw()
  
  color:set("blue-dark")
  love.graphics.circle("fill", 875, 875, 12)

  camera:unset()
end
