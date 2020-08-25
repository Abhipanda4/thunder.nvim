local vim = vim
local results = {}
local handle = nil

local function onread(err, data)
   if err then
      print('ERROR: ', err)
   end
   if data then
      local vals = vim.split(data, "\n")
      for _, d in pairs(vals) do
         if d ~= "" then
            table.insert(results, d)
         end
      end
   end
end

local function set_qf_list()
   if results == nil then
      return
   end
   local num_matches = #results
   if #results > 0 then
      vim.fn.setqflist({}, "r", {lines = results})
      vim.api.nvim_command("cwindow")
      for i = 0, num_matches do
         results[i] = nil
      end
   end
   results = {}
end

local function flashgrep(term)
   local stdout = vim.loop.new_pipe(false)
   local stderr = vim.loop.new_pipe(false)
   handle = vim.loop.spawn(
      "rg",
      {
         args = {term, "--vimgrep", "--smart-case"},
         stdio = {stdout, stderr}
      },
      vim.schedule_wrap(
         function()
            stdout:read_stop()
            stderr:read_stop()
            stdout:close()
            stderr:close()
            handle:close()
            set_qf_list()
         end
      )
   )
   vim.loop.read_start(stdout, onread)
   vim.loop.read_start(stderr, onread)
end

return {
   flashgrep = flashgrep
}
