vim.cmd([[
command! Sterm :lua require("shawn.terminal").small_terminal()
command! Lterm :lua require("shawn.terminal").left_terminal(true)
command! Rterm :lua require("shawn.terminal").left_terminal(false)
]])
