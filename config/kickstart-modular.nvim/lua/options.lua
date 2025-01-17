-- [[ Setting options ]]
vim.o.guicursor = ''

vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.smartindent = true
vim.o.breakindent = true

vim.o.wrap = false

vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.o.undofile = true

vim.o.scrolloff = 10
vim.o.cmdheight = 1
vim.o.updatetime = 50
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.wrapscan = false
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.signcolumn = 'yes'
vim.o.inccommand = 'split'
vim.o.termguicolors = true

vim.o.cursorline = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.timeoutlen = 300

-- vim: ts=2 sts=2 sw=2 et
