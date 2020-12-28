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
        diagnostics = {
            globals = {
                'vim',
                'hs',
                'spoon'
            },
        },
    },
}}
cmd 'au Filetype lua setlocal omnifunc=v:lua.vim.lsp.omnifunc'

-- python
lsp.pyright.setup{ on_attach = require'completion'.on_attach }
cmd 'au Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc'

-- viml
lsp.vimls.setup{ on_attach = require'completion'.on_attach }
cmd 'au Filetype vim setlocal omnifunc=v:lua.vim.lsp.omnifunc'
