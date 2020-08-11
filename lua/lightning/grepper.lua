-- ====================================================================
-- Name: lua/lightning/grepper.lua
-- Description: Async grep using ripgrep across all files in cwd
-- Maintainer: Abhisek Panda <abhipanda03@gmail.com>
-- ====================================================================


local M = {}
local results = {}


local function onread(err, data)
    if data then
        local vals = vim.split(data, "\n")
        for _, d in pairs(vals) do
            if d ~= "" then
                table.insert(results, d)
            end
        end
    end
end


local function set_QFList()
    vim.fn.setqflist({}, 'r', {lines = results})
    local count = #results
    if count > 0 then
        vim.api.nvim_command('cwindow')
    else
        print "No results found"
    end
    -- clear the table for the next search
    for i=0, count do
        results[i] = nil
    end
end


function M.AsyncGrep(term, files)
    local stdout = vim.loop.new_pipe(false)
    local stderr = vim.loop.new_pipe(false)
    handle = vim.loop.spawn(
        'rg',
        {
            args={term, '--vimgrep', '--smart-case'},
            stdio={stdout, stderr}
        },
        vim.schedule_wrap(function()
            stdout:read_stop()
            stderr:read_stop()
            stdout:close()
            stderr:close()
            handle:close()
            set_QFList()
        end)
    )

    vim.loop.read_start(stdout, onread)
    vim.loop.read_start(stderr, onread)
end

return M
