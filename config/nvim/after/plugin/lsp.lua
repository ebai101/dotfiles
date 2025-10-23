local lsp = require('lsp-zero')

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    lsp.buffer_autoformat()

    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.rename, opts)
end)

require('mason').setup({})

require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'pyright' },
    handlers = {
        function(server_name)
            vim.lsp.config[server_name].setup({})
        end,
        lua_ls = function()
            vim.lsp.config.lua_ls.setup({
                settings = {
                    Lua = {
                        format = {
                            enable = true,
                            defaultConfig = {
                                indent_style = 'space',
                                indent_size = '4',
                                quote_style = 'single'
                            }
                        },
                        diagnostics = {
                            disable = {
                                'redefined-local',
                                'unused-local',
                                'lowercase-global',
                                'unused-function'
                            },
                            globals = {
                                'hs',
                                'spoon',
                                'vim',
                                'printError',
                                'sleep',
                                'read',
                                'write',
                                'print',
                                'colours',
                                'colors',
                                'commands',
                                'disk',
                                'fs',
                                'gps',
                                'help',
                                'http',
                                'paintutils',
                                'parallel',
                                'peripheral',
                                'rednet',
                                'redstone',
                                'keys',
                                'settings',
                                'shell',
                                'multishell',
                                'term',
                                'textutils',
                                'turtle',
                                'pocket',
                                'vector',
                                'bit32',
                                'window',
                                '_CC_DEFAULT_SETTINGS',
                                '_HOST',
                                '_VERSION',
                                '_'
                            }
                        },
                        runtime = {
                            version = 'Lua 5.1'
                        }
                    }
                }
            })
        end
    }
})
