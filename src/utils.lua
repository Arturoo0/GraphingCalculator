local utils = {}

utils.intersects = function(x, y, box)
    local intersectsX = (x >= box.x and x <= box.x + box.width)
    local intersectsY = (y >= box.y and y <= box.y + box.height)
    return intersectsX and intersectsY
end

return utils
