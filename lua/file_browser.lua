local add = MiniDeps.add
local wk = require("which-key")

-- Generic picker
add('echasnovski/mini.pick')
require('mini.pick').setup()
vim.ui.select = MiniPick.ui_select

-- Recent files
add('echasnovski/mini.visits')
require('mini.visits').setup() 

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
  { "<leader>ft", "<cmd>lua MiniFiles.open()<cr>", desc = "File tree" },
  { "<leader>ff", "<cmd>Pick files<cr>", desc = "Find file" },
  { "<leader>b", group = "Buffers" },
  { "<leader>bb", "<cmd>Pick buffers<cr>", desc = "Select buffer" },
})
