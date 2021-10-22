local lsp = require("lspconfig")


local on_attach = function(_, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    local opts = {
        noremap = true,
        silent = true
    }

    require "lsp_signature".on_attach()

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'H', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<leader>h', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)     -- does not work for some reason
    -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
    -- opts)
    -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>',
    -- opts)
    -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- opts)
    -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    -- buf_set_keymap('n', '<space>q',
    -- '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    -- show line diagnostics instead of virtual text
    -- vim.api.nvim_command("autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()({ focusable = false })")

end

-- LSP Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] =
vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = false,
    virtual_text = {
        spacing = 4,
        prefix = "●"
    },
    severity_sort = true
})

local signs = {
    Error = " ",
    Warning = " ",
    Hint = " ",
    Information = " "
}

for type, icon in pairs(signs) do
    local hl = "LspDiagnosticsSign" .. type
    vim.fn.sign_define(hl, {
        text = icon,
        texthl = hl,
        numhl = ""
    })
end
-- nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
-- nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
-- nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
-- nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
-- nnoremap <silent> <S-h> <cmd>lua vim.lsp.buf.hover()<CR>
-- "nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
-- "nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
-- "nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

-- ccls set up
-- unable to build ccls successfully
-- lsp.ccls.setup{
    -- on_attach = on_attach
-- }

-- clangd
require'lspconfig'.clangd.setup{
    on_attach = on_attach,
    filetypes = { "c", "cpp", "objc", "objcpp" }
}

-- bashls
lsp.bashls.setup{
    on_attach = on_attach
}

-- html
--Enable (broadcasting) snippet capability for completion
local capabilities_html = vim.lsp.protocol.make_client_capabilities()
capabilities_html.textDocument.completion.completionItem.snippetSupport = true


require'lspconfig'.html.setup {
    on_attach = on_attach,
    capabilities = capabilities_html,
}

-- tsserver
lsp.tsserver.setup{
    on_attach = on_attach
}

-- sumneko lua
-- local system_name
if vim.fn.has("mac") == 1 then
    -- system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
    -- system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
    -- system_name = "Windows"
else
    print("Unsupported system for sumneko")
end


-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local home_dir = vim.fn.expand("~")
local sumneko_root_path = home_dir .. "/.local/share/nvim/lsp_servers/lua-language-server/" -- require access to main.lua in root directory
local sumneko_binary = sumneko_root_path .. "bin/Linux/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lsp.sumneko_lua.setup {
    on_attach = on_attach,
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "main.lua"};
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },

    -- pyright
    -- npm install -g pyright
    require'lspconfig'.pyright.setup{
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" }
    }

}

vim.cmd[[
    hi LspDiagnosticsUnderlineError guifg=red gui=bold,underline
    hi LspDiagnosticsUnderlineWarning guifg=yellow gui=italic,underline
    hi LspDiagnosticsUnderlineInformation guifg=white gui=bold,underline
    hi LspDiagnosticsUnderlineHint guifg=blue
]]
