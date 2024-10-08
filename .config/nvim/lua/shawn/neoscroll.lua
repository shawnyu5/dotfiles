local neoscroll = require("neoscroll")
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

-- local t = {}
-- -- Syntax: t[keys] = {function, {function arguments}}
-- t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "150" } }
-- t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "150" } }

local keymap = {
	["<C-u>"] = function()
		neoscroll.ctrl_u({ duration = 150 })
	end,
	["<C-d>"] = function()
		neoscroll.ctrl_d({ duration = 150 })
	end,
}

local modes = { "n", "v", "x" }
for key, func in pairs(keymap) do
	vim.keymap.set(modes, key, func)
end
