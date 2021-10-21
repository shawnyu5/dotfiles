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

return M
