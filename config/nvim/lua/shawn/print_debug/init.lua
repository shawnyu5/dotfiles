package.loaded["print_debug"] = false
local M = {}

local function wrap_variable(message, variable, ft)
    local command = ''
    if ft == "javascript" then
        if command then
            command = "console.log('" .. message .. "', " .. variable .. "');"
        else
            command = "console.log(" .. variable .. ");"
        end
    elseif ft == "python" then
        if command then
            command = "print('" .. message .. "', " .. variable .. "')"
        else
            command = "print(" .. variable .. ")"
        end
    elseif ft == "cpp" then
        if command then
            command = "cout << \"" .. message .. "\" << " .. variable .. " << '\\n';"
        else
            command = "cout <<" .. variable .. " << '\\n';"
        end
    elseif ft == "lua" then
        if command then
            command = "print('" .. message .. "' .. " .. variable .. ")"
        else
            command = "print(" .. variable .. ")"
        end
    end
    return command
end


function M.print_debug()
    local message = vim.fn.input("message> ")
    message = message or nil

    local variable = vim.fn.expand("<cword>")
    local ft = vim.bo.filetype
    -- wrap variable in print statement with message
    local statement = wrap_variable(message, variable, ft)

    vim.fn.append(vim.fn.line('.'), statement)
    vim.cmd("norm! =1j")

end

vim.api.nvim_set_keymap("n", "<leader>db", ":lua require('shawn.print_debug').print_debug()<CR>", { noremap = true })

return M
