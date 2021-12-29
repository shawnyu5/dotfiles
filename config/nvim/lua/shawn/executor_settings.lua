-- reload this package
package.loaded["executor"] = nil

local ok, executor = pcall(require, "executor")
if not ok then
    return
end

executor.setup({
    commands = {
        cpp = {
            "make",
            "g++ % && ./a.out"
        },
        python = {
            "python3 %"
        },
        javascript = {
            "npm start",
            "nodemon --delay 500ms %",
        },
        sh = {
            "bash %"
        },
        vim = {
            "source %",
            extern = false
        },
        lua = {
            "luafile %",
            extern = false
        },
        markdown = {
            "MarkdownPreview",
            extern = false
        }

    },
    default_mappings = true,
    always_exit = true,
    dependency_commands = {
        make = "makefile"
    }
})
-- print(vim.inspect(executor.commands))
-- print(executor.executor_settings.commands)

