local add = MiniDeps.add
local wk = require("which-key")

-- TODO: Swap to the previous version. This one is very limited.
add({
  source = 'Exafunction/codeium.nvim',
  depends = {'nvim-lua/plenary.nvim'}
})

-- require('codeium').setup({
--   enable_cmp_source = false,
--   virtual_text = {
--     enabled = true,
--   }
-- })
-- vim.g.codeium_disable_bindings = 1
-- wk.add({
--   { "<leader>i", group = "AI" },
--   { "<leader>ia", function() return vim.fn['codeium#Complete']() end, desc = "Manually trigger suggestion" },
--   { "<leader>ii", function() return vim.fn['codeium#Accept']() end, desc = "Insert suggestion" },
--   { "<leader>ic", function() return vim.fn['codeium#Clear']() end, desc = "Clear suggestion" },
--   { "<leader>ij", function() return vim.fn['codeium#CycleCompletions'](1) end, desc = "Next suggestion" },
--   { "<leader>ik", function() return vim.fn['codeium#CycleCompletions'](-1) end, desc = "Previous suggestion" },
--   { "<leader>it", function() return vim.fn['codeium#Toggle']() end, desc = "Toggle AI" },
-- })
--
