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

-- close all open term buffers
local function close_terms()
    -- from tab 1 to last tab open
    for i = 1, vim.fn.tabpagenr("$") do
        -- print("checking tab " .. i)
        -- if buffer is a terminal, we close it
        if vim.fn.gettabwinvar(i, 1, "&buftype") == "terminal" then
            -- print("terminal found")
            -- print(vim.fn.gettabwinvar(i, 1, "&buftype"))
            local win_id = vim.fn.win_getid(1, i)
            -- print("closing window " .. i)
            vim.fn.win_execute(win_id, "close")
        end
        -- print("iteration " .. i)
    end
end

-- A wrapper to close all terminal windows
function M.closer()
    for i = 0, 13 do
        close_terms()
    end
end

return M
