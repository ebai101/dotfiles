if has('nvim')
    imap <tab> <Plug>(completion_smart_tab)
    imap <s-tab> <Plug>(completion_smart_s_tab)
    nnoremap <leader>vd :lua vim.lsp.buf.definition()<CR>
    nnoremap <leader>vi :lua vim.lsp.buf.implementation()<CR>
    nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
    nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
    nnoremap <leader>vrn :lua vim.lsp.buf.rename()<CR>
    nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>
    nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>

    let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
    let g:python3_host_prog = '/usr/local/bin/python3'
    let g:yapf_style = 'google'
    set omnifunc=v:lua.vim.lsp.omnifunc

    func! LspReloadFunc()
        lua vim.lsp.stop_client(vim.lsp.get_active_clients())
        edit
    endfunc
    command LspReload call LspReloadFunc()

    lua require('lspsetup')

    au BufWritePre *.py :call Yapf()
endif
