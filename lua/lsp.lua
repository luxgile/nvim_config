local add = MiniDeps.add

-- LSP browser
add('williamboman/mason.nvim')
require("mason").setup()

-- LSP Config extensions
add('williamboman/mason-lspconfig.nvim')
require("mason-lspconfig").setup()
add('neovim/nvim-lspconfig')
local lspconfig = require('lspconfig')

-- Auto completion
add('echasnovski/mini.completion')
require('mini.completion').setup()

-- Lua
lspconfig.lua_ls.setup {}

-- Rust
add('mrcjkb/rustaceanvim')

-- WGSL
vim.cmd("au BufNewFile,BufRead *.wgsl set filetype=wgsl")
vim.filetype.add({
  extenstion = {
    wgsl = "wgsl",
  }
})
lspconfig.wgsl_analyzer.setup {}
