" init.vim

luafile ~/.config/nvim/lua/init.lua

" set hidden
" set noerrorbells
" set tabstop=4 softtabstop=4
" set shiftwidth=4
" set expandtab
" set smartindent
" set autoindent
" set nu rnu
" set nowrap
" set smartcase
" set noswapfile
" set nobackup
" set nowritebackup
" set undodir=~/.config/nvim/undodir
" set undofile
" set incsearch
" set cmdheight=2
" set updatetime=300
" set shortmess+=c
" set lazyredraw
" set autoread
" set splitbelow
" set splitright
" set mouse=a
" set noshowmode
" set signcolumn=yes
" set inccommand=split

" leader boi
" let mapleader = " "

" clear stuff
" nnoremap <leader>/ :let @/ = ""<CR>
" nnoremap <leader>dws :%s/\s\+$//e<CR>

" visual range macro
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
endfunction

" netrw boi
" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
" let g:netrw_winsize = 20

" window stuff
" nnoremap <leader>h :wincmd h<CR>
" nnoremap <leader>j :wincmd j<CR>
" nnoremap <leader>k :wincmd k<CR>
" nnoremap <leader>l :wincmd l<CR>
" nnoremap <leader>pv :Lexplore<CR>
" nnoremap <leader>= :vertical resize +5<CR>
" nnoremap <leader>- :vertical resize -5<CR>
" nnoremap <leader>6 <C-^>

" move stuff around
" vnoremap J :m '>+1<CR>gv=gv
" vnoremap K :m '<-2<CR>gv=gv

" preferences
" if has('nvim')
"     nnoremap <leader>, :e ~/.config/nvim/init.vim<CR>
" else
"     nnoremap <leader>, :e ~/.vimrc<CR>
" endif

" readline keybinds in command mode (from rsi.vim)
" cnoremap <C-A> <Home>
" cnoremap <C-B> <Left>
" cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
" cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
" cnoremap <M-b> <S-Left>
" cnoremap <M-f> <S-Right>
" silent! exe "set <S-Left>=\<Esc>b"
" silent! exe "set <S-Right>=\<Esc>f"

" auto-install vim-plug if not found
" if empty(glob('~/.vim/autoload/plug.vim'))
"     silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"         \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"     autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif

" plug list
" call plug#begin('~/.vim/plugged')
" Plug 'gruvbox-community/gruvbox'
" Plug 'itchyny/lightline.vim'
" Plug 'shinchu/lightline-gruvbox.vim'
" Plug 'svermeulen/vimpeccable'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
" Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-surround'
" Plug 'tpope/vim-obsession'
" Plug 'tpope/vim-repeat'
" Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-lua/completion-nvim'
" Plug 'sheerun/vim-polyglot'
" Plug 'gko/vim-coloresque'
" Plug 'mbbill/undotree'
" Plug 'vimwiki/vimwiki'
" call plug#end()

" colors
" colorscheme gruvbox
" let g:gruvbox_contrast_dark = 'hard'
" let g:gruvbox_contrast_light = 'light'
" let g:gruvbox_invert_selection = '0'
" let g:lightline = {}
" let g:lightline.colorscheme = 'gruvbox'
" highlight Normal ctermbg=NONE guibg=NONE
" if exists('+termguicolors')
"     let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"     let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"     set tgc
" endif
" set background=dark
" set t_Co=256

" vim-commentary
" autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s

" fzf
" nnoremap <leader>pg :GFiles<CR>
" nnoremap <leader>pf :Files<CR>
" nnoremap <leader>prf :Rg<CR>
" set makeprg=ninja\ -Cbuild
" nnoremap <leader>5 :make<CR>
" nnoremap <leader>u :UndotreeShow<CR>

""""""""""""""""
""" LSP
""""""""""""""""

" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" imap <silent> <C-p> <Plug>(completion_trigger)

" set completeopt=menuone,noinsert,noselect
" let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" lua require'lspconfig'.flow.setup{ on_attach=require'completion'.on_attach }
" lua << EOF
" require'lspconfig'.sumneko_lua.setup { on_attach=require'completion'.on_attach,
"     settings = {
"         Lua = {
"             diagnostics = {
"                 globals = {
"                     'vim',
"                     'hs'
"                 },
"             },
"         },
"     }
" }
" EOF
" lua require'lspconfig'.pyls_ms.setup{ on_attach=require'completion'.on_attach }

""""""""""""""""
""" VIMWIKI
""""""""""""""""

let _wiki = {}
let _wiki.path = '~/vimwiki'
let _wiki.syntax = 'markdown'
let _wiki.ext = '.md'
let g:vimwiki_list = [_wiki]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_global_ext = 0
au FileType vimwiki set wm=2 tw=104 wrap linebreak
au FileType vimwiki setlocal shiftwidth=6 tabstop=6 noexpandtab

" autoformatters
" lua require('vimwikiformatter')

" fzf binds
command! -bang -nargs=* RgWiki
    \ call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1, {'dir': _wiki.path}, <bang>0)
command! -bang -nargs=* FWiki
    \ call fzf#vim#files(_wiki.path)
nnoremap <leader>pw :FWiki<CR>
nnoremap <leader>prw :RgWiki<CR>
