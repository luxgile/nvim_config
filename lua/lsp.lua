local add = MiniDeps.add
local wk = require("which-key")

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
require('mini.completion').setup({
  lsp_completion = { 
    source_func = "omnifunc",
    -- auto_setup = false,
  },
  set_vim_settings = true,
})

-- General keybinds
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- MiniCompletion.completefunc_lsp()
    local opts = { buffer = ev.buf }
    wk.add({
      { "gD", function() vim.lsp.buf.declaration(opts) end, desc = "Go to declaration" },
      { "gd", function() vim.lsp.buf.definition(opts) end, desc = "Go to definition"},
      { "gi", function() vim.lsp.buf.implementation(opts) end, desc = "Go to implementation" },
      { "gr", function() vim.lsp.buf.references(opts) end , desc = "Go to references" },
      { "<leader>rn", function() vim.lsp.buf.rename() end, desc = "Rename" },
      { "K", function() vim.lsp.buf.hover(opts) end, desc = "Hover" },
      { "<leader>a", function() vim.lsp.buf.code_action(opts) end, desc = "Code action" },
      { "<leader>cf", function() vim.lsp.buf.format(opts) end, desc = "Code format" },
    })
  end
})

-- DAP
add('mfussenegger/nvim-dap')
add('rcarriga/nvim-dap-ui')
add('nvim-neotest/nvim-nio')
local dapui = require("dapui")
dapui.setup()
local dap = require('dap')
wk.add({
  { "<leader>d", group = "Debug" },
  { "<leader>dc", function() dap.continue() end, desc = "Continue" },
  { "<leader>dp", function() dap.step_over() end, desc = "Step over" },
  { "<leader>di", function() dap.step_into() end, desc = "Step into" },
  { "<leader>do", function() dap.step_out() end, desc = "Step out" },
  { "<leader>db", function() dap.toggle_breakpoint() end, desc = "Toggle breakpoint" },
  { "<leader>dl", function() dap.run_last() end, desc = "Run last" },
  { "<leader>df", function() dapui.float_element('scopes', { enter = true }) end, desc = "UI?" },
})


-- Lua
lspconfig.lua_ls.setup {}

-- Rust
add('mrcjkb/rustaceanvim')
-- Workaround to snippets completion not supported by mini.completion
vim.g.rustaceanvim = {
  server = {
    capabilities = {
      textDocument = {
        completion = {
          completionItem = {
            snippetSupport = false,
          },
        }
      },
    },
  },
}

-- WGSL
vim.cmd("au BufNewFile,BufRead *.wgsl set filetype=wgsl")
vim.filetype.add({
  extenstion = {
    wgsl = "wgsl",
  }
})
lspconfig.wgsl_analyzer.setup {}
