-- reload this package
package.loaded["executor"] = nil

local executor = require("executor")

executor.setup({
    commands = {
        cpp = {
            "make",
            "g++ %"
        },
        python = {
            "python3 %"
        },
        javascript = {
            "nodemon %"
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

    dependency_commands = {
        make = "makefile"
    }
})


