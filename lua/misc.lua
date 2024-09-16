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
