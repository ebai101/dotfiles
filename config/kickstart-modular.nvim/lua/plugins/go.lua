return {
  'ray-x/go.nvim',
  dependencies = {
    'ray-x/guihua.lua',
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('go').setup {
      lsp_cfg = false,
      goimports = 'golines',
      gofmt = 'golines',
      max_line_len = 100,
    }

    local format_sync_grp = vim.api.nvim_create_augroup('gonvim', {})
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*.go',
      callback = function()
        require('go.format').goimports()
      end,
      group = format_sync_grp,
    })

    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { desc = 'Go: ' .. desc })
    end

    map('<leader>fs', ':GoFillStruct<CR>', '[F]ill [S]truct')
    map('<leader>ie', ':GoIfErr<CR>', 'Insert [I]f [E]rr')
    map('<leader>fp', ':GoFixPlurals<CR>', '[F]ix [P]lurals')
  end,
  event = { 'CmdlineEnter' },
  ft = { 'go', 'gomod' },
  build = ':lua require("go.install").update_all_sync()',
}
