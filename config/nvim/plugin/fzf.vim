nnoremap <leader>pg :GFiles<CR>
nnoremap <leader>pf :Files<CR>
nnoremap <leader>ps :Rg<CR>

nnoremap <leader>pwf :FWiki<CR>
nnoremap <leader>pws :RgWiki<CR>
command! -bang -nargs=* RgWiki
            \ call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1, {'dir': _wiki.path}, <bang>0)
command! -bang -nargs=* FWiki
            \ call fzf#vim#files(_wiki.path)
