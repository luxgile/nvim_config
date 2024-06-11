local M = {}

local p = {
  -- Add plugins here
  { "Hoffs/omnisharp-extended-lsp.nvim" },
  { "jmederosalvarado/roslyn.nvim" },
}

function init()
  local omnisharp_bin = "D:/Utils/Omnisharp/OmniSharp.exe"

  -- C# config for GODOT
  require("roslyn").setup({
    dotnet_cmd = "dotnet",              -- this is the default
    roslyn_version = "4.8.0-3.23475.7", -- this is the default
    on_attach = function(client, bufnr)

    end,
  })
  -- Found here: https://gist.github.com/squk/055683bb83d4dbbac418582129f0e3b5
  -- require 'lspconfig'.omnisharp.setup {
  --   handlers = {
  --     ["textDocument/definition"] = require("omnisharp_extended").handler,
  --   },
  --   -- enable_editorconfig_support = true,
  --   -- enable_roslyn_analyzers = true,
  --   -- organize_imports_on_format = true,
  --   -- enable_import_completion = true,
  --   -- analyze_open_documents_only = true,
  -- }

  local dap = require('dap')
  dap.configurations.cs = {
    {
      type = 'godot',
      request = 'launch',
      name = 'Launch Scene',
      project = '${workspaceFolder}',
      launch_scene = true,
    },
  }
end

function M.setup(plugins, setups)
  table.foreach(p, function(k, v) table.insert(plugins, v) end)
  table.insert(setups, init)
end

return M
