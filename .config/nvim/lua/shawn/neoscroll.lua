local ok, neoscroll = pcall(require, "neoscroll")
if not ok then
	print("neoscroll not installed...")
	return
end

local utils = require("shawn.utils")
if not utils.get_system_config().windows then
	neoscroll.setup({
		-- All these keys will be mapped to their corresponding default scrolling animation
		mappings = { "<C-u>", "<C-d>" },
		hide_cursor = false, -- Hide cursor while scrolling
		stop_eof = false, -- Stop at <EOF> when scrolling downwards
		use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
		respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
		cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
		easing_function = "quadratic", -- Default easing function
		pre_hook = nil, -- Function to run before the scrolling animation starts
		post_hook = nil, -- Function to run after the scrolling animation ends
		performance_mode = false, -- Disable "Performance Mode" on all buffers.
	})

	local t = {}
	-- Syntax: t[keys] = {function, {function arguments}}
	t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "150" } }
	t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "150" } }

	require("neoscroll.config").set_mappings(t)
end
