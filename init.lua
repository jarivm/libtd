local list = require 'lib.list'

local M = {}

function M.setup(options)
    options = options or {}

    if options.random then
        list._random = options.random
    end

    if options.enable_debugging then
        require 'lib.strict'
    end
end

return M
