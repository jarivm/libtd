local f = string.format

local M = {}

M.tests = {}

function M.it(name, run)
    table.insert(M.tests, {name=name,run=run})
end

function M.run()
    local failed = 0

    print(f('running %d test(s)...', #M.tests))
    for i, test in ipairs(M.tests) do
        local ok, message = pcall(test.run)

        if ok then
            print("✓ " .. test.name)
        else
            print(f("✘ %s [%s]", test.name, message))
            failed = failed + 1
        end
    end

    print(f('%d test(s) failed, %d test(s) passed', failed, #M.tests - failed))
end

return M
