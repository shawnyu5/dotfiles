local ok, mkdnflow = pcall(require, "mkdnflow")
if not ok then
	vim.notify("mkdnflow not installed...", vim.log.ERROR)
	return
end

mkdnflow.setup()
