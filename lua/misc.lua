local add = MiniDeps.add

-- Key clues //TODO: Waiting for 'mini' to have a keymapping module.
-- add('echasnovski/mini.clue')
-- require('mini.clue').setup()

-- Key mapping and also clues
add("folke/which-key.nvim")
require("which-key").setup()

-- Auto pairs
add('echasnovski/mini.pairs')
require('mini.pairs').setup()

-- Notifications
add('echasnovski/mini.notify')
require('mini.notify').setup()

-- 2D Navigation
add('echasnovski/mini.jump2d')
require('mini.jump2d').setup()

-- Profile startup
add('dstein64/vim-startuptime')

-- Zen mode
add('folke/zen-mode.nvim')
require('zen-mode').setup()
