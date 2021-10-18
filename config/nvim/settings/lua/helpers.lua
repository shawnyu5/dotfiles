local M = {}

-- function! CloseSomething()
  -- if winnr("$") == 1 && tabpagenr("$") > 1 && tabpagenr() > 1 && tabpagenr() < tabpagenr("$")
    -- tabclose | tabprev
  -- else
    -- q!
  -- endif
-- endfunction

function M.leftCloser(save)
    if vim.fn.winnr("$") and vim.fn.tabpagenr("$") > 1 and vim.fn.tabpagenr() > 1 and vim.fn.tabpagenr() < vim.fn.tabpagenr("$") then
        if save == true then
            vim.cmd("w! | tabclose | tabprev ")
        else
            vim.cmd("tabclose! | tabprev ")
        end

    else
        vim.cmd("q!")
    end
end

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


-- exists and closes all term buffers
function M.term_closer()
    local win_ids = {}
    -- remember current window
    local current_window = vim.fn.win_getid()

    -- from tab 1 to last tab open
    for i = 1, vim.fn.tabpagenr("$") do
        -- if buffer is a terminal, we close it
        if vim.fn.gettabwinvar(i, 1, "&buftype") == "terminal" then
            local win_id = vim.fn.win_getid(1, i)
            table.insert(win_ids, win_id)
        end
    end

    -- go to all windows, send tell terminal to exit and close tab
    for i = 1, #win_ids do
        vim.fn.win_gotoid(win_ids[i])
        vim.fn.chansend(vim.b.terminal_job_id, "\n\nexit\n") --send exit key
        vim.fn.win_execute(win_ids[i], "close") -- close window
    end
    -- go back to the window we started with
    vim.fn.win_gotoid(current_window)

end

return M
