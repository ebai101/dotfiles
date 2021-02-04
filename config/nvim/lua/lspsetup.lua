local lsp = require 'lspconfig'
local ts = require 'nvim-treesitter.configs'
local status = require 'lsp-status'
local completion = require 'completion'

-- init --
ts.setup { ensure_installed = 'maintained', highlight = { enable = true } }
status.register_progress()

local function on_attach_all(client)
    status.on_attach(client)
    completion.on_attach(client)
end

-- clangd
lsp.clangd.setup{ on_attach = require'completion'.on_attach }

-- lua
local sumneko_root = vim.env.HOME..'/dev/lua-language-server'
local sumneko_binary = sumneko_root..'/bin/Linux/lua-language-server'

lsp.sumneko_lua.setup{
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
lsp.pyright.setup{ on_attach = on_attach_all, settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                autoImportCompletions = true,
                useLibraryCodeForTypes = true,
            },
        },
}}

-- viml
lsp.vimls.setup{ on_attach = on_attach_all }

-- rust
lsp.rls.setup{ on_attach = on_attach_all }

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
