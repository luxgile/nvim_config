vim.lsp.config('zls', {})

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'zig' } },
  },
  {
    'mason-org/mason.nvim',
    optional = true,
    opts = { ensure_installed = { 'zls' } },
  },
  {
    'lawrence-laz/neotest-zig',
  },
  {
    'nvim-neotest/neotest',
    optional = true,
    dependencies = {
      'lawrence-laz/neotest-zig',
    },
    opts = {
      adapters = {
        ['neotest-zig'] = {},
      },
    },
  },
}
