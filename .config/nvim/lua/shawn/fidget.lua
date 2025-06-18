local ok, fidget = pcall(require, "fidget")
if not ok then
	vim.notify("fidget not installed...", vim.log.ERROR)
	return
end

fidget.setup({})
