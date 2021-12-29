local source = require "cmp_buffer.source"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- Setup nvim-cmp.
local cmp = require'cmp'

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end
--
-- local lspkind = require "lspkind"
-- lspkind.init()

cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    mapping = {
        -- ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping({
            c = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                else
                    fallback()
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                    vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
                else
                    fallback()
                end
            end,
            s = function(fallback)
                if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                    vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
                else
                    fallback()
                end
            end
        }),
        ["<S-Tab>"] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                else
                    cmp.complete()
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                    return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
                else
                    fallback()
                end
            end,
            s = function(fallback)
                if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                    return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
                else
                    fallback()
                end
            end
        }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = "nvim_lua" },
        { name = "path" },
        { name = 'ultisnips' }, -- For ultisnips users.
        { name = 'buffer'},
        {
            name = 'tmux',
            option = {
                all_panes = false,
                label = '[tmux]',
                trigger_characters = { '.' },
                trigger_characters_ft = {} -- { filetype = { '.' } }
            }
        },
    },

    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                nvim_lsp = '[Lsp]',
                nvim_lua = "[Lua]",
                ultisnips = "[Snippets]",
                buffer = "[Buffer]",
                path = "[Path]",
                tmux = '[Tmux]'
            })[entry.source.name]
            return vim_item
        end
    },
    experimental = {
        ghost_text = false,
        native_menu = false
    }
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
