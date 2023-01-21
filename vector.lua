local sqrt = math.sqrt
local expect = require 'lib.expect'
local struct = require("lib.struct")

local M = {}

M.Vector2 = struct('Vector2', function(self, x, y)
    expect.number(x)
    expect.number(y)

    self.x = x
    self.y = y
end)

function M.Vector2:magnitude()
    return sqrt(self.x ^ 2 + self.y ^ 2)
end

-- Ensure magnitude is not greater than the max.
-- Uses magnitude 1 if no max is given.
function M.Vector2:clamp(max)
    max = max or 1

    local magnitude = self:magnitude()

    if magnitude > max then
        return M.Vector2(self.x * max / magnitude, self.y * max / magnitude)
    end

    return M.Vector2(self.x, self.y)
end

function M.Vector2:add(other)
    return M.Vector2(self.x + other.x, self.y + other.y)
end

function M.Vector2:subtract(other)
    return M.Vector2(self.x - other.x, self.y - other.y)
end

function M.Vector2:multiply(number)
    return M.Vector2(self.x * number, self.y * number)
end

function M.Vector2:divide(number)
    return M.Vector2(self.x / number, self.y / number)
end

function M.Vector2:copy()
    return M.Vector2(self.x, self.y)
end

function M.Vector2:rotate(radians)
    return M.Vector2(self.x * math.cos(radians) - self.y * math.sin(radians), self.x * math.sin(radians) + self.y * math.cos(radians))
end

return M.Vector2
