vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- Setup nvim-cmp.
local ok, cmp = pcall(require, "cmp")
if not ok then
	print("cmp not installed...")
	return
end

-- local lspkind = require "lspkind"
-- lspkind.init()

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }), -- manual trigger completion when needed
	}),
	sources = {
		{ name = "copilot" },
		{ name = "git" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "ultisnips" }, -- For ultisnips users.
		{ name = "path" },
		{ name = "buffer" },
		{
			name = "tmux",
			option = {
				all_panes = false,
				label = "[tmux]",
				trigger_characters = { "." },
				trigger_characters_ft = {}, -- { filetype = { '.' } }
			},
		},
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.menu = ({
				copilot = "[copilot]",
				git = "[git]",
				nvim_lsp = "[Lsp]",
				nvim_lua = "[Lua]",
				ultisnips = "[Snippets]",
				buffer = "[Buffer]",
				path = "[Path]",
				tmux = "[Tmux]",
			})[entry.source.name]
			return vim_item
		end,
	},
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
})

cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

local format = require("cmp_git.format")
local sort = require("cmp_git.sort")

require("cmp_git").setup({
	-- defaults
	filetypes = { "gitcommit", "octo" },
	remotes = { "upstream", "origin" }, -- in order of most to least prioritized
	enableRemoteUrlRewrites = false, -- enable git url rewrites, see https://git-scm.com/docs/git-config#Documentation/git-config.txt-urlltbasegtinsteadOf
	git = {
		commits = {
			limit = 100,
			sort_by = sort.git.commits,
			format = format.git.commits,
		},
	},
	github = {
		issues = {
			fields = { "title", "number", "body", "updatedAt", "state" },
			filter = "all", -- assigned, created, mentioned, subscribed, all, repos
			limit = 100,
			state = "open", -- open, closed, all
			sort_by = sort.github.issues,
			format = format.github.issues,
		},
		mentions = {
			limit = 100,
			sort_by = sort.github.mentions,
			format = format.github.mentions,
		},
		pull_requests = {
			fields = { "title", "number", "body", "updatedAt", "state" },
			limit = 100,
			state = "open", -- open, closed, merged, all
			sort_by = sort.github.pull_requests,
			format = format.github.pull_requests,
		},
	},
	gitlab = {
		issues = {
			limit = 100,
			state = "opened", -- opened, closed, all
			sort_by = sort.gitlab.issues,
			format = format.gitlab.issues,
		},
		mentions = {
			limit = 100,
			sort_by = sort.gitlab.mentions,
			format = format.gitlab.mentions,
		},
		merge_requests = {
			limit = 100,
			state = "opened", -- opened, closed, locked, merged
			sort_by = sort.gitlab.merge_requests,
			format = format.gitlab.merge_requests,
		},
	},
	trigger_actions = {
		{
			debug_name = "git_commits",
			trigger_character = ":",
			action = function(sources, trigger_char, callback, params, git_info)
				return sources.git:get_commits(callback, params, trigger_char)
			end,
		},
		{
			debug_name = "gitlab_issues",
			trigger_character = "#",
			action = function(sources, trigger_char, callback, params, git_info)
				return sources.gitlab:get_issues(callback, git_info, trigger_char)
			end,
		},
		{
			debug_name = "gitlab_mentions",
			trigger_character = "@",
			action = function(sources, trigger_char, callback, params, git_info)
				return sources.gitlab:get_mentions(callback, git_info, trigger_char)
			end,
		},
		{
			debug_name = "gitlab_mrs",
			trigger_character = "!",
			action = function(sources, trigger_char, callback, params, git_info)
				return sources.gitlab:get_merge_requests(callback, git_info, trigger_char)
			end,
		},
		{
			debug_name = "github_issues_and_pr",
			trigger_character = "#",
			action = function(sources, trigger_char, callback, params, git_info)
				return sources.github:get_issues_and_prs(callback, git_info, trigger_char)
			end,
		},
		{
			debug_name = "github_mentions",
			trigger_character = "@",
			action = function(sources, trigger_char, callback, params, git_info)
				return sources.github:get_mentions(callback, git_info, trigger_char)
			end,
		},
	},
})

-- cmp.setup.cmdline(":", {
-- sources = cmp.config.sources({
-- { name = "path" },
-- }, {
-- { name = "cmdline", keyword_length = 5 },
-- }),
-- })
