local test = require('lib.test')

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
    local len = #list
    for i = 1, len do
        if fn(list[i], i, len) then
            return list[i]
        end
    end
end

function M.map(fn, list)
    local result = {}

    local len = #list
    for i = 1, len do
        result[i] = fn(list[i], i, len)
    end

    return result
end

test.it("filters a list", function()
    local persons = {
        {name = 'Piet', age = 21},
        {name = 'Jan', age = 40},
        {name = 'Jaap', age = 5}
    }

    M.filter(function(person) return person.age >= 21 end, persons)
    assert(#persons == 2)
    assert(persons[1].name == 'Piet')
    assert(persons[2].name == 'Jan')
end)

test.it("finds and item in a list", function()
    local persons = {{name = 'Piet'}, {name = 'Jan'}, {name = 'Jaap'}}

    local person = M.find(function(person) return person.name == 'Jan' end, persons)
    assert(person.name == 'Jan')

    local non_existent_person = M.find(function(person) return person.name == 'Kees' end, persons)
    assert(non_existent_person == nil)
end)

test.it("maps a list", function()
    local persons = {{name = 'Piet'}, {name = 'Jan'}, {name = 'Jaap'}}

    local names = M.map(function(person) return person.name end, persons)

    assert(#names == #persons)
    assert(names[1] == 'Piet')
    assert(names[2] == 'Jan')
    assert(names[3] == 'Jaap')
end)

return M
