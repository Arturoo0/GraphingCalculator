local lg = love.graphics
local sub, len, rep, match, tonum, tostr, unp = string.sub, string.len, string.rep, string.match, tonumber, tostring, unpack

local color = {
  colors = {}
}

local HEX_PATTERN = '(%x%x)(%x%x)(%x%x)(%x%x)'
local function parseHex(hexString)
  local newHex = tostr(hexString)
  newHex = (sub(newHex, 1, 1) == '#') and sub(newHex, 2, len(newHex)) or newHex
  if (tonum(newHex, 16) == nil) then return {1, 1, 1, 1} end
  newHex = (len(newHex) < 6) and newHex .. rep('0', 6 - len(newHex)) or newHex
  newHex = (len(newHex) < 8) and newHex .. rep('f', 8 - len(newHex)) or newHex
  local rgba = {match(newHex, HEX_PATTERN)}
  for i = 1, 4 do rgba[i] = tonum(rgba[i], 16) / 255 end
  return rgba
end

local function parseRGBA(rgba)
  local newRGBA = {}
  for i = 1, 4 do
    newRGBA[i] = (tonum(rgba[i])) or 1
    newRGBA[i] = (newRGBA[i] > 1) and (newRGBA[i] / 255) or newRGBA[i]
  end
  return newRGBA
end

function color:init(colors)
  local c = colors or {
    ['Red']   = {1, 0, 0, 1},
    ['Green'] = {0, 1, 0, 1},
    ['Blue']  = {0, 0, 1, 1}
  }
  for k, v in pairs(c) do
    self:add(k, v)
  end
end

function color:add(key, color)
  self.colors[key] = (type(color) == 'table') and parseRGBA(color) or parseHex(color)
end

function color:set(key, alpha)
  local r, g, b, a = unp(self.colors[key])
  a = alpha or a
  lg.setColor(r, g, b, a)
end

function color:setTable(table)
  local r, g, b, a = unp(table)
  lg.setColor(r, g, b, a)
end

function color:setBackground(key)
  lg.setBackgroundColor(self.colors[key])
end

function color:get(key, alpha)
  local a = alpha or 1
  local c = self.colors[key]
  c[4] = a
  return c
end

return color
