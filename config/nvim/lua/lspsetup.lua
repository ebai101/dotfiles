local lsp = require 'lspconfig'
local ts = require 'nvim-treesitter.configs'
local status = require 'lsp-status'
local cmp = require'cmp'

-- init --
ts.setup { ensure_installed = 'all', highlight = { enable = true } }
status.register_progress()

-- local function on_attach_all(client)
--     status.on_attach(client)
--     cmp.on_attach(client)
-- end

cmp.setup({
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end,
        },
        window = {
            completion = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
        sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'vsnip' },
            }, {
                { name = 'buffer' },
            })
    })

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
    })

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- lua
local system_name
if vim.fn.has("mac") == 1 then
    system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
    system_name = "Linux"
end

local sumneko_root = vim.env.HOME..'/dev/lua-language-server'
local sumneko_binary = sumneko_root.."/bin/"..system_name.."/lua-language-server"

lsp.sumneko_lua.setup{
    capabilities = capabilities,
    on_attach = on_attach_all,
    cmd = {sumneko_binary, '-E', sumneko_root..'/main.lua'},
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
lsp.pyright.setup{
    capabilities = capabilities,
    on_attach = on_attach_all,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                autoImportCompletions = true,
                useLibraryCodeForTypes = true,
            },
        },
}}

-- diagnosticls
lsp.diagnosticls.setup{
    on_attach = on_attach_all,
    filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact"},
    init_options = {
        linters = {
            eslint = {
                sourcename = "eslint",
                command = './node_modules/.bin/eslint',
                rootPatterns = { '.git' },
                debounce = 100,
                args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
                sourceName = 'eslint',
                parseJson = {
                    errorsRoot = '[0].messages',
                    line = 'line',
                    column = 'column',
                    endLine = 'endLine',
                    endColumn = 'endColumn',
                    message = '${message} [${ruleId}]',
                    security = 'severity'
                },
                securities = {
                    [2] = 'error',
                    [1] = 'warning'
                }
            }
        },
        filetypes = {
            javascript = 'eslint',
            javascriptreact = 'eslint',
            typescript = 'eslint',
            typescriptreact = 'eslint',
        },
        formatters = {
            prettierEslint = {
                command = './node_modules/.bin/prettier-eslint',
                args = { '--stdin' },
                rootPatterns = { '.git' },
            },
            prettier = {
                command = './node_modules/.bin/prettier',
                args = { '--stdin-filepath', '%filename' }
            }
        },
        formatFiletypes = {
            javascript = 'prettierEslint',
            javascriptreact = 'prettierEslint',
            json = 'prettier',
            typescript = 'prettierEslint',
            typescriptreact = 'prettierEslint'
        }
    }
}
