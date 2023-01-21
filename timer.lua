local max = math.max

local expect = require 'lib.expect'
local struct = require("lib.struct")

local M = {}

-- Timer that counts up until it reaches the duration.
M.Timer = struct('Timer', function(self, duration_in_seconds, initial_time)
    expect.positive_number(duration_in_seconds)

    self.duration = duration_in_seconds
    self.current = 0

    if type(initial_time) == 'boolean' then
        self:stop()
    elseif type(initial_time) == 'number' then
        expect.positive_number(initial_time)
        assert(initial_time <= self.duration)
        self.current = initial_time
    end
end)

M.Timer.UI_TIMEOUT = 0.2

function M.Timer:set_limit(duration)
    self.duration = duration
end

function M.Timer:stop()
    self.current = self.duration
end

function M.Timer:reset()
    local progress = self.current - self.duration
    while progress > self.duration do
        progress = progress - self.duration
    end
    self.current = max(progress, 0)
end

function M.Timer:update(dt)
    if not self:is_done() then
        self.current = self.current + dt
    end
end

function M.Timer:is_done()
    return self.current >= self.duration
end

-- Returns a number between 0 and 1 indicating the progress made.
function M.Timer:progress()
    return self.current / self.duration
end

-- Returns a number between 1 and 0 indicating the progress to make until the timer is done.
function M.Timer:progress_to_make()
    return 1 - (self.current / self.duration)
end

-- Returns whether the timer is done and resets it if done.
-- Useful in a game loop.
function M.Timer:loop()
    if self:is_done() then
        self:reset()
        return true
    end
    return false
end

return M.Timer
