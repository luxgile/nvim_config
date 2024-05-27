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
  wk.register({
    g = {
      name = "Git",
      g = { "<cmd>Neogit cwd=%:p:h<CR>", "Open Neogit" },
    }
  }, { prefix = "<leader>" })
end

function M.setup(plugins, setups)
  table.foreach(p, function(k, v) table.insert(plugins, v) end)
  table.insert(setups, init)
end

return M
