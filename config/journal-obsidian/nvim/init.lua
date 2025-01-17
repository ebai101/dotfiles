require("journal.set")
require("journal.remap")
require("journal.lazy")

vim.cmd([[
set pvw
exec 'cd ~/Library/Mobile Documents/iCloud~md~obsidian/Documents/vaultington/0\ -\ daily/'
exec 'file '.fnameescape(strftime('%Y-%m-%d.md'))
]])
