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
  { "<leader>p", group = "Sessions" },
  { "<leader>pp", "<cmd>lua MiniSessions.select()<cr>", desc = "Select session" },
  { "<leader>ps", function() save_session() end, desc = "Save session" },
})

function save_session ()
 local user_input = vim.fn.input("Enter input: ")
 MiniSessions.write(user_input)
end
