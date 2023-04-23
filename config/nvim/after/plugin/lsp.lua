local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
    'lua_ls',
    'pyright'
})

lsp.configure('lua_ls', {
    settings = {
        Lua = {
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

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}
    vim.keymap.set('n', '<leader>vd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<leader>vh', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>vi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>jsh', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

lsp.setup()
