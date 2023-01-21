-- Functions for manipulating dictionary tables.
local M = {}

-- Returns a list of keys in a dictionary table.
function M.keys(dict_table)
    local keys = {}
    for key, _ in pairs(dict_table) do
        keys[#keys + 1] = key
    end
    return keys
end

-- Returns a list of values in a dictionary table.
function M.values(dict_table)
    local values = {}
    for _, value in pairs(dict_table) do
        values[#values + 1] = value
    end
    return values
end

return M
