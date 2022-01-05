local status, null_ls = pcall(require, "null-ls")
if not status then
   vim.notify("null-ls not installed...")
   return
end

local formatting = null_ls.builtins.formatting

null_ls.config({
   debug = false,
   sources = {
      formatting.stylua,
      formatting.prettier.with({ extra_args = {"--double-quotes" } }),
      formatting.black.with({ extra_args = { "--fast" }}),
      -- formatting.clang_format.with({ extra_args = { [[-style="{IndentWidth: 3,TabWidth: 3}"]] }})
      formatting.clang_format
   }
})
