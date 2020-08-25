local vim = vim
local M = {}

local function get_diagnostic_count(win_opts, severity)
   if vim.tbl_isempty(vim.lsp.buf_get_clients(win_opts.bufnr)) then
      return nil
   end
   return vim.lsp.diagnostic.get_count(win_opts.bufnr, severity)
end

local function is_empty(n_diagnostics)
   if n_diagnostics == nil or n_diagnostics == 0 then
      return true
   end
   return false
end

function M.error(win_opts)
   local n_err = get_diagnostic_count(win_opts, 'Error')
   if is_empty(n_err) then return '' end
   return n_err
end

function M.warning(win_opts)
   local n_warn = get_diagnostic_count(win_opts, 'Warning')
   if is_empty(n_warn) then return '' end
   return n_warn
end

function M.hint(win_opts)
   local n_hint = get_diagnostic_count(win_opts, 'Hint') or 0
   local n_info = get_diagnostic_count(win_opts, 'Information') or 0
   local n_total = n_hint + n_info
   if is_empty(n_total) then return '' end
   return n_total
end

return M
