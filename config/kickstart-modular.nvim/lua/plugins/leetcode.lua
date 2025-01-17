return {
  'kawre/leetcode.nvim',
  build = ':TSUpdate html',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  lazy = 'leetcode.nvim' ~= vim.fn.argv(0, -1),
  opts = {
    arg = 'leetcode.nvim',
    lang = 'golang',
    injector = {
      ['golang'] = {
        before = { 'package leetcode' },
      },
    },
  },
  init = function()
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { desc = 'Leetcode: ' .. desc })
    end

    map('<leader>lt', ':Leet test<CR>', 'Test')
    map('<leader>ls', ':Leet submit<CR>', 'Submit')
    map('<leader>ld', ':Leet desc<CR>', 'Toggle description')
  end,
}
