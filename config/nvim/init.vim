" init.vim

if empty(glob('~/.local/share/nvim/site/pack/paqs/opt/paq-nvim'))
    silent !git clone https://github.com/savq/paq-nvim.git
        \ ~/.local/share/nvim/site/pack/paqs/opt/paq-nvim
    au VimEnter * PaqInstall
endif

lua require('init')

" visual range macro
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
endfunction
