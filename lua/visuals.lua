local add, now = MiniDeps.add, MiniDeps.now

-- Icons
add('echasnovski/mini.icons')
add('nvim-tree/nvim-web-devicons')

-- Animate actions
add('echasnovski/mini.animate')
now(function() 
  local animate = require('mini.animate')
  animate.setup({
    scroll = {
      timing = animate.gen_timing.linear({ duration = 100, unit = 'total' }),
      subscroll = animate.gen_subscroll.equal({ max_output_steps = 120 })
    }
  }) 
end)

-- Theme
add('echasnovski/mini.colors')
now(function() require('mini.colors').setup() end)
-- add('echasnovski/mini.hues')
-- now(function() require('mini.hues').setup() end)
vim.cmd([[colorscheme randomhue]])

-- Statusline
add('echasnovski/mini.statusline')
now(function() require('mini.statusline').setup() end)

-- Treesitter
add('nvim-treesitter/nvim-treesitter')
require('nvim-treesitter.configs').setup({})
