-- Author : Arturo Portelles
-- Desc : string to equation func
local environment = require("src/functions")

local parser = {}

local tagTable = {"return function(x) return", "" , " end"}
local concat = table.concat
local strLen = string.len

function parser.parse(funcStr)

  local funcStr = funcStr:gsub("%s+", "")
  funcStr = funcStr:lower()

  local subStr = funcStr:sub(1,2)

  if (strLen(funcStr) <= 2 and subStr ~= "y=") then
    return false
  end

  if (subStr == "y=") then
    funcStr = funcStr:sub(3)
  end

  tagTable[2] = funcStr
  funcStr = concat(tagTable)

  funcStr = loadstring(funcStr)
  setfenv(funcStr, environment)

  local returnFunc = funcStr()

  if (pcall(returnFunc, 3) == false) then return false end
  if (type(returnFunc(3)) ~= "number") then return false end

  return returnFunc
end

return parser
