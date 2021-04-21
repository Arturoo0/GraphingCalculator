local log = math.log

function logBase(base)
  return function(x) 
    return log(x) / log(base)
  end
end

local environment = {
  abs = math.abs,
  acos = math.acos,
  asin = math.asin,
  atan = math.atan,
  ceil = math.ceil,
  cos = math.cos,
  deg = math.deg,
  exp = math.exp,
  floor = math.floor,
  fmod = math.fmod,
  modf = math.modf,
  pi = math.pi,
  rad = math.rad,
  sin = math.sin,
  sqrt = math.sqrt,
  tan = math.tan,
  max = math.max,
  min = math.min,
  ln = log,
  log = logBase(10),
  log2 = logBase(2),
  e = math.exp(1),
  random = math.random,
  cosh = math.cosh,
  pow = math.pow,
  tanh = math.tanh,
}

return environment
