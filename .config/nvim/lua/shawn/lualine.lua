local ok, lualine = pcall(require, "lualine")
if not ok then
   vim.notify("lualine not installed...", vim.log.levels.WARN)
   return
end

--- return the current harpoon mark if it exists
---@return string the harpoon mark for the statusline
local get_harpoon_status = function()
   local harpoon_mark = require("harpoon.mark")
   local mark_id = harpoon_mark.get_index_of(vim.fn.bufname())

   if not mark_id or mark_id == "" then
      return ""
   end
   return "🦈 " .. mark_id
end

lualine.setup({
   options = {
      icons_enabled = false,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {},
      always_divide_middle = true,
      globalstatus = true,
   },
   sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diagnostics" },
      lualine_c = { "filename", get_harpoon_status },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
   },
   inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
   },
   -- tabline = {
   --    lualine_a = { "tabs" },
   --    lualine_b = { "filename" },
   -- },
   extensions = {},
})



-- vim.opt.tabline = "%f"

-- local set_tabline = function()
-- local bulist = {}
-- local last_tab = vim.fn.tabpagenr("$")
-- for i = 1, last_tab do
-- -- append to bulist
-- table.insert(bulist, i)
-- end
-- print("function bulist:", vim.inspect(bulist)) -- __AUTO_GENERATED_PRINT_VAR__
-- end

-- set_tabline()
