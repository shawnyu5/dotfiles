local blink = require("blink-cmp")

local config = {
	keymap = {
		preset = "default",
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide" },
		["<C-y>"] = { "select_and_accept" },
		["<CR>"] = { "accept", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<Tab>"] = { "select_next", "fallback" },
		["<C-n>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback" },
		["<Up>"] = { "select_prev", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },
		["<C-k>"] = { "snippet_forward", "fallback" },
		["<C-j>"] = { "snippet_backward", "fallback" },
	},

	snippets = {
		-- Function to use when expanding LSP provided snippets
		expand = function(snippet)
			require("luasnip").lsp_expand(snippet)
		end,
		-- Function to use when checking if a snippet is active
		active = function(filter)
			if filter and filter.direction then
				return require("luasnip").jumpable(filter.direction)
			end
			return require("luasnip").in_snippet()
		end,
		jump = function(direction)
			require("luasnip").jump(direction)
		end,
	},

	completion = {
		list = {
			-- Maximum number of items to display
			max_items = 200,
			-- Controls if completion items will be selected automatically,
			-- and whether selection automatically inserts
			selection = "auto_insert",
			-- Controls how the completion items are selected
			-- 'preselect' will automatically select the first item in the completion list
			-- 'manual' will not select any item by default
			-- 'auto_insert' will not select any item by default, and insert the completion items automatically
			-- when selecting them
			--
			-- You may want to bind a key to the `cancel` command, which will undo the selection
			-- when using 'auto_insert'
			cycle = {
				-- When `true`, calling `select_next` at the *bottom* of the completion list
				-- will select the *first* completion item.
				from_bottom = true,
				-- When `true`, calling `select_prev` at the *top* of the completion list
				-- will select the *last* completion item.
				from_top = true,
			},
		},

		documentation = {
			-- Controls whether the documentation window will automatically show when selecting a completion item
			auto_show = true,
			-- Delay before showing the documentation window
			auto_show_delay_ms = 50,
			-- Delay before updating the documentation window when selecting a new item,
			-- while an existing item is still visible
			update_delay_ms = 50,
			-- Whether to use treesitter highlighting, disable if you run into performance issues
			treesitter_highlighting = true,
			window = {
				min_width = 10,
				max_width = 60,
				max_height = 20,
				border = "padded",
				winblend = 0,
				winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
				-- Note that the gutter will be disabled when border ~= 'none'
				scrollbar = true,
				-- Which directions to show the documentation window,
				-- for each of the possible menu window directions,
				-- falling back to the next direction when there's not enough space
				direction_priority = {
					menu_north = { "e", "w", "n", "s" },
					menu_south = { "e", "w", "s", "n" },
				},
			},
		},
		-- Displays a preview of the selected item on the current line
		ghost_text = {
			enabled = true,
		},
	},

	-- Experimental signature help support
	signature = {
		enabled = true,
		trigger = {
			blocked_trigger_characters = {},
			blocked_retrigger_characters = {},
			-- When true, will show the signature help window when the cursor comes after a trigger character when entering insert mode
			show_on_insert_on_trigger_character = true,
		},
		window = {
			min_width = 1,
			max_width = 100,
			max_height = 20,
			border = "padded",
			winblend = 0,
			winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
			scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
			-- Which directions to show the window,
			-- falling back to the next direction when there's not enough space,
			-- or another window is in the way
			direction_priority = { "n", "s" },
			-- Disable if you run into performance issues
			treesitter_highlighting = true,
		},
	},

	sources = {
		completion = {
			-- Static list of providers to enable, or a function to dynamically enable/disable providers based on the context
			enabled_providers = { "lsp", "luasnip", "snippets", "buffer" },
		},

		providers = {
			-- TODO: this source doesnt seem to work...
			tmux = {
				name = "tmux",
				module = "blink.compat.source",
				score_offset = -3,
				opts = {
					all_panes = false,
					label = "[tmux]",
					trigger_characters = { "." },
					trigger_characters_ft = {}, -- { filetype = { '.' } }
				},
			},
			lsp = {
				name = "LSP",
				module = "blink.cmp.sources.lsp",

				--- *All* of the providers have the following options available
				--- NOTE: All of these options may be functions to get dynamic behavior
				--- See the type definitions for more information.
				--- Check the enabled_providers config for an example
				enabled = true, -- Whether or not to enable the provider
				transform_items = nil, -- Function to transform the items before they're returned
				should_show_items = true, -- Whether or not to show the items
				max_items = nil, -- Maximum number of items to display in the menu
				min_keyword_length = 0, -- Minimum number of characters in the keyword to trigger the provider
				fallback_for = {}, -- If any of these providers return 0 items, it will fallback to this provider
				score_offset = 0, -- Boost/penalize the score of the items
				override = nil, -- Override the source's functions
			},
		},
	},

	appearance = {
		highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
		-- Sets the fallback highlight groups to nvim-cmp's highlight groups
		-- Useful for when your theme doesn't support blink.cmp
		-- Will be removed in a future release
		use_nvim_cmp_as_default = false,
		-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- Adjusts spacing to ensure icons are aligned
		nerd_font_variant = "mono",
		kind_icons = {
			Text = "󰉿",
			Method = "󰊕",
			Function = "󰊕",
			Constructor = "󰒓",

			Field = "󰜢",
			Variable = "󰆦",
			Property = "󰖷",

			Class = "󱡠",
			Interface = "󱡠",
			Struct = "󱡠",
			Module = "󰅩",

			Unit = "󰪚",
			Value = "󰦨",
			Enum = "󰦨",
			EnumMember = "󰦨",

			Keyword = "󰻾",
			Constant = "󰏿",

			Snippet = "󱄽",
			Color = "󰏘",
			File = "󰈔",
			Reference = "󰬲",
			Folder = "󰉋",
			Event = "󱐋",
			Operator = "󰪚",
			TypeParameter = "󰬛",
		},
	},
}

local utils = require("shawn.utils")
if utils.get_system_config().system_name == utils.system_names.work_laptop then
	config.sources.providers["copilot"] = {
		name = "copilot",
		module = "blink-cmp-copilot",
	}
	table.insert(config.sources.completion.enabled_providers, "copilot")
end

blink.setup(config)
