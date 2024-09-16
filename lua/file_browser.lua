local add = MiniDeps.add
local wk = require("which-key")

-- Generic picker
add('echasnovski/mini.pick')
require('mini.pick').setup()

-- Oil file browser
-- add( 'stevearc/oil.nvim' )
-- require("oil").setup()

-- Mini file browser 
add('echasnovski/mini.files')
require('mini.files').setup({
  mappings = {
    go_in = '<Right>',
    go_out = '<Left>',
  },
})
wk.add({
  { "<leader>f", group = "Files" },
  { "<leader>ft", "<cmd>lua MiniFiles.open()<cr>", desc = "File tree" }
})
