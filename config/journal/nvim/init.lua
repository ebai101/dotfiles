require('journal.set')
require('journal.remap')
require('journal.lazy')

vim.cmd [[
set pvw
exec 'cd ~/Dropbox/journal/entries'
exec 'file '.fnameescape(strftime('%Y-%m-%d %H-%M.md'))
]]
