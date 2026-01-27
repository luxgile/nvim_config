-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  {
    'nvim-mini/mini.files',
    version = false,
    config = function()
      require('mini.files').setup {
        mappings = {
          close = 'q',
          go_in = '<Right>',
          go_out = '<Left>',
          mark_goto = "'",
          mark_set = 'm',
          reset = '<BS>',
          reveal_cwd = '@',
          show_help = 'g?',
          synchronize = '=',
          trim_left = '<',
          trim_right = '>',
        },
      }

      vim.keymap.set('n', '<leader>ft', MiniFiles.open, { desc = 'Open file tree' })
    end,
  },
}
