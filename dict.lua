local test = require('lib.test')

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

test.it("lists all keys", function()
    local person = {
        name = "Jan",
        age = 23
    }

    local keys = M.keys(person)

    assert(#keys == 2)
end)

test.it("lists all values", function()
    local person = {
        name = "Jan",
        age = 23
    }

    local values = M.values(person)

    assert(#values == 2)
end)

return M
