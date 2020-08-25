local diagnostics = require('bolt/components/diagnostics')
local file = require('bolt/components/file')
local git = require('bolt/components/git')
local bolt_utils = require('bolt/utils')
local M = {}

local function mode(_)
   return bolt_utils.get_current_mode()
end

local component_content_table = {
   ['mode'] = mode,
   ['filepath'] = file.filepath,
   ['filename'] = file.filename,
   ['filetype'] = file.filetype,
   ['special_filetype'] = file.special_filetype,
   ['is_file_modified'] = file.is_file_modified,
   ['cursor_info'] = file.cursor_info,
   ['git_branch'] = git.git_branch,
   ['diagnostics_error'] = diagnostics.error,
   ['diagnostics_warning'] = diagnostics.warning,
   ['diagnostics_hint'] = diagnostics.hint,
}

function M.get_component_by_name(win_opts, name)
   return component_content_table[name](win_opts)
end

return M
