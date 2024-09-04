local M = {}

local p = {
  { 'simrat39/rust-tools.nvim' },
}

function init()
  -- RUST TOOLS SETUP
  -- Workaround to external files being added to workspace
  local function ensure_uri_scheme(uri)
    if not vim.startswith(uri, "file://") then
      return "file://" .. uri
    end
    return uri
  end

  local function is_in_workspace(uri)
    uri = ensure_uri_scheme(uri)
    local path = vim.uri_to_fname(uri)
    local workspace_dir = vim.fn.getcwd()

    return vim.startswith(path, workspace_dir)
  end

  local function filter_diagnostics(diagnostics)
    local filtered_diagnostics = {}
    for _, diagnostic in ipairs(diagnostics) do
      if is_in_workspace(diagnostic.source) then
        table.insert(filtered_diagnostics, diagnostic)
      end
    end
    return filtered_diagnostics
  end

  local lspconfig = require 'lspconfig'
  lspconfig.rust_analyzer.setup {
    root_dir = require "lspconfig/util".root_pattern("Cargo.toml"),
    -- Server-specific settings. See `:help lspconfig-setup`
    settings = {
      ['rust-analyzer'] = {},
    },
  }

  local rt = require("rust-tools")
  rt.setup({
    server = {
      on_attach = function(_, bufnr)
        vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
        vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
      end,
    }
  })

  -- WGSL SETUP
  vim.cmd("au BufNewFile,BufRead *.wgsl set filetype=wgsl")
  vim.filetype.add({
    extenstion = {
      wgsl = "wgsl",
    }
  })
  lspconfig.wgsl_analyzer.setup {}
end

function M.setup(plugins, setups)
  table.foreach(p, function(k, v) table.insert(plugins, v) end)
  table.insert(setups, init)
end

return M
