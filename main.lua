local lg = love.graphics

local WIDTH = lg:getWidth()
local HEIGHT = lg:getHeight()
local HALF_WIDTH = WIDTH * 0.5
local HALF_HEIGHT = HEIGHT * 0.5

color = require('src/color')
grid = require('src/grid')
local panel = require('src/panel')
local camera = require('src/camera')

function love.load()
  love.keyboard.setKeyRepeat(true)
  color:init(require('src/colors'))
  panel:load()
  grid:load()
  camera:setPosition(grid.halfWidth - HALF_WIDTH, grid.halfHeight - HALF_HEIGHT)
  camera:setBoundaries {
    minX = 0,
    minY = 0,
    maxX = grid.width,
    maxY = grid.height,
  }
  color:setBackground('white-light')
end

function love.update(dt)
  if (not panel.visible) then
    camera:update(dt)
  end
  panel:update(dt)
end

local coords = {}

function love.draw()
  camera:set()
  grid:draw()
  camera:unset()
  panel:draw()
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

function love.wheelmoved(x, y)
  camera:wheelmoved(x, y)
end
