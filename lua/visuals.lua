local add, now = MiniDeps.add, MiniDeps.now

-- Icons
add('echasnovski/mini.icons')
add('nvim-tree/nvim-web-devicons')

-- Animate actions
add('echasnovski/mini.animate')
now(function() require('mini.animate').setup() end)

-- Theme
add('echasnovski/mini.colors')
now(function() require('mini.colors').setup() end)
add('echasnovski/mini.hues')
-- now(function() require('mini.hues').setup() end)
vim.cmd([[colorscheme randomhue]])

-- Statusline
add('echasnovski/mini.statusline')
now(function() require('mini.statusline').setup() end)
