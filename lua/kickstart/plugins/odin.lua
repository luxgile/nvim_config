vim.lsp.enable 'ols'

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'odin' } },
  },
  {
    'mason-org/mason.nvim',
    optional = true,
    opts = { ensure_installed = { 'ols' } },
  },
}
