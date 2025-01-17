return {
  'tpope/vim-dadbod',
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1

      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { desc = 'DB: ' .. desc })
      end

      map('<leader>db', ':DBUIToggle<CR>', 'Toggle [DB]UI')
    end,
  },
}
