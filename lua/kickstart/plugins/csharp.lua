vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == 'omnisharp' then
      vim.schedule(function()
        local bufnr = args.buf
        vim.keymap.set('n', 'grd', require('omnisharp_extended').telescope_lsp_definitions, { buffer = bufnr, desc = 'Go to definition' })
      end)
    end
  end,
})

return {
  -- LSP Instalation
  {
    'mason-org/mason.nvim',
    opts = { ensure_installed = { 'csharpier', 'netcoredbg' } },
  },
  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'c_sharp' } },
  },
  -- LSP Config
  { 'Hoffs/omnisharp-extended-lsp.nvim', lazy = true },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        fsautocomplete = {},
        omnisharp = {
          handlers = {
            ['textDocument/definition'] = function(...)
              return require('omnisharp_extended').handler(...)
            end,
          },
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
        },
      },
    },
  },
  -- Formatter
  {
    'stevearc/conform.nvim',
    optional = true,
    opts = {
      formatters_by_ft = {
        cs = { 'csharpier' },
      },
    },
  },

  -- Debugging
  {
    'mfussenegger/nvim-dap',
    optional = true,
    opts = function()
      local dap = require 'dap'
      if not dap.adapters['netcoredbg'] then
        require('dap').adapters['netcoredbg'] = {
          type = 'executable',
          command = vim.fn.exepath 'netcoredbg',
          args = { '--interpreter=vscode' },
          options = {
            detached = false,
          },
        }
      end
      for _, lang in ipairs { 'cs', 'fsharp', 'vb' } do
        if not dap.configurations[lang] then
          dap.configurations[lang] = {
            {
              type = 'netcoredbg',
              name = 'Launch file',
              request = 'launch',
              ---@diagnostic disable-next-line: redundant-parameter
              program = function()
                return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/', 'file')
              end,
              cwd = '${workspaceFolder}',
            },
          }
        end
      end
    end,
  },
}
