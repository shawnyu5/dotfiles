local ok, neogen = pcall(require, "neogen")
if not ok then
	print("neogen not installed...")
	return
end

neogen.setup({})
