local add = MiniDeps.add

add('akinsho/toggleterm.nvim')
require("toggleterm").setup({
  direction = "float",
  close_on_exit = true,
  winbar = {
    enabled = true,
  }
})
-- vim.keymap.set('t', 'q', [[<C-w>q]], { buffer = 0 })
