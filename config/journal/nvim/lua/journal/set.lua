vim.opt.guicursor = ''

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.scrolloff = 8
vim.opt.cmdheight = 2
vim.opt.updatetime = 50
vim.opt.lazyredraw = true
vim.opt.autoread = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wrapscan = false
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.inccommand = 'split'
vim.opt.laststatus = 0
vim.opt.showcmd = false
vim.opt.termguicolors = true

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 0
vim.g.netrw_winsize = 20
vim.g.netrw_sort_by = 'time'
vim.g.netrw_sort_direction = 'reverse'
vim.g.netrw_list_hide = [[.*\/$]]
