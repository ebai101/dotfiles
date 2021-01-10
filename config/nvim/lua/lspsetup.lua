local lsp = require 'lspconfig'
local ts = require 'nvim-treesitter.configs'

-- treesitter
ts.setup { ensure_installed = 'maintained', highlight = { enable = true } }

-- js
lsp.flow.setup{ on_attach = require'completion'.on_attach }

-- lua
local sumneko_root_path = '/Volumes/FilesHDD/CODE/lua-language-server'
local sumneko_binary = sumneko_root_path..'/bin/macOS'..'/lua-language-server'

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
