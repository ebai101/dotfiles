let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'soft'
let g:gruvbox_invert_selection = '0'
let g:gruvbox_italic = 1

if has('nvim')
    let g:lightline = {}
    let g:lightline.colorscheme = 'gruvbox'
endif

highlight Normal ctermbg=NONE guibg=NONE
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set tgc
endif

colorscheme gruvbox
set background=dark
set t_Co=256
