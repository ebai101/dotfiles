local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'ellisonleao/gruvbox.nvim',
        name = 'gruvbox'
    },
    {
        'Pocco81/auto-save.nvim',
        build = function()
            require('auto-save').setup()
        end
    },
    'preservim/vim-pencil',
    'godlygeek/tabular',
    'preservim/vim-markdown',
})
