package.loaded["print_debug"] = false
local M = {}

local opts = {
    cpp = 'std::cout << "<message>" << <variable> << \'\\n\';',
    javascript = 'console.log("<message>", <variable>);',
    python = 'print("<message>", <variable>)',
    lua = 'print("<message>" .. <variable>)'
}

-- wraps message and vaiable in print statment based on file type
local function wrap_variable(message, variable, ft)
    for file_type, print_statement in pairs(opts) do
        if file_type == ft then
            local command = print_statement:gsub("<message>", message)
            command = command:gsub("<variable>", variable)
            return command
        end
    end
end

function M.print_debug()
    local ft = vim.bo.filetype

    local message = vim.fn.input("message> ")

    -- if message == "" then
        -- message = nil
    -- end

    local variable = vim.fn.expand("<cword>")

    -- wrap variable in print statement with message
    local statement = wrap_variable(message, variable, ft)
    vim.fn.append(vim.fn.line('.'), statement)
    vim.cmd("norm! =1j")
end

-- M.print_debug()
vim.api.nvim_set_keymap("n", "<leader>db", ":lua require('shawn.print_debug').print_debug()<CR>", { noremap = true })

return M
