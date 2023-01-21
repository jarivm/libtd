local test = require('lib.test')

local Vector2 = require("lib.vector")
local expect = require('lib.expect')
local struct = require("lib.struct")

local M = {}

M.Rect = struct('Rect', function(self, position, width, height, is_centered)
    Vector2.expect(position)
    expect.positive_number(width)
    expect.positive_number(height)

    self.pos = position
    self.width = width
    self.height = height

    if is_centered then
        self.pos.x = self.pos.x - self.width / 2
        self.pos.y = self.pos.y - self.height / 2
    end
end)

function M.Rect:center()
    return Vector2(self.pos.x + self.width / 2, self.pos.y + self.height / 2)
end

function M.Rect:center_top()
    return Vector2(self.pos.x + self.width / 2, self.pos.y)
end

function M.Rect:center_left()
    return Vector2(self.pos.x, self.pos.y + self.height / 2)
end

function M.Rect:center_bottom()
    return Vector2(self.pos.x + self.width / 2, self.pos.y + self.height)
end

function M.Rect:with_padding(padding)
    local padded_width = self.width + padding * 2
    local padded_height = self.height + padding * 2

    return M.Rect(self.pos, padded_width, padded_height)
end

function M.Rect:padded(padding)
    local padded_pos = self.pos:add(Vector2(padding, padding))
    local padded_width = self.width - padding * 2
    local padded_height = self.height - padding * 2

    return M.Rect(padded_pos, padded_width, padded_height)
end

-- Returns whether the Rects overlap or touch.
function M.Rect:overlaps(other)
    return self.pos.x + self.width >= other.pos.x
        and self.pos.x <= other.pos.x + other.width
        and self.pos.y + self.height >= other.pos.y
        and self.pos.y <= other.pos.y + other.height
end

function M.Rect:contains(pos)
    return pos.x >= self.pos.x
        and pos.x <= self.pos.x + self.width
        and pos.y >= self.pos.y
        and pos.y <= self.pos.y + self.height
end

function M.Rect:copy()
    return M.Rect(self.pos:copy(), self.width, self.height)
end

test.it('overlaps the same Rect position and dimensions', function()
    local a = M.Rect(Vector2(0, 0), 16, 16)
    local b = M.Rect(Vector2(0, 0), 16, 16)
    assert(a:overlaps(b))
    assert(b:overlaps(a))
end)

test.it('overlaps if touching in any direction, but not more than that', function()
    local a = M.Rect(Vector2(-16, -16), 16, 16)
    local b = M.Rect(Vector2(0, 0), 16, 16)
    assert(a:overlaps(b))
    assert(b:overlaps(a))

    a = M.Rect(Vector2(-16, -16), 16, 16)
    b = M.Rect(Vector2(1, 1), 16, 16)
    assert(not a:overlaps(b))
    assert(not b:overlaps(a))
end)

test.it('contains vectors', function()
    local a = M.Rect(Vector2(0, 0), 16, 16)
    assert(not a:contains(Vector2(-1, -1)))
    assert(a:contains(Vector2(0, 0)))
    assert(not a:contains(Vector2(17, 17)))
    assert(a:contains(Vector2(16, 16)))
end)

return M.Rect
