vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- Setup nvim-cmp.
local cmp = require'cmp'

-- local lspkind = require "lspkind"
-- lspkind.init()

cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
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
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = "nvim_lua" },
        { name = "path" },
        { name = 'ultisnips' }, -- For ultisnips user.
        { name = 'buffer'},
        -- would like instant completion, no keyword_length
        -- { name = 'buffer', keyword_length = 3 },
    }),

    formatting = {
        -- Youtube: How to set up nice formatting for your sources.
        -- format = lspkind.cmp_format {
            -- with_text = false,
    },
}

cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})
