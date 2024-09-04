local M = {}

local p = {
  -- { 'echasnovski/mini-git', version = false, main = 'mini.git' },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    config = true
  }
}

function init()
  local neogit = require('neogit')
  neogit.setup {}

  local wk = require("which-key")
  wk.add({
    { "<leader>g",  group = "Git" },
    { "<leader>gg", "<cmd>Neogit<CR>", desc = "Open Neogit" }
  })
end

function M.setup(plugins, setups)
  table.foreach(p, function(k, v) table.insert(plugins, v) end)
  table.insert(setups, init)
end

return M
