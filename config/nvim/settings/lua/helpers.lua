local M = {}

function M.print()
    print("Hiiii!!!")
end

local function term_and_excute(command)
    vim.cmd("tabe | term")
    vim.cmd("vim.b.terminal_job_id, command")
end

function M.executor()
    local current_file_name = vim.fn.expand('%')
    print(current_file_name)

    if vim.bo.filetype == "python" then
        print("file type is python")
        local command = "python3 " .. current_file_name .. "\n"
        term_and_excute(command)
    end
end


return M
