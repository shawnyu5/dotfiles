vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- Setup nvim-cmp.
local cmp = require'cmp'

-- local lspkind = require "lspkind"
-- lspkind.init()

cmp.setup {
    -- snippet = {
    -- expand = function(args)
    -- -- For `vsnip` user.
    -- vim.fn["vsnip#anonymous"](args.body)

    -- -- For `luasnip` user.
    -- -- require('luasnip').lsp_expand(args.body)

    -- -- For `ultisnips` user.
    -- -- vim.fn["UltiSnips#Anon"](args.body)
    -- end,
    -- },
    mapping = {
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
    },
    -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- ['<C-Space>'] = cmp.mapping.complete(),
    -- ['<C-e>'] = cmp.mapping.close(),
    -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
    sources = {
        { name = 'nvim_lsp' },

        { name = "nvim_lua" },
        -- { name = "zsh" },

        { name = "path" },
        -- For vsnip user.
        -- { name = 'vsnip' },

        -- For luasnip user.
        -- { name = 'luasnip' },

        -- For ultisnips user.
        -- { name = 'ultisnips' },

        { name = 'buffer', keyword_length = 3 },
    },

    formatting = {
        -- Youtube: How to set up nice formatting for your sources.
        -- format = lspkind.cmp_format {
            -- with_text = true,
            -- menu = {
                -- buffer = "[buf]",
                -- nvim_lsp = "[LSP]",
                -- nvim_lua = "[api]",
                -- path = "[path]",
            -- },
        -- },
    },
    experimental = {
        -- use new menu
        native_menu = false,

        ghost_text = false,
    },
}

-- Setup lspconfig.
-- require('lspconfig')[%YOUR_LSP_SERVER%].setup {
    -- capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- }
