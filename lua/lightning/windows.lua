-- ====================================================================
-- Name: lua/lightning/windows.lua
-- Description: Floating window with/without borders
-- Maintainer: Abhisek Panda <abhipanda03@gmail.com>
-- ====================================================================

local vim = vim
local M = {}

function M.create_floating_window(opts, border_opts)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

    if border_opts then
        local linear_width = opts.width - 2
        local linear_height = opts.height - 2

        -- Insert full horizontal borders at beginning/end,
        -- only first and last char at the middle lines
        local border_lines = {}
        table.insert(border_lines, '╔' .. string.rep('═', linear_width) .. '╗')
        local middle_line = '║' .. string.rep(' ', linear_width) .. '║'
        for _=1, linear_height do
            table.insert(border_lines, middle_line)
        end
        table.insert(border_lines, '╚' .. string.rep('═', linear_width) .. '╝')

        vim.api.nvim_buf_set_lines(buf, 0, -1, false, border_lines)
    end
    local win = vim.api.nvim_open_win(buf, true, opts)
    return buf, win
end

function M.get_border_opts_from_window_opts(opts)
    local border_opts = vim.deepcopy(opts)
    border_opts.width = opts.width + 2
    border_opts.height = opts.height + 2
    border_opts.row = opts.row - 1
    border_opts.col = opts.col - 1
    return border_opts
end

function M.open_centered_float_with_border()
    local width = vim.api.nvim_get_option("columns")
    local height = vim.api.nvim_get_option("lines")

    local win_height = math.ceil(height * 0.5 - 4)
    local win_width = math.ceil(width * 0.5)
    local row = math.ceil((height - win_height) / 2 - 1)
    local col = math.ceil((width - win_width) / 2)

    -- params for primary buffer
    local opts = {
        style = "minimal",
        relative = "editor",
        width = win_width,
        height = win_height,
        row = row,
        col = col
    }

    local border_opts = M.get_border_opts_from_window_opts(opts)
    local _, border_win = M.create_floating_window(border_opts, true)
    local primary_buf, primary_win = M.create_floating_window(opts, false)

    vim.api.nvim_win_set_option(border_win, 'winhl', 'NormalFloat:Normal')
    vim.api.nvim_win_set_option(primary_win, 'winhl', 'NormalFloat:Normal')

    vim.api.nvim_command(
        string.format(
            "autocmd WinLeave,BufLeave,BufDelete <buffer=%s> ++once ++nested silent! call nvim_win_close(%s, v:true)",
            primary_buf, border_win
        )
    )
    return primary_buf, primary_win
end

function M.open_hover_win_at_cursor(width, height)
    local curr_row = vim.fn.winline() + 1
    local curr_col = vim.api.nvim_win_get_cursor(0)[2]
    local opts = {
        style = "minimal",
        relative = "win",
        width = width,
        height = height,
        row = curr_row,
        col = curr_col,
        focusable = false,
    }

    local primary_buf, primary_win = M.create_floating_window(opts, false)
    vim.api.nvim_win_set_option(primary_win, 'winhl', 'NormalFloat:BorderlessFloat')

    vim.api.nvim_command(
        string.format(
            "autocmd CursorMoved,WinLeave,BufLeave,BufDelete <buffer=%s> ++once ++nested silent! call nvim_win_close(%s, v:true)",
            primary_buf, primary_win
        )
    )
    return primary_buf, primary_win
end

return M
