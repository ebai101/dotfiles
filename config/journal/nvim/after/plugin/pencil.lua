local pencil_group = vim.api.nvim_create_augroup('pencil_group', {})
vim.api.nvim_create_autocmd('FileType', {
    group = pencil_group,
    pattern = 'markdown,mkd,text',
    command = [[ call pencil#init({'wrap': 'soft'}) ]]
})
