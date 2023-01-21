
local M = {}

local function pretty_print(value, level)
  if type(value) == 'table' then
      local s = '{\n'
      for key, value in pairs(value) do
         if type(key) ~= 'number' then key = '"'..tostring(key)..'"' end
         s = s .. string.rep('\t', level) .. '['..key..'] = ' .. pretty_print(value, level + 1) .. ',\n'
      end
      return s .. string.rep('\t', level - 1) .. '}'
   elseif type(value) == 'string' then
       return '"' .. value .. '"'
   else
      return tostring(value)
  end
end

function M.log(...)
    local args = {...}
    for i, arg in ipairs(args) do
        args[i] = pretty_print(arg, 1)
    end

    print(unpack(args))
end

_G.log = M.log

return M
