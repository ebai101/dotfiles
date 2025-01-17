vim.g.mapleader = ' '

-- clear search highlight
vim.keymap.set('n', '<C-l>', ':noh<CR>')

-- yank to system clipboard
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+yg_')
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>yy', '"+yy')

-- last buffer
vim.keymap.set('n', '<leader>6', '<C-^>')

-- move lines up and down in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
--
-- moving up and down
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- void register stuff
vim.keymap.set('x', '<leader>p', '\"_dP')
vim.keymap.set('n', '<leader>d', '\"_d')
vim.keymap.set('v', '<leader>d', '\"_d')

-- replace word under cursor
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- make the current file executable
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- netrw
vim.keymap.set('n', '<leader>pv', vim.cmd.Lexplore)
vim.api.nvim_create_autocmd('filetype', {
    pattern = 'netrw',
    callback = function()
        vim.keymap.set('n', 'j', 'jp', { remap = true, buffer = true })
        vim.keymap.set('n', 'k', 'kp', { remap = true, buffer = true })
        vim.keymap.set('n', '<CR>', '<CR>:Lexplore<CR>', { remap = true, buffer = true })
    end
})
