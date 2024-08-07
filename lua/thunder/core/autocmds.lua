local api = vim.api
local autocmd = api.nvim_create_autocmd

autocmd("TextYankPost", {
  group    = vim.api.nvim_create_augroup('text_yank_post', { clear = true }),
	command = "silent! lua vim.highlight.on_yank({higroup='IncSearch', timeout=120})",
	desc = "Highlight yanked text",
})

-- https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
-- https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd({ "FocusGained", "BufEnter", "TermResponse" }, {
  group    = vim.api.nvim_create_augroup('auto_file_refresh', { clear = true }),
	command = [[silent! if mode() != 'c' && !bufexists("[Command Line]") | checktime | endif]],
	desc = "Reload file if changed outside of nvim",
})

autocmd("BufHidden", {
  group    = vim.api.nvim_create_augroup('empty_buffer', { clear = true }),
	desc = "Delete [No Name] buffer when it's hidden",
	callback = function(event)
		if event.file == "" and vim.bo[event.buf].buftype == "" and not vim.bo[event.buf].modified then
			vim.schedule(function() api.nvim_buf_delete(event.buf, { force = true }) end)
		end
	end,
})

autocmd({ "BufWritePre" }, {
  group    = vim.api.nvim_create_augroup('create_missing_dir', { clear = true }),
	desc = "Create missing directories before writing the buffer",
	command = "silent! call mkdir(expand('%:p:h'), 'p')",
})

-- adapted from https://github.com/ethanholz/nvim-lastplace/blob/main/lua/nvim-lastplace/init.lua
vim.api.nvim_create_autocmd({'BufWinEnter', 'FileType'}, {
  group    = vim.api.nvim_create_augroup('last_cursor_position', { clear = true }),
  callback = function()
    local ignore_buftype = { "quickfix", "nofile", "help" }
    local ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" }
    if vim.tbl_contains(ignore_buftype, vim.bo.buftype) then
      return
    end

    if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
      -- reset cursor to first line
      vim.cmd[[normal! gg]]
      return
    end

    -- If a line has already been specified on the command line, we are done
    --   nvim file +num
    if vim.fn.line(".") > 1 then
      return
    end

    local last_line = vim.fn.line([['"]])
    local buff_last_line = vim.fn.line("$")

    -- If the last line is set and the less than the last line in the buffer
    if last_line > 0 and last_line <= buff_last_line then
      local win_last_line = vim.fn.line("w$")
      local win_first_line = vim.fn.line("w0")
      -- Check if the last line of the buffer is the same as the win
      if win_last_line == buff_last_line then
        -- Set line to last line edited
        vim.cmd[[normal! g`"]]
        -- Try to center
      elseif buff_last_line - last_line > ((win_last_line - win_first_line) / 2) - 1 then
        vim.cmd[[normal! g`"zz]]
      else
        vim.cmd[[normal! G'"<c-e>]]
      end
    end
  end
})
