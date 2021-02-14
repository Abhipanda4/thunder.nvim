local vim = vim
local completion = require("compe")

local function setup()
   vim.lsp.protocol.CompletionItemKind = {
      '';             -- Text          = 1;
      'ƒ';             -- Method        = 2;
      '';             -- Function      = 3;
      '';             -- Constructor   = 4;
      'Field';         -- Field         = 5;
      '';             -- Variable      = 6;
      '';             -- Class         = 7;
      'ﰮ';             -- Interface     = 8;
      '';             -- Module        = 9;
      '';             -- Property      = 10;
      '';             -- Unit          = 11;
      '';             -- Value         = 12;
      '了';            -- Enum          = 13;
      '';             -- Keyword       = 14;
      '﬌';             -- Snippet       = 15;
      '';             -- Color         = 16;
      '';             -- File          = 17;
      'Reference';     -- Reference     = 18;
      '';             -- Folder        = 19;
      '';             -- EnumMember    = 20;
      '';             -- Constant      = 21;
      '';             -- Struct        = 22;
      'Event';         -- Event         = 23;
      'Operator';      -- Operator      = 24;
      'TypeParameter'; -- TypeParameter = 25;
   }

   completion.setup {
      enabled = true,
      autocomplete = true,
      debug = false,
      min_length = 1,
      preselect = "enable",
      throttle_time = 80,
      source_timeout = 200,
      incomplete_delay = 400,
      max_abbr_width = 100,
      max_kind_width = 100,
      max_menu_width = 100,
      source = {
         nvim_lsp = true,
         nvim_lua = true,
         path = true,
         buffer = true,
         tags = false,
         calc = false,
         vsnip = false,
         spell = false,
         snippets_nvim = false,
         treesitter = false
      }
   }
end

return {
   setup = setup
}
