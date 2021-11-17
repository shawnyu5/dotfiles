-- reload this package
package.loaded["executor"] = nil

local executor = require("executor")

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
            "node %",
            "nodemon --delay 500ms %"
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

