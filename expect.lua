local M = {}

function M.table(value)
    assert(type(value) == 'table', 'expected string')
    return value
end

function M.string(value)
    assert(type(value) == 'string', 'expected string')
    return value
end

function M.number(value)
    assert(type(value) == 'number', 'expected number')
    return value
end

function M.positive_number(value)
    assert(type(value) == 'number' and value >= 0, 'expected positive number')
    return value
end

function M.fn(value)
    assert(type(value) == 'function', 'expected function')
    return value
end

function M.non_nil(value)
    assert(type(value) ~= 'nil', 'expected non-nil value')
    return value
end

return M
