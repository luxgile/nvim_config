local add = MiniDeps.add
local wk = require('which-key')

add('echasnovski/mini.starter')
require('mini.starter').setup()

add('echasnovski/mini.sessions')
require('mini.sessions').setup({
  autoread = true,
  autowrite = true,
})
wk.add({
  { "<leader>pp", "<cmd>lua MiniSessions.select()<cr>", desc = "Select session" },
})

