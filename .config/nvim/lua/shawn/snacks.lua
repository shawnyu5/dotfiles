local Snacks = require("snacks")

---@type snacks.Config
Snacks.setup({
	picker = {
		enabled = true,
		lsp_definitions = {
			focus = "list",
		},
		lsp_references = {
			focus = "list",
		},
		prompt = " ",
		sources = {},
		focus = "input",
		show_delay = 5000,
		limit_live = 10000,
		---@class snacks.picker.matcher.Config
		matcher = {
			fuzzy = true, -- use fuzzy matching
			smartcase = true, -- use smartcase
			ignorecase = true, -- use ignorecase
			sort_empty = false, -- sort results when the search string is empty
			filename_bonus = true, -- give bonus for matching file names (last part of the path)
			file_pos = true, -- support patterns like `file:line:col` and `file:line`
			-- the bonusses below, possibly require string concatenation and path normalization,
			-- so this can have a performance impact for large lists and increase memory usage
			cwd_bonus = false, -- give bonus for matching files in the cwd
			frecency = true, -- frecency bonus
			history_bonus = false, -- give more weight to chronological order
		},
		ui_select = true, -- replace `vim.ui.select` with the snacks picker
		---@class snacks.picker.previewers.Config
		previewers = {
			diff = {
				builtin = true, -- use Neovim for previewing diffs (true) or use an external tool (false)
				cmd = { "delta" }, -- example to show a diff with delta
			},
			git = {
				builtin = true, -- use Neovim for previewing git output (true) or use git (false)
				args = {}, -- additional arguments passed to the git command. Useful to set pager options usin `-c ...`
			},
			file = {
				max_size = 1024 * 1024, -- 1MB
				max_line_length = 500, -- max line length
				ft = nil, ---@type string? filetype for highlighting. Use `nil` for auto detect
			},
			man_pager = nil, ---@type string? MANPAGER env to use for `man` preview
		},
		---@class snacks.picker.jump.Config
		jump = {
			jumplist = true, -- save the current position in the jumplist
			tagstack = false, -- save the current position in the tagstack
			reuse_win = false, -- reuse an existing window if the buffer is already open
			close = true, -- close the picker when jumping/editing to a location (defaults to true)
			match = false, -- jump to the first match position. (useful for `lines`)
		},
		toggles = {
			follow = "f",
			hidden = "h",
			ignored = "i",
			modified = "m",
			regex = { icon = "R", value = false },
		},
		win = {
			-- input window
			input = {
				keys = {
					-- to close the picker on ESC instead of going to normal mode,
					-- add the following keymap to your config
					-- ["<Esc>"] = { "close", mode = { "n", "i" } },
					["<C-c>"] = { "cancel", mode = "i" },
					["<C-w>"] = { "<c-s-w>", mode = { "i" }, expr = true, desc = "delete word" },
					["<CR>"] = { "confirm", mode = { "n", "i" } },
					["<Down>"] = { "list_down", mode = { "i", "n" } },
					["<Esc>"] = "cancel",
					["<S-CR>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
					["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
					["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
					["<Up>"] = { "list_up", mode = { "i", "n" } },
					["<a-d>"] = { "inspect", mode = { "n", "i" } },
					["<a-f>"] = { "toggle_follow", mode = { "i", "n" } },
					["<a-h>"] = { "toggle_hidden", mode = { "i", "n" } },
					["<a-i>"] = { "toggle_ignored", mode = { "i", "n" } },
					["<a-r>"] = { "toggle_regex", mode = { "i", "n" } },
					["<a-m>"] = { "toggle_maximize", mode = { "i", "n" } },
					["<a-p>"] = { "toggle_preview", mode = { "i", "n" } },
					["<a-w>"] = { "cycle_win", mode = { "i", "n" } },
					["<c-a>"] = { "select_all", mode = { "n", "i" } },
					["<c-b>"] = { "preview_scroll_up", mode = { "i", "n" } },
					["<c-d>"] = { "list_scroll_down", mode = { "i", "n" } },
					["<c-f>"] = { "preview_scroll_down", mode = { "i", "n" } },
					["<c-g>"] = { "toggle_live", mode = { "i", "n" } },
					["<c-j>"] = { "list_down", mode = { "i", "n" } },
					["<c-k>"] = { "list_up", mode = { "i", "n" } },
					["<c-n>"] = { "list_down", mode = { "i", "n" } },
					["<c-p>"] = { "list_up", mode = { "i", "n" } },
					["<c-q>"] = { "qflist", mode = { "i", "n" } },
					["<c-x>"] = { "edit_split", mode = { "i", "n" } },
					["<c-t>"] = { "tab", mode = { "n", "i" } },
					["<c-u>"] = { "list_scroll_up", mode = { "i", "n" } },
					["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
					["<c-r>#"] = { "insert_alt", mode = "i" },
					["<c-r>%"] = { "insert_filename", mode = "i" },
					["<c-r><c-a>"] = { "insert_cWORD", mode = "i" },
					["<c-r><c-f>"] = { "insert_file", mode = "i" },
					["<c-r><c-l>"] = { "insert_line", mode = "i" },
					["<c-r><c-p>"] = { "insert_file_full", mode = "i" },
					["<c-r><c-w>"] = { "insert_cword", mode = "i" },
					["<c-w>H"] = "layout_left",
					["<c-w>J"] = "layout_bottom",
					["<c-w>K"] = "layout_top",
					["<c-w>L"] = "layout_right",
					["?"] = "toggle_help_input",
					["G"] = "list_bottom",
					["gg"] = "list_top",
					["j"] = "list_down",
					["k"] = "list_up",
					["q"] = "cancel",
				},
				b = {
					minipairs_disable = true,
				},
			},
			-- result list window
			list = {
				keys = {
					["/"] = "toggle_focus",
					["<2-LeftMouse>"] = "confirm",
					["<CR>"] = "confirm",
					["<Down>"] = "list_down",
					["<Esc>"] = "cancel",
					["<S-CR>"] = { { "pick_win", "jump" } },
					["<S-Tab>"] = { "select_and_prev", mode = { "n", "x" } },
					["<Tab>"] = { "select_and_next", mode = { "n", "x" } },
					["<Up>"] = "list_up",
					["<a-d>"] = "inspect",
					["<a-f>"] = "toggle_follow",
					["<a-h>"] = "toggle_hidden",
					["<a-i>"] = "toggle_ignored",
					["<a-m>"] = "toggle_maximize",
					["<a-p>"] = "toggle_preview",
					["<a-w>"] = "cycle_win",
					["<c-a>"] = "select_all",
					["<c-b>"] = "preview_scroll_up",
					["<c-d>"] = "list_scroll_down",
					["<c-f>"] = "preview_scroll_down",
					["<c-j>"] = "list_down",
					["<c-k>"] = "list_up",
					["<c-n>"] = "list_down",
					["<c-p>"] = "list_up",
					["<c-q>"] = "qflist",
					["<c-g>"] = "print_path",
					["<c-s>"] = "edit_split",
					["<c-t>"] = "tab",
					["<c-u>"] = "list_scroll_up",
					["<c-v>"] = "edit_vsplit",
					["<c-w>H"] = "layout_left",
					["<c-w>J"] = "layout_bottom",
					["<c-w>K"] = "layout_top",
					["<c-w>L"] = "layout_right",
					["?"] = "toggle_help_list",
					["G"] = "list_bottom",
					["gg"] = "list_top",
					["i"] = "focus_input",
					["j"] = "list_down",
					["k"] = "list_up",
					["q"] = "cancel",
					["zb"] = "list_scroll_bottom",
					["zt"] = "list_scroll_top",
					["zz"] = "list_scroll_center",
				},
				wo = {
					conceallevel = 2,
					concealcursor = "nvc",
				},
			},
			-- preview window
			preview = {
				keys = {
					["<Esc>"] = "cancel",
					["q"] = "cancel",
					["i"] = "focus_input",
					["<a-w>"] = "cycle_win",
				},
			},
		},
		---@class snacks.picker.icons
		icons = {
			files = {
				enabled = true, -- show file icons
				dir = "󰉋 ",
				dir_open = "󰝰 ",
				file = "󰈔 ",
			},
			keymaps = {
				nowait = "󰓅 ",
			},
			tree = {
				vertical = "│ ",
				middle = "├╴",
				last = "└╴",
			},
			undo = {
				saved = " ",
			},
			ui = {
				live = "󰐰 ",
				hidden = "h",
				ignored = "i",
				follow = "f",
				selected = "● ",
				unselected = "○ ",
				-- selected = " ",
			},
			git = {
				-- 			added = "✅",
				-- 			changed = "🖊️",
				-- 			copied = "📋",
				-- 			deleted = "🗑️",
				-- 			renamed = "➡",
				-- 			unmerged = "🔄",
				-- 			untracked = "🆕",
				enabled = true, -- show git icons
				commit = "󰜘 ", -- used by git log
				staged = "●", -- staged changes. always overrides the type icons
				added = "✅",
				deleted = "🗑️",
				ignored = "I",
				modified = "🖊️",
				renamed = "➡",
				unmerged = "🔄 ",
				untracked = "🆕",
			},
			diagnostics = {
				Error = " ",
				Warn = " ",
				Hint = " ",
				Info = " ",
			},
			lsp = {
				unavailable = "",
				enabled = " ",
				disabled = " ",
				attached = "󰖩 ",
			},
			kinds = {
				Array = " ",
				Boolean = "󰨙 ",
				Class = " ",
				Color = " ",
				Control = " ",
				Collapsed = " ",
				Constant = "󰏿 ",
				Constructor = " ",
				Copilot = " ",
				Enum = " ",
				EnumMember = " ",
				Event = " ",
				Field = " ",
				File = " ",
				Folder = " ",
				Function = "󰊕 ",
				Interface = " ",
				Key = " ",
				Keyword = " ",
				Method = "󰊕 ",
				Module = " ",
				Namespace = "󰦮 ",
				Null = " ",
				Number = "󰎠 ",
				Object = " ",
				Operator = " ",
				Package = " ",
				Property = " ",
				Reference = " ",
				Snippet = "󱄽 ",
				String = " ",
				Struct = "󰆼 ",
				Text = " ",
				TypeParameter = " ",
				Unit = " ",
				Unknown = " ",
				Value = " ",
				Variable = "󰀫 ",
			},
		},
		---@class snacks.picker.db.Config
		db = {
			-- path to the sqlite3 library
			-- If not set, it will try to load the library by name.
			-- On Windows it will download the library from the internet.
			sqlite3_path = nil, ---@type string?
		},
		---@class snacks.picker.debug
		debug = {
			scores = false, -- show scores in the list
			leaks = false, -- show when pickers don't get garbage collected
			explorer = false, -- show explorer debug info
			files = false, -- show file debug info
			grep = false, -- show file debug info
			proc = false, -- show proc debug info
			extmarks = false, -- show extmarks errors
		},
	},
})

vim.keymap.set("n", "<leader>ff", function()
	Snacks.picker.files({
		finder = "files",
		format = "file",
		show_empty = true,
		hidden = true,
		ignored = false,
		follow = false,
		supports_live = true,
	})
end, { desc = "fuzzy find all files in pwd, including hidden files" })

vim.keymap.set("n", "<leader>fc", function()
	Snacks.picker.files({
		finder = "files",
		format = "file",
		show_empty = true,
		hidden = true,
		ignored = false,
		follow = false,
		supports_live = true,
		dirs = { "~/.config/nvim" },
	})
	-- telescope_builtin.find_files({ cwd = "~/.config/nvim" })
end, { desc = "fuzzy search over neovim config" })
vim.keymap.set("n", "<leader>fr", Snacks.picker.resume, { desc = "resume last picker search" })
vim.keymap.set("n", "<leader>fd", function()
	Snacks.picker.diagnostics()
end, { desc = "fuzzy find diagnostics" })
vim.keymap.set("n", "<leader>fb", function()
	Snacks.picker.buffers()
end, { desc = "fuzzy search all buffers" })
vim.keymap.set("n", "<leader>fw", function()
	Snacks.picker.grep()
end, { desc = "fuzzy search words" })
vim.keymap.set({ "n", "x" }, "<leader><leader>fw", function()
	Snacks.picker.grep_word()
end, { desc = "live grep for word under cursor" })

vim.keymap.set("n", "<leader>f/", Snacks.picker.lines, { desc = "Fuzzy find in current buffer" })

vim.keymap.set("n", "<leader>gb", function()
	Snacks.picker.git_branches({
		all = false,
		finder = "git_branches",
		format = "git_branch",
		preview = "git_log",
		confirm = "git_checkout",
		win = {
			input = {
				keys = {
					["<c-a>"] = { "git_branch_add", mode = { "n", "i" } },
					["<c-x>"] = { "git_branch_del", mode = { "n", "i" } },
				},
			},
		},
		---@param picker snacks.Picker
		on_show = function(picker)
			for i, item in ipairs(picker:items()) do
				if item.current then
					picker.list:view(i)
					Snacks.picker.actions.list_scroll_center(picker)
					break
				end
			end
		end,
	})
end, { desc = "fuzzy search git branches" })

vim.keymap.set("n", "<leader>gs", function()
	require("snacks.picker").git_diff({
		preview = "diff",
	})
	-- if vim.fn.system("git -C " .. vim.fn.getcwd(-1, 0) .. " status --porcelain") ~= "" then
	-- 	require("telescope.builtin").git_status({
	-- 		git_icons = {
	-- 			added = "✅",
	-- 			changed = "🖊️",
	-- 			copied = "📋",
	-- 			deleted = "🗑️",
	-- 			renamed = "➡",
	-- 			unmerged = "🔄",
	-- 			untracked = "🆕",
	-- 		},
	-- 		layout_strategy = "vertical",
	-- 		initial_mode = "normal",
	-- 	})
	-- else
	-- 	vim.notify("No git changes", vim.log.levels.WARN)
	-- end
end, { desc = "Git status" })

vim.keymap.set("n", "<leader>fh", function()
	local ft = vim.bo.filetype
	if ft == "markdown" then
		-- TODO: replace this with a snack picker
		vim.cmd("Telescope heading")
	else
		Snacks.picker.help()
	end
end, { desc = "fuzzy search vim help tags" })
