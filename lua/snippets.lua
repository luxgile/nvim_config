local add, later = MiniDeps.add, MiniDeps.later
local wk = require("which-key")

-- Snippets library
add({
  source = "rafamadriz/friendly-snippets" ,
  depends = { 'saghen/blink.compat' }
})

-- Snippets engine
-- add("echasnovski/mini.snippets")
-- local gen_loader = require("mini.snippets").gen_loader
--
-- require("mini.snippets").setup({
--   snippets = {
--     gen_loader.from_lang()
--   }
-- })
add({
  source = "L3MON4D3/LuaSnip",
  hooks = {
    post_checkout = function() vim.cmd("make install_jsregexp") end
  }
})
require("luasnip.loaders.from_vscode").lazy_load()
