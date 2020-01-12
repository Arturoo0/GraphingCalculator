-- Author : Arturo Portelles
-- Desc : string to equation func
local environment = require("src/functions")

local parser = {}

local tagTable = {"return function(x) return ", "" , " end"}
local concat = table.concat
local strLen = string.len

function parser.parse(funcStr)
  if (strLen(funcStr) <= 2) then return false end

  local funcStr = funcStr:gsub("%s+", "")
  funcStr = funcStr:lower()

  local subStr = funcStr:sub(1,2)
  if (subStr ~= "y=") then return false end

  funcStr = funcStr:sub(3)

  tagTable[2] = funcStr
  funcStr = concat(tagTable)

  funcStr = loadstring(funcStr)
  setfenv(funcStr, environment)

  local returnFunc = funcStr()

  if (not pcall(returnFunc, 3)) then return false end
  if (type(returnFunc(3)) ~= "number") then return false end

  return returnFunc
end

return parser
