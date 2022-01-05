local M = {}

local opts = {
   cpp = {
      [[std::cout << "BBB" << '\n';]],
      'std::cout << BBB << "\n";'
   },
   lua = {
      'print("BBB")',
      'print(BBB)'
   },
   python = {
      'print("BBB")',
      'print(BBB)'
   },
   javascript = {
      'console.log("BBB")',
      'console.log(BBB)'
   },
   sh = {
      'echo "BBB"',
      'echo BBB'
   },
   vim = {
      'echo "BBB"',
      'echo BBB'
   }
}

function M.print(quotes)
   local filetype = vim.bo.filetype

   for k, v in pairs(opts) do if filetype == k then
      -- if quotes are wanted in print statement
      if quotes then
         vim.api.nvim_put({v[1]}, "l", true, false)
         -- delete inside quotes
         vim.cmd('norm! ==_ci"')
         goto continue
      else
         vim.api.nvim_put({v[2]}, "l", true, false)
         -- delete inside brackets
         vim.cmd('norm! ==_ci(')
         goto continue
      end
   end
end
print("no print statement defined for this file type")
-- if for loop is exited, then there are no mappings for current file type
vim.cmd("norm! i'p")
do return end

::continue::
-- move curor to right and start insert mode
vim.cmd("norm! kddl") -- TODO: idk why `nvim_put` puts the new line on the
-- next line, this is a hack, but figure out why `nvim_put` does that
vim.api.nvim_command("startinsert")
end


return M
