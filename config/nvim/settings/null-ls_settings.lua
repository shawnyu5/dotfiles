-- filetypes = { "c", "cpp", "cs", "java" }
-- command = "clang-format"
-- args = { "-assume-filename=<FILENAME>" }

local null_ls = require("null-ls")

require("null-ls").config({
    sources = {
        null_ls.builtins.formatting.clang_format
        -- null_ls.builtins.formatting.clang_format.with({
        -- extra_args = { '-style="{IndentWidth: 4,TabWidth: 4}"'}
        -- })
    }
})
