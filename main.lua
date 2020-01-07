local lg = love.graphics

local WIDTH = lg:getWidth()
local HEIGHT = lg:getHeight()
local HALF_WIDTH = WIDTH * 0.5
local HALF_HEIGHT = HEIGHT * 0.5

color = require("src/color")
local panel = require("src/panel")
local grid = require("src/grid")
local camera = require("src/camera")
local equation = require("src/equation")

local cosine;

function love.load()
  love.keyboard.setKeyRepeat(true)

  panel:load()

  color:init(require("src/colors"))

  camera:setPosition(grid.halfWidth - HALF_WIDTH, grid.halfHeight - HALF_HEIGHT)

  camera:setBoundaries {
    minX = 0,
    minY = 0,
    maxX = grid.width - WIDTH,
    maxY = grid.height - HEIGHT
  }

  cosine = equation:new {
    color = color:get("orange-light"),
    grid = grid,
    func = function(x)
      return math.cos(x)
    end
  }

  color:setBackground("white-light")
end


function love.update(dt)
  if(not panel.status) then
    camera:update(dt)
  end
  panel:update(dt)
end

local coords = {}

function love.draw()
  camera:set()

  grid:draw()
  cosine:draw()

  camera:unset()

  panel:draw()

  color:set("black-dark")
  lg.print(love.timer.getFPS(), 676)
end

function love.mousereleased(x, y, button)
  panel:mousereleased(x, y, button)
end

function love.mousepressed(x, y, button)
  panel:mousepressed(x, y, button)
end

function love.keypressed(key)
  panel:keypressed(key)
end

function love.textinput(key)
  panel:textinput(key)
end
