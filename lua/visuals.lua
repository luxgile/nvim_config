local add, now = MiniDeps.add, MiniDeps.now



-- Icons
add('echasnovski/mini.icons')
add('nvim-tree/nvim-web-devicons')

-- Animate actions
-- add('echasnovski/mini.animate')
-- now(function()
--   local animate = require('mini.animate')
--   animate.setup({
--     scroll = {
--       enabled = false
--     }
--   })
-- end)

-- Theme
add('rose-pine/neovim')
add('ellisonleao/gruvbox.nvim')
add('catppuccin/nvim')
add('echasnovski/mini.colors')
now(function() require('mini.colors').setup() end)
-- add('echasnovski/mini.hues')
-- now(function() require('mini.hues').setup() end)


-- vim.cmd([[colorscheme minicyan]])
vim.o.background = "dark"
-- vim.cmd([[colorscheme gruvbox]])
vim.cmd([[colorscheme rose-pine-main]])
-- require("catppuccin").setup({
--   flavour = "mocha",
--   transparent_background = true,
-- })
-- vim.cmd([[colorscheme catppuccin]])

-- Statusline
add('echasnovski/mini.statusline')
now(function() require('mini.statusline').setup() end)

-- Treesitter
add({
  source = 'nvim-treesitter/nvim-treesitter',
  checkout = 'master',
  monitor = 'main',
  hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})
require('nvim-treesitter.configs').setup({
  auto_install = true,
  highlight = {
    enable = true,
  }
})
