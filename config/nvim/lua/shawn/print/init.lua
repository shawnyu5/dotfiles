local M = {}


local opts = {
    cpp = {
        'std::cout << "BBB" << "\n";',
        'std::cout << BBB << "\n";'
    },
    lua = {
        'print("BBB")',
        'print(BBB)'
    },
    python = {
        'print("BBB")',
        'print(BBB)'
    },
    javascript = {
        'console.log("BBB")',
        'console.log(BBB)'
    },
    bash = {
        'echo "BBB"',
        'echo BBB'
    }
}

function M.print(quotes)
    local filetype = vim.bo.filetype

    for k, v in pairs(opts) do
        if filetype == k then

            print("filetype is " .. k)
            -- if quotes are wanted in print statement
            if quotes then
                vim.api.nvim_put({v[1]}, "l", true, true)
            else
                vim.api.nvim_put({v[2]}, "l", true, true)
            end
        end
    end
    -- -- find `BBB` place holder
    vim.api.nvim_command("?BBB")
    -- -- delete it
    vim.cmd('norm! _ci"')
    -- -- move curor to right and start insert mode
    vim.cmd("norm! l")
    vim.api.nvim_command("startinsert")
end

return M


