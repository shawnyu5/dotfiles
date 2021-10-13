local M = {}

local function term_and_excute(command)
    vim.cmd("tabe | term")
    vim.cmd("vim.b.terminal_job_id, command")
    vim.cmd("norm! i")
end

function M.executor()
    local current_file_name = vim.fn.expand('%')
    local filetype = vim.bo.filetype
    -- print(current_file_name)

    if filetype == "python" then
        local command = "python3 " .. current_file_name .. "\n"
        term_and_excute(command)
    elseif filetype == "cpp" then
        local files = vim.fn.system("ls")

        if string.find(files, "makefile") or string.find(files, "Makefile") then
            local command = "make"
            term_and_excute(command)
        else
            local command = "g++ " .. current_file_name .. " && ./a.out\n"
            term_and_excute(command)
        end
    elseif filetype == "javascript" then
        local command = "node " .. current_file_name .. "\n"
        term_and_excute(command)
    elseif filetype == "sh" then
        local command = "./" .. current_file_name
        term_and_excute(command)

    elseif filetype == 'markdown' then
        local command = 'MarkdownPreview'
        term_and_excute(command)

    elseif filetype == 'html' then
        local command = '!chrome %'
        term_and_excute(command)

    elseif filetype == "lua" then
        local command = "luafile %"
        term_and_excute(command)
    end
end

return M
