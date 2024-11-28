local blink = require("blink-cmp")

blink.setup({
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

	accept = {
		create_undo_point = true,
		-- Function used to expand snippets, for luasnip users, you may use::
		-- function(snippet) require('luasnip').lsp_expand(snippet) end
		-- See the "Luasnip" section for info on setting up the luasnip source
		expand_snippet = function(snippet)
			require("luasnip").lsp_expand(snippet)
		end,

		sources = {
			completion = {
				-- WARN: add the rest of your providers here, unless you're using `opts_extend`
				-- and defining this outside of your primary `blink.cmp` config
				-- see the default configuration for the default providers
				enabled_providers = { "luasnip", "lsp", "path", "buffer" },
			},
			providers = {
				luasnip = {
					name = "luasnip",
					module = "blink.compat.source",

					score_offset = 1,

					opts = {
						use_show_condition = false,
						show_autosnippets = true,
					},
				},

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
					--- See the type definitions for more information
					enabled = true, -- whether or not to enable the provider
					transform_items = nil, -- function to transform the items before they're returned
					should_show_items = true, -- whether or not to show the items
					max_items = nil, -- maximum number of items to return
					min_keyword_length = 0, -- minimum number of characters to trigger the provider
					fallback_for = {}, -- if any of these providers return 0 items, it will fallback to this provider
					score_offset = 0, -- boost/penalize the score of the items
					override = nil, -- override the source's functions
				},
				path = {
					name = "Path",
					module = "blink.cmp.sources.path",
					score_offset = 3,
					opts = {
						trailing_slash = false,
						label_trailing_slash = true,
						get_cwd = function(context)
							return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
						end,
						show_hidden_files_by_default = false,
					},
				},

				auto_brackets = {
					enabled = false,
					default_brackets = { "(", ")" },
					override_brackets_for_filetypes = {},
					-- Overrides the default blocked filetypes
					force_allow_filetypes = {},
					blocked_filetypes = {},
					-- Synchronously use the kind of the item to determine if brackets should be added
					kind_resolution = {
						enabled = true,
						blocked_filetypes = { "typescriptreact", "javascriptreact", "vue" },
					},
					-- Asynchronously use semantic token to determine if brackets should be added
					semantic_token_resolution = {
						enabled = true,
						blocked_filetypes = {},
						-- How long to wait for semantic tokens to return before assuming no brackets should be added
						timeout_ms = 400,
					},
				},
			},
		},
	},
	trigger = {
		completion = {
			-- 'prefix' will fuzzy match on the text before the cursor
			-- 'full' will fuzzy match on the text before *and* after the cursor
			-- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
			keyword_range = "full",
			-- regex used to get the text when fuzzy matching
			-- changing this may break some sources, so please report if you run into issues
			-- TODO: shouldnt this also affect the accept command? should this also be per language?
			keyword_regex = "[%w_\\-]",
			-- after matching with keyword_regex, any characters matching this regex at the prefix will be excluded
			exclude_from_prefix_regex = "[\\-]",
			-- LSPs can indicate when to show the completion window via trigger characters
			-- however, some LSPs (i.e. tsserver) return characters that would essentially
			-- always show the window. We block these by default
			blocked_trigger_characters = { " ", "\n", "\t" },
			-- when true, will show the completion window when the cursor comes after a trigger character after accepting an item
			show_on_accept_on_trigger_character = true,
			-- when true, will show the completion window when the cursor comes after a trigger character when entering insert mode
			show_on_insert_on_trigger_character = true,
			-- list of additional trigger characters that won't trigger the completion window when the cursor comes after a trigger character when entering insert mode/accepting an item
			show_on_x_blocked_trigger_characters = { "'", '"', "(" },
			-- when false, will not show the completion window automatically when in a snippet
			show_in_snippet = true,
		},

		signature_help = {
			enabled = true,
			blocked_trigger_characters = {},
			blocked_retrigger_characters = {},
			-- when true, will show the signature help window when the cursor comes after a trigger character when entering insert mode
			show_on_insert_on_trigger_character = true,
		},
	},

	windows = {
		autocomplete = {
			min_width = 15,
			max_height = 10,
			border = "none",
			winblend = 0,
			winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
			-- keep the cursor X lines away from the top/bottom of the window
			scrolloff = 2,
			-- note that the gutter will be disabled when border ~= 'none'
			scrollbar = true,
			-- which directions to show the window,
			-- falling back to the next direction when there's not enough space
			direction_priority = { "s", "n" },
			-- Controls whether the completion window will automatically show when typing
			auto_show = true,
			-- Controls how the completion items are selected
			-- 'preselect' will automatically select the first item in the completion list
			-- 'manual' will not select any item by default
			-- 'auto_insert' will not select any item by default, and insert the completion items automatically when selecting them
			--
			-- When using 'auto_insert', you may want to bind a key to the `cancel` command, which will undo the selection
			selection = "auto_insert",
			-- Controls how the completion items are rendered on the popup window
			draw = {
				-- Aligns the keyword you've typed to a component in the menu
				align_to_component = "label", -- or 'none' to disable
				-- Left and right padding, optionally { left, right } for different padding on each side
				padding = 1,
				-- Gap between columns
				gap = 1,

				-- Components to render, grouped by column
				columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
				-- for a setup similar to nvim-cmp: https://github.com/Saghen/blink.cmp/pull/245#issuecomment-2463659508
				-- columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },

				-- Definitions for possible components to render. Each component defines:
				--   ellipsis: whether to add an ellipsis when truncating the text
				--   width: control the min, max and fill behavior of the component
				--   text function: will be called for each item
				--   highlight function: will be called only when the line appears on screen
				components = {
					kind_icon = {
						ellipsis = false,
						text = function(ctx)
							return ctx.kind_icon .. ctx.icon_gap
						end,
						highlight = function(ctx)
							return (require("blink.cmp.utils").get_tailwind_hl(ctx) or "BlinkCmpKind") .. ctx.kind
						end,
					},

					kind = {
						ellipsis = false,
						width = { fill = true },
						text = function(ctx)
							return ctx.kind
						end,
						highlight = function(ctx)
							return (require("blink.cmp.utils").get_tailwind_hl(ctx) or "BlinkCmpKind") .. ctx.kind
						end,
					},

					label = {
						width = { fill = true, max = 60 },
						text = function(ctx)
							return ctx.label .. ctx.label_detail
						end,
						highlight = function(ctx)
							-- label and label details
							local highlights = {
								{
									0,
									#ctx.label,
									group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel",
								},
							}
							if ctx.label_detail then
								table.insert(
									highlights,
									{ #ctx.label, #ctx.label + #ctx.label_detail, group = "BlinkCmpLabelDetail" }
								)
							end

							-- characters matched on the label by the fuzzy matcher
							for _, idx in ipairs(ctx.label_matched_indices) do
								table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
							end

							return highlights
						end,
					},

					label_description = {
						width = { max = 30 },
						text = function(ctx)
							return ctx.label_description
						end,
						highlight = "BlinkCmpLabelDescription",
					},
				},
			},
			-- Controls the cycling behavior when reaching the beginning or end of the completion list.
			cycle = {
				-- When `true`, calling `select_next` at the *bottom* of the completion list will select the *first* completion item.
				from_bottom = true,
				-- When `true`, calling `select_prev` at the *top* of the completion list will select the *last* completion item.
				from_top = true,
			},
		},
		documentation = {
			-- Controls whether the documentation window will automatically show when selecting a completion item
			auto_show = true,
			-- Delay before showing the documentation window
			auto_show_delay_ms = 50,
			update_delay_ms = 50,

			min_width = 10,
			max_width = 60,
			max_height = 20,
			border = "padded",
			winblend = 0,
			winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
			-- note that the gutter will be disabled when border ~= 'none'
			scrollbar = true,
			-- which directions to show the documentation window,
			-- for each of the possible autocomplete window directions,
			-- falling back to the next direction when there's not enough space
			direction_priority = {
				autocomplete_north = { "e", "w", "n", "s" },
				autocomplete_south = { "e", "w", "s", "n" },
			},
			-- whether to use treesitter highlighting, disable if you run into performance issues
			treesitter_highlighting = true,
		},
		signature_help = {
			min_width = 1,
			max_width = 100,
			max_height = 10,
			border = "padded",
			winblend = 0,
			winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
			-- note that the gutter will be disabled when border ~= 'none'
			scrollbar = false,

			-- which directions to show the window,
			-- falling back to the next direction when there's not enough space
			direction_priority = { "n", "s" },
			-- whether to use treesitter highlighting, disable if you run into performance issues
			treesitter_highlighting = true,
		},
		-- Displays a preview of the selected item on the current line
		ghost_text = {
			enabled = true,
		},
	},
})
