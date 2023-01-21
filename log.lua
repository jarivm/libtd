local M = {}

local function pretty_print(obj, level)
  if type(obj) == 'table' then
      local s = '{ \n'
      for k, v in pairs(obj) do
         if type(k) ~= 'number' then k = '"'..tostring(k)..'"' end
         s = s .. string.rep('\t', level) .. '['..k..'] = ' .. pretty_print(v, level + 1) .. ',\n'
      end
      return s .. string.rep('\t', level - 1) .. '}'
   else
      return tostring(obj)
   end
end

function M.log(...)
    local args = {...}
    for i, arg in ipairs(args) do
        args[i] = pretty_print(arg, 1) .. '\n'
    end

    print(unpack(args))
end

_G.log = M.log

return M
