local expect = require 'lib.expect'

-- Struct-like object that prevents reading and writing values after
-- initializing. No inheritance, no weird stuff.
local function struct(struct_t, init)
    expect.string(struct_t)
    expect.fn(init)

    local struct_metatable = {}

    struct_metatable.__index = struct_metatable

    struct_metatable.__STRUCT_TYPE = struct_t
    struct_metatable.__is_instance = function(table)
        if type(table) ~= 'table' then
            return false
        end

        return table.__STRUCT_TYPE == struct_t
    end
    struct_metatable.expect = function(value)
        assert(type(value) == 'table' and value.__STRUCT_TYPE == struct_t, 'expected instance of ' .. struct_t)
        return value
    end

    local obj_metatable = {}
    obj_metatable.__call = function(_, ...)
        local obj = {}
        setmetatable(obj, struct_metatable)
        init(obj, ...)
        return obj
    end

    obj_metatable.__index = function(_, k)
        local message = struct_t .. ": Unknown property '"..tostring(k).."'. Reading unset properties from this table is disabled."
        error(message)
    end

    -- TODO: enable this at some point after defining methods?
    -- obj_metatable.__newindex = function(_, k)
    --     local message = struct_t .. ": Unknown property '"..tostring(k).."'. Writing unset properties to this table is disabled."
    --     error(message)
    -- end

    setmetatable(struct_metatable, obj_metatable)
    return struct_metatable
end

return struct
