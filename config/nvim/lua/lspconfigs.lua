local lsp = require 'lspconfig'
local ts = require 'nvim-treesitter.configs'

lsp.flow.setup{ on_attach = require'completion'.on_attach }
lsp.sumneko_lua.setup{ on_attach = require'completion'.on_attach, settings = {
    Lua = {
        diagnostics = {
            globals = {
                'vim',
                'hs',
                'spoon'
            },
        },
    },
}}
lsp.pyright.setup{ on_attach = require'completion'.on_attach }
ts.setup { highlight = { enable = true } }
