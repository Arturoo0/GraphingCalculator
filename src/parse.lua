-- Author : Arturo Portelles
-- Desc : string to equation func

local environment = require("src/functions")

local tagTable = {"return function(x) return ", "" , " end"}
local concat = table.concat
local strLen = string.len

local function parse(funcStr)
  if (strLen(funcStr) <= 2) then return false end

  local funcStr = funcStr:gsub("%s+", "")
  funcStr = funcStr:lower()

  local subStr = funcStr:sub(1,2)
  if (subStr ~= "y=") then return false end

  funcStr = funcStr:sub(3)

  tagTable[2] = funcStr
  funcStr = concat(tagTable)

  funcStr = loadstring(funcStr)
  if(not funcStr) then return false end

  setfenv(funcStr, environment)

  local returnFunc = funcStr()

  local success, result = pcall(returnFunc, 3)

  if (not success) then return false end
  if (type(result) ~= "number") then return false end

  return returnFunc
end

return parse