return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }

      require('mini.surround').setup {
        mappings = {
          add = 'as',
          delete = 'ds',
          find = 'fs',
          find_left = 'Fs',
          highlight = 'hs',
          replace = 'rs',
        },
      }

      require('mini.comment').setup()

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
