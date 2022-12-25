local do_nvim = require('do')
-- local ok, do_nvim = pcall(require, "do")
-- if not ok then
   -- vim.notify("do not installed...", vim.log.ERROR)
   -- return
-- end



do_nvim.setup({
   -- default options
   message_timeout = 2000, -- how long notifications are shown
   kaomoji_mode = 0, -- 0 kaomoji everywhere, 1 skip kaomoji in doing
   doing_prefix = "Doing: ",
   use_winbar = true,
   store = {
      auto_create_file = false, -- automatically create a .do_tasks when calling :Do
      file_name = ".do_tasks",
   },
})

-- do_nvim.view()
-- do_nvim.view_inactive()

-- vim.o.winbar = require("do").statusline

-- vim.api.nvim_set_option_value("winbar", do_nvim.view(), { scope = "global" })

-- vim.api.nvim_create_autocmd({ "User" }, {
   -- group = require("do.state").state.auGroupId,
   -- desc = "A task has been added",
   -- pattern = "TaskModified",
   -- callback = function()
      -- print("Task modified")
   -- end,
-- })
