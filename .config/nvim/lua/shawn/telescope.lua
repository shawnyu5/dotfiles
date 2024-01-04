local ok, telescope = pcall(require, "telescope")
if not ok then
   print("telescope not installed...")
   return
end
local M = {}


-- use git files if in a git repo, other wise fall back to find_files
function M.project_files()
   local opts = {} -- define here if you want to define something
   local ok = pcall(require("telescope.builtin").git_files, opts)
   if not ok then
      require("telescope.builtin").find_files(opts)
   end
end

local keymap = vim.keymap.set
-- vim.keymap.set('n', 'lhs', function() print("real lua function") end)

local telescope_builtin = require("telescope.builtin")

local opts = { noremap = true, silent = true }
keymap("n", "<leader>fd", function() telescope_builtin.diagnostics() end, opts)
keymap("n", "<leader>ff", function()
   telescope_builtin.find_files({
      hidden = true
   })
end, { desc = "fuzzy find all files in pwd, including hidden files" })
keymap("n", "<leader>fb", function() telescope_builtin.buffers() end, { desc = "fuzzy search all buffers" })
keymap("n", "<leader>fw", function() telescope_builtin.live_grep({ layout_strategy = "vertical" }) end,
   { desc = "fuzzy search words" })
keymap("n", "<leader>fc", function() telescope_builtin.find_files({ cwd = "~/.config/nvim" }) end,
   { desc = "fuzzy search over neovim config" })
keymap("n", "<leader>fr", telescope_builtin.resume, { desc = "resume last telescope search" })
keymap("n", "<leader>fh", telescope_builtin.help_tags, { desc = "fuzzy search vim help tags" })
keymap({ "n", "v" }, "<leader><leader>fw", function()
   telescope_builtin.grep_string({ layout_strategy = "vertical" })
end, { desc = "live grep for word under cursor" })



vim.cmd([[
   command! Config :lua require('telescope.builtin').find_files({cwd = "~/.config/nvim/"})
   command! Planets :lua require("telescope.builtin").planets({show_pluto = true})
]])

require("telescope").setup({
   defaults = {
      file_ignore_patterns = { ".git/" },
      path_display = { truncate = 3 },
      layout_config = {
         vertical = {
            preview_cutoff = 20,
         },
      },
   },
   extensions = {
      ["ui-select"] = {
         require("telescope.themes").get_dropdown({
            -- even more opts
         }),
      },
   },
})
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension("ui-select")
-- telescope.load_extension("file_browser")

return M
