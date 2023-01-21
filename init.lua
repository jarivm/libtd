local list = require 'lib.list'
local test = require 'lib.test'

local M = {}

function M.setup(options)
    options = options or {}

    if options.random then
        list._random = options.random
    end

    if options.enable_strict then
        require 'lib.strict'
    end

    if options.test then
        require 'lib.list'
        require 'lib.dict'
        require 'lib.rect'
        test.run()
    end
end

return M
