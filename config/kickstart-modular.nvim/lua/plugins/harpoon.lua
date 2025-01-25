return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    local harpoon = require('harpoon')
    harpoon:setup({})

    local telescope_conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers').new({}, {
        prompt_title = 'Harpoon',
        finder = require('telescope.finders').new_table({
          results = file_paths,
        }),
        previewer = telescope_conf.file_previewer({}),
        sorter = telescope_conf.generic_sorter({}),
      }):find()
    end

    vim.keymap.set('n', '<C-e>', function() toggle_telescope(harpoon:list()) end, { desc = 'Open harpoon window' })
    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
      local pos = harpoon:list():length()
      print('added harpoon at position ' .. pos)
    end)
    vim.keymap.set('n', '<leader>A', function()
      harpoon:list():clear()
      print('cleared harpoon list')
    end)
    vim.keymap.set('n', '<leader>h', function() harpoon:list():select(1) end)
    vim.keymap.set('n', '<leader>j', function() harpoon:list():select(2) end)
    vim.keymap.set('n', '<leader>k', function() harpoon:list():select(3) end)
    vim.keymap.set('n', '<leader>l', function() harpoon:list():select(4) end)
  end
}
