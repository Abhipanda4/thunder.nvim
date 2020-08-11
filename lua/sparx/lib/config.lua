local M = {}
local vim = vim

function M.get_mappings()
   local keybindings = vim.g.sparx_custom_key_binds or {}
   return {
      edit              = keybindings.edit or 'o',
      recursive_expand  = keybindings.recursive_expand or 'O',
      vsplit            = keybindings.edit_vsplit or '<C-v>',
      split             = keybindings.edit_split or '<C-x>',
      create            = keybindings.create or 'a',
      rename            = keybindings.rename or 'r',
      copy              = keybindings.copy or 'y',
      delete            = keybindings.remove or 'd',
   }
end

return M
