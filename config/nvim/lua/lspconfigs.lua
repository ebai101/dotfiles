local cmd = vim.cmd
local lsp = require 'lspconfig'
local ts = require 'nvim-treesitter.configs'

-- treesitter
ts.setup { highlight = { enable = true } }

-- js
lsp.flow.setup{ on_attach = require'completion'.on_attach }

-- lua
lsp.sumneko_lua.setup{ on_attach = require'completion'.on_attach, settings = {
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
