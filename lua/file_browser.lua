local add = MiniDeps.add
local wk = require("which-key")

-- Generic picker
add('folke/snacks.nvim')
require('snacks').setup({
  picker = { enabled = true },
})

-- Recent files
add('echasnovski/mini.visits')
require('mini.visits').setup()

-- Mini file browser
add('echasnovski/mini.files')
require('mini.files').setup({
  mappings = {
    go_in = '<Right>',
    go_out = '<Left>',
    close = '<Esc>',
  },
})

wk.add({
  { "<leader>f",  group = "Files" },
  { "<leader>ft", "<cmd>lua MiniFiles.open()<cr>",                  desc = "File tree" },
  { "<leader>ff", function() Snacks.picker.files() end,             desc = "Find file" },
  { "<leader>fg", function() Snacks.picker.grep() end,              desc = "Fuzzy find" },
  { "<leader>fs", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Find symbols" },
  { "<leader>b",  group = "Buffers" },
  { "<leader>bb", function() Snacks.picker.buffers() end,           desc = "Select buffer" },
})
