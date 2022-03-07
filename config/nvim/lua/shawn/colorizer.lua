local ok, colorizer = pcall(require, "colorizer")
if not ok then
	print("colorizer not installed...")
	return
end

colorizer.setup()
