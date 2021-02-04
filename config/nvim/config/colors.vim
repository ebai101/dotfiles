let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'soft'
let g:gruvbox_invert_selection = '0'
let g:gruvbox_italic = 1

function! LspStatus() abort
    if luaeval('#vim.lsp.buf_get_clients() > 0')
        return luaeval("require('lsp-status').status()")
    endif

    return ''
endfunction

if has('nvim')
    let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'lsp' ] ]
      \ },
      \ 'component_function': {
      \   'lsp': 'LspStatus'
      \ },
      \ }
endif

highlight Normal ctermbg=NONE guibg=NONE
if exists('+termguicolors')
    set tgc
endif

colorscheme gruvbox
set background=dark
set t_Co=256
