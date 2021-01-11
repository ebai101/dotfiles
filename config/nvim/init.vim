set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
for file in split(glob('~/.config/nvim/config/*.vim'), '\n')
    exe 'source' file
endfor
