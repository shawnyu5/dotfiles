local ok, hydra = pcall(require, "hydra")
if not ok then
   vim.notify("hydra not installed...", vim.log.ERROR)
   return
end

local M = {}

-- hydra({
-- name = "Side scroll",
-- mode = "n",
-- body = "z",
-- heads = {
-- { "h", "zz" },
-- { "l", "5zl", { desc = "←/→" } },
-- { "H", "zH" },
-- { "L", "zL", { desc = "half screen ←/→" } },
-- },
-- })

-- dap hydra for dap operations
local dap = require("dap")
local dapui = require("dapui")

M.dap_hydra = hydra({
   name = "dap",
   mode = "n",
   -- body = "<leader>d",
   heads = {
      -- {
      -- "c",
      -- function()
      -- dap.continue()
      -- end,
      -- { desc = "continue" },
      -- },
      {
         "o",
         function()
            dap.step_over()
         end,
         { desc = "Step over" },
      },
      {
         "O",
         function()
            dap.step_out()
         end,
         { desc = "Step out" },
      },
      {
         "n",
         function()
            dap.step_into()
         end,
         { desc = "Step into" },
      },
      {
         "f",
         function()
            dapui.float_element("scopes", { enter = true, width = 75 })
         end,
         { desc = "toggle scopes in floating window" },
      },
   },
   config = {
      exit = false,
      -- run all other keys pressed if they are not a hydra head
      foreign_keys = "run",
   },
})

local take_input = function()
   vim.ui.select({ "a", "b", "c" }, {
      prompt = "Input: ",
      on_select = function(selected)
         print(selected)
      end,
   })
end
hydra({
   name = "input test",
   mode = "n",
   body = "t",
   heads = {
      { "s", take_input, { desc = "Take input", exit = true } },
   },
})

local hint = [[
  ^ ^        Options
  ^
  _r_ %{rnu} relative number
  _s_ %{spell} spell
  ^
       ^^^^                _<Esc>_
]]

local options_hydra = hydra({
   name = "Options",
   hint = hint,
   config = {
      color = "amaranth",
      invoke_on_body = true,
      hint = {
         border = "rounded",
         position = "middle",
      },
   },
   mode = { "n", "x" },
   -- body = "<leader>o",
   heads = {
      {
         "r",
         function()
            if vim.o.relativenumber == true then
               vim.o.relativenumber = false
            else
               vim.o.number = true
               vim.o.relativenumber = true
            end
         end,
         { desc = "relativenumber" },
      },
      {
         "s",
         function()
            if vim.o.spell == true then
               vim.o.spell = false
            else
               vim.o.spell = true
            end
         end,
         { exit = true, desc = "spell" },
      },
      { "<Esc>", nil, { exit = true } },
   },
})

-- options hydra to easily toggle common options
vim.api.nvim_create_user_command("Options", function()
   options_hydra:activate()
end, {})

return M
