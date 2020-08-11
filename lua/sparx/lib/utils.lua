local vim = vim
local M = {}

function M.create_buffer()
    local buf_options = {
        bufhidden = 'wipe',
        buftype = 'nofile',
        filetype = 'sparx',
        modifiable = false,
        swapfile = false
    }
    local buf_handle = vim.api.nvim_create_buf(false, true)
    for opt, val in pairs(buf_options) do
        vim.api.nvim_buf_set_option(buf_handle, opt, val)
    end
    return buf_handle
end

function M.create_window()
    local win_options = {
        number =  false,
        relativenumber = false,
        list = false,
        winfixwidth = true,
        winfixheight = true,
        foldenable = false,
        spell = false,
        foldmethod = 'manual',
        foldcolumn = '0'
    }
    vim.api.nvim_command("vsplit")
    vim.api.nvim_command("wincmd H")
    vim.api.nvim_command("vertical resize 40")

    local win_handle = vim.api.nvim_get_current_win()
    for opt, val in pairs(win_options) do
        vim.api.nvim_win_set_option(win_handle, opt, val)
    end
    return win_handle
end

function M.get_all_dirs_in_path(filepath)
   -- Find relatice path wrt CWD
   local relpath = string.gsub(filepath, vim.loop.cwd(), '')

   -- Populate by splitting along delimiter '/'
   local idx = 0
   local alldirs = {}
   for part in string.gmatch(relpath, "([^/]+)") do
      idx = idx + 1
      alldirs[idx] = part
   end

   -- Last part is the filename and can be ignored
   table.remove(alldirs, idx)
   return alldirs
end

return M
