filetype plugin on

set hidden
set guicursor=
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent
set number
set relativenumber
set nowrap
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.vim/undodir
set undofile
set scrolloff=8
set cmdheight=2
set updatetime=50
set shortmess+=c
set lazyredraw
set autoread
set splitbelow
set splitright
set nowrapscan
set mouse=a

if has('nvim')
    set noshowmode
    set signcolumn=yes
    set inccommand=split
    set completeopt=menuone,noinsert,noselect
endif
