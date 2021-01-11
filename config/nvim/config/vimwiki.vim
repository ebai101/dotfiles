let _wiki = {}
let _wiki.path = $HOME.'/vimwiki'
let _wiki.syntax = 'markdown'
let _wiki.ext = '.md'
let _wiki.auto_diary_index = 1

let g:vimwiki_list = [_wiki]
let g:vimwiki_auto_header = 1
let g:vimwiki_auto_chdir = 1
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_global_ext = 0

command! Tdy :r !date +'\%m-\%d-\%y'
command! Tmo :r !date -v+1d +'\%m-\%d-\%y'

aug GROUPY_MCGROUPSON
    au!
    au FileType vimwiki set wm=2 tw=104 wrap linebreak
    au FileType vimwiki setlocal shiftwidth=6 tabstop=6 noexpandtab
aug END
