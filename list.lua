-- Functions for manipulating list tables.
local M = {}

M._random = math.random

-- Returns the value of a random item in a list table.
function M.random_item(list_tbl)
    local random_index = M._random(1, #list_tbl)
    return list_tbl[random_index]
end

-- Filters the given list table in place.
function M.filter(fn, list)
    local j = 1
    local len = #list

    for i = 1, len do
        if fn(list[i], i, len) then
            if (i ~= j) then
                list[j] = list[i]
                list[i] = nil
            end
            j = j + 1
        else
            list[i] = nil
        end
    end
    return list
end

-- Returns the first value in the given list table where fn returns true.
function M.find(fn, list)
    for i = 1, #list do
        if fn(list[i]) then
            return list[i]
        end
    end
end

return M
