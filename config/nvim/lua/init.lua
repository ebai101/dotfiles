---------- INIT.LUA ----------

local cmd, fn, g = vim.cmd, vim.fn, vim.g
local scopes = { o = vim.o, b = vim.bo, w = vim.wo }
local home = os.getenv('HOME')

local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end

local function map(mode, lhs, rhs, opts)
    local options = {noremap= true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


---------- PLUGINS ----------

cmd 'packadd paq-nvim'
local paq = require('paq-nvim').paq
paq { 'savq/paq-nvim', opt = true }

-- colors
paq { 'gruvbox-community/gruvbox' }
paq { 'itchyny/lightline.vim' }
paq { 'shinchu/lightline-gruvbox.vim' }
paq { 'svermeulen/vimpeccable' }

-- enhancements
paq { 'tpope/vim-commentary' }
paq { 'tpope/vim-surround' }
paq { 'tpope/vim-obsession' }
paq { 'tpope/vim-repeat' }
paq { 'gko/vim-coloresque' }
paq { 'mbbill/undotree' }
paq { 'junegunn/fzf', hook = fn['fzf#install()'] }
paq { 'junegunn/fzf.vim' }

-- lsp/completion
paq { 'neovim/nvim-lspconfig' }
paq { 'nvim-lua/completion-nvim' }
paq { 'nvim-treesitter/nvim-treesitter' }
paq { 'sheerun/vim-polyglot' }
paq { 'ojroques/nvim-lspfuzzy' }

-- vimwiki
paq { 'vimwiki/vimwiki' }


---------- OPTS ----------

-- buffer scoped
local indent = 4
opt('b', 'tabstop', indent)
opt('b', 'softtabstop', indent)
opt('b', 'shiftwidth', 4)
opt('b', 'expandtab', true)
opt('b', 'smartindent', true)
opt('b', 'autoindent', true)
opt('b', 'swapfile', false)
opt('b', 'undofile', true)

-- global scoped
opt('o', 'hidden', true)
opt('o', 'errorbells', false)
opt('o', 'smartcase', true)
opt('o', 'splitbelow', true)
opt('o', 'splitright', true)
opt('o', 'backup', false)
opt('o', 'writebackup', false)
opt('o', 'undodir', home..'/.config/nvim/undodir')
opt('o', 'incsearch', true)
opt('o', 'cmdheight', 2)
opt('o', 'shortmess', 'filnxtToOFc')
opt('o', 'lazyredraw', true)
opt('o', 'autoread', true)
opt('o', 'mouse', 'a')
-- opt('o', 'showmode', false)
opt('o', 'inccommand', 'split')
opt('o', 'makeprg', 'ninja -Cbuild')
opt('o', 'termguicolors', true)

-- window scoped
opt('w', 'number', true)
opt('w', 'relativenumber', true)
opt('w', 'wrap', false)
opt('w', 'signcolumn', 'yes')

-- netrw
g['netrw_banner'] = 0
g['netrw_liststyle'] = 3
g['netrw_browse_split'] = 4
g['netrw_altv'] = 1
g['netrw_winsize'] = 20
g['mapleader'] = ' '

-- autocmds
cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'   -- highlight on yank
cmd 'au FileType c,cpp,cs,java setlocal commentstring=//\\ %s'          -- proper vim-commentary comments


---------- MAPPINGS ----------

-- window management
map('n', '<leader>h', ':wincmd h<cr>')
map('n', '<leader>j', ':wincmd j<cr>')
map('n', '<leader>k', ':wincmd k<cr>')
map('n', '<leader>l', ':wincmd l<cr>')
map('n', '<leader>pv', ':Lexplore<cr>')
map('n', '<leader>=', ':vertical resize +5<cr>')
map('n', '<leader>-', ':vertical resize -5<cr>')
map('n', '<leader>6', '<C-^>')
map('n', '<leader>', ':e ~/.config/nvim/lua/init.lua<cr>')
map('n', '<leader><', ':so ~/.config/nvim/init.vim<cr>')

-- text management
map('n', '<leader>o', 'm`o<Esc>``')         -- newline in normal mode
map('n', '<C-l>', ':noh<cr>')               -- clear search
map('v', 'J', ":m '>+1<CR>gv=gv")           -- move line down with indentation
map('v', 'K', ":m '<-2<CR>gv=gv")           -- move line up with indentation
map('x', '@', '<C-u>call ExecuteMacroOverVisualRange()<cr>')

-- fzf
map('n', '<leader>pf', ':Files<cr>')
map('n', '<leader>pg', ':GFiles<cr>')
map('n', '<leader>prf', ':Rg<cr>')
map('n', '<leader>pw', ':FWiki<cr>')
map('n', '<leader>prw', ':RgWiki<cr>')

-- misc
map('n', '<leader>5', ':make<cr>')
map('n', '<leader>u', ':UndotreeShow<cr>')


---------- LSP ----------

local lsp = require 'lspconfig'
local lspfuzzy = require 'lspfuzzy'

-- servers
lsp.flow.setup { on_attach = require'completion'.on_attach }
lsp.pyls_ms.setup { on_attach = require'completion'.on_attach }
lsp.sumneko_lua.setup { on_attach = require'completion'.on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    'vim',
                    'hs'
                },
            },
        },
    }
}
lspfuzzy.setup {}

opt('o', 'completeopt', 'menuone,noinsert,noselect')
g['completion_matching_strategy_list'] = { 'exact', 'substring', 'fuzzy' }

-- maps
map('i', '<S-Ta>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
map('i', '<silent> <C-p>', '<Plug>(completion_trigger)')


-- tree-sitter
local ts = require 'nvim-treesitter.configs'
ts.setup { ensure_installed = 'maintained', highlight = {enable = true} }


---------- COLORS ----------
cmd 'colorscheme gruvbox'
g['gruvbox_contrast_dark'] = 'hard'
g['gruvbox_contrast_light'] = 'light'
g['gruvbox_invert_selection'] = '0'
g['lightline'] = { colorscheme = 'gruvbox' }
cmd 'highlight Normal ctermbg=NONE guibg=NONE'
opt('o', 'background', 'dark')


---------- VIMWIKI ----------
g['vimwiki_list'] = {{
    path = '~/vimwiki',
    syntax = 'markdown',
    ext = '.md'
}}
g['vimwiki_global_ext'] = 0
cmd 'au FileType vimwiki set wm=2 tw=104 wrap linebreak'
cmd 'au FileType vimwiki setlocal shiftwidth=6 tabstop=6 noexpandtab'

-- todo: rewrite these in lua
cmd "command! -bang -nargs=* RgWiki call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1, {'dir': '~/vimwiki'}, <bang>0)"
cmd "command! -bang -nargs=* FWiki call fzf#vim#files('~/vimwiki')"
