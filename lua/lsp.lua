local add = MiniDeps.add

-- LSP browser
add('williamboman/mason.nvim')
require("mason").setup()

-- LSP Config extensions
add('williamboman/mason-lspconfig.nvim')
require("mason-lspconfig").setup()
add('neovim/nvim-lspconfig')

-- LSP Notifications
add('echasnovski/mini.notify')
require('mini.notify').setup()

