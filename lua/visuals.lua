local add, now = MiniDeps.add, MiniDeps.now



-- Icons
add('echasnovski/mini.icons')
add('nvim-tree/nvim-web-devicons')

-- Theme
add('rose-pine/neovim')
add('ellisonleao/gruvbox.nvim')
add('catppuccin/nvim')
add('projekt0n/github-nvim-theme')
add('echasnovski/mini.colors')
now(function() require('mini.colors').setup() end)
-- add('echasnovski/mini.hues')
-- now(function() require('mini.hues').setup() end)


-- vim.cmd([[colorscheme minicyan]])
vim.o.background = "dark"
vim.cmd([[colorscheme github_dark_default]])
-- vim.cmd([[colorscheme gruvbox]])
-- vim.cmd([[colorscheme rose-pine-main]])
-- require("catppuccin").setup({
--   flavour = "mocha",
--   transparent_background = true,
-- })
-- vim.cmd([[colorscheme catppuccin]])

-- Statusline
add('nvim-lualine/lualine.nvim')
now(function()
  require('lualine').setup({
    options = {
      theme = "horizon"
    }
  })
end)

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

-- Indent maker
add('lukas-reineke/indent-blankline.nvim')
now(function() require('ibl').setup() end)
