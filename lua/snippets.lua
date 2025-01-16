local add, later = MiniDeps.add, MiniDeps.later
local wk = require("which-key")

-- Snippets library
add("rafamadriz/friendly-snippets")

-- Snippets engine
add("echasnovski/mini.snippets")
local gen_loader = require("mini.snippets").gen_loader

require("mini.snippets").setup({
  snippets = {
    gen_loader.from_lang()
  }
})
