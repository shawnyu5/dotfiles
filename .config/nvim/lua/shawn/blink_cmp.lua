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
			selection = "auto_insert",
		},

		menu = {
			-- Controls whether the documentation window will automatically show when selecting a completion item
			auto_show = true,
		},
		-- Displays a preview of the selected item on the current line
		ghost_text = {
			enabled = true,
		},
	},

	-- Experimental signature help support
	signature = {
		enabled = true,
	},

	sources = {
		default = { "lsp", "path", "luasnip", "snippets", "buffer" },

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
				fallbacks = {},
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
	-- table.insert(config.sources.completion.enabled_providers, "copilot")
end

blink.setup(config)
