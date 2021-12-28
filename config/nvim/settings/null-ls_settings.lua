local status, null_ls = pcall(require, "null-ls")
if not status then
    vim.notify("null ls not installed...")
    return
end

local formatting = null_ls.builtins.formatting

null_ls.config({
    debug = false,
    sources = {
        formatting.stylua
    }
})
