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
add('echasnovski/mini.colors')
now(function() require('mini.colors').setup() end)
-- add('echasnovski/mini.hues')
-- now(function() require('mini.hues').setup() end)


-- vim.cmd([[colorscheme minicyan]])
vim.cmd([[colorscheme rose-pine]])

-- Statusline
add('echasnovski/mini.statusline')
now(function() require('mini.statusline').setup() end)

-- Treesitter
add('nvim-treesitter/nvim-treesitter')
require('nvim-treesitter.configs').setup({})
