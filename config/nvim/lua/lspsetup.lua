local lsp = require 'lspconfig'
local ts = require 'nvim-treesitter.configs'

-- treesitter
ts.setup { ensure_installed = 'maintained', highlight = { enable = true } }

-- lua
local sumneko_root_path = '~/dev/lua-language-server'
local sumneko_binary = sumneko_root_path..'/bin/Linux'..'/lua-language-server'

lsp.sumneko_lua.setup{ on_attach = require'completion'.on_attach,
    cmd = {sumneko_binary, '-E', sumneko_root_path..'/main.lua'},
    settings = {
        Lua = {
            runtime = {
                version = 'Lua 5.1',
            },
            diagnostics = {
                globals = {
                    'vim',
                    'hs',
                    'spoon'
                },
            },
        },
}}

-- python
lsp.pyright.setup{ on_attach = require'completion'.on_attach, settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                autoImportCompletions = true,
                useLibraryCodeForTypes = true,
            },
        },
}}

-- viml
lsp.vimls.setup{ on_attach = require'completion'.on_attach }

-- gopls
lsp.gopls.setup{
    cmd = {'gopls', 'serve'},
    filetypes = {'go', 'gomod'},
    settings = {
        gopls = {
            analyses = {
                unusedparams = true
            },
            staticcheck = true
        },
    },
}

-- organize on save like goimports does
function lsp.organize_go_imports(timeoutms)
    local context = { source = { organizeImports = true } }
    vim.validate { context = { context, "t", true } }

    local params = vim.lsp.util.make_range_params()
    params.context = context

    local method = "textDocument/codeAction"
    local resp = vim.lsp.buf_request_sync(0, method, params, timeoutms)
    if resp and resp[1] then
        local result = resp[1].result
        if result and result[1] then
            local edit = result[1].edit
            vim.lsp.util.apply_workspace_edit(edit)
        end
    end

    vim.lsp.buf.formatting()
end
vim.cmd('au BufWritePre *.go lua require"lspconfig".organize_go_imports(1000)')
