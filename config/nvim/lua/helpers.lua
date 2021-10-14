local M = {}

-- opens a terminal in new tab and excute command
local function term_and_excute(command)
    vim.cmd("tabe | term")
    vim.fn.chansend(vim.b.terminal_job_id, command)
    vim.cmd("norm! i")
end

-- excutes file based on file type
function M.executor()
    local current_file_name = vim.fn.expand("%")
    local filetype = vim.bo.filetype
    -- print("file type is " .. filetype)

    if filetype == "python" then
        -- print("file type is python")
        local command = "python3 " .. current_file_name .. "\n"
        term_and_excute(command)

    elseif filetype == 'cpp' then
        local files = vim.fn.system("ls")

        -- check if make file exist in cwd
        if string.find(files, "makefile") or string.find(files, "Makefile") then
            local command = "make\n"
            term_and_excute(command)
        else
            local command = "g++ " .. current_file_name .. " && ./a.out\n"
            term_and_excute(command)
        end

    elseif filetype == "javascript" then
        local command = "node " .. current_file_name .. "\n"
        term_and_excute(command)

    elseif filetype == "sh" then
        local command = "./" .. current_file_name .. "\n"
        term_and_excute(command)

    elseif filetype == "markdown" then
        vim.cmd("MarkdownPreview")

    elseif filetype == "html" then
        vim.cmd("!chrome %")

    elseif filetype == "vim" then
        vim.cmd("so %")

    elseif filetype == "lua" then
        vim.cmd("luafile %")

    else
        print("No mapping created")
    end
end

local function close_terms()
    local buffers = vim.api.nvim_list_bufs()
    print(buffers)
end

close_terms()

return M
