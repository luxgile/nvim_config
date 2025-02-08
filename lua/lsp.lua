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
-- Removed Mini Completion due to lack of handling snippets
-- add('echasnovski/mini.completion')
-- require('mini.completion').setup({
--   lsp_completion = {
--     source_func = "omnifunc",
--     -- auto_setup = false,
--   },
--   set_vim_settings = true,
-- })

add({
  source = 'saghen/blink.cmp',
  checkout = 'v0.10.0'
})
require('blink.cmp').setup({
  keymap = { preset = 'enter' },
  snippets = { preset = 'luasnip' },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' }
  },
  completion = {
    list = {
      selection = { preselect = false, auto_insert = false },
    }
  },
})

-- Comment
add('echasnovski/mini.comment')
require("mini.comment").setup()

-- Surround
add('echasnovski/mini.surround')
require('mini.surround').setup()

-- More text objects
add('echasnovski/mini.ai')
require('mini.ai').setup()

-- Picker
add('echasnovski/mini.extra')
require('mini.extra').setup()

-- General keybinds
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- MiniCompletion.completefunc_lsp()
    local opts = { buffer = ev.buf }
    wk.add({
      { "gD",         function() MiniExtra.pickers.lsp({ scope = "declaration" }) end,    desc = "Go to declaration" },
      { "gd",         function() MiniExtra.pickers.lsp({ scope = "definition" }) end,     desc = "Go to definition" },
      { "gi",         function() MiniExtra.pickers.lsp({ scope = "implementation" }) end, desc = "Go to implementation" },
      { "gr",         function() MiniExtra.pickers.lsp({ scope = "references" }) end,     desc = "Go to references" },
      { "<leader>rn", function() vim.lsp.buf.rename() end,                                desc = "Rename" },
      { "K",          function() vim.lsp.buf.hover(opts) end,                             desc = "Hover" },
      { "<leader>a",  function() vim.lsp.buf.code_action(opts) end,                       desc = "Code action" },
      { "<leader>cf", function() vim.lsp.buf.format(opts) end,                            desc = "Code format" },
      { "<leader>cq", function() MiniExtra.pickers.diagnostic() end,                      desc = "Open diagnostics" },
    })
  end
})
-- Diagnostic float window
vim.api.nvim_create_autocmd("CursorHold", {
  buffer = bufnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = " ",
      scope = "cursor",
    }
    vim.diagnostic.open_float(nil, opts)
  end
})
-- Change diagnostic symbols
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Change diagnostic display
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
})


-- DAP
add('mfussenegger/nvim-dap')
add('rcarriga/nvim-dap-ui')
add('nvim-neotest/nvim-nio')
local dapui = require("dapui")
dapui.setup()
local dap = require('dap')
wk.add({
  { "<leader>d",  group = "Debug" },
  { "<leader>dc", function() dap.continue() end,          desc = "Continue" },
  { "<leader>dp", function() dap.step_over() end,         desc = "Step over" },
  { "<leader>di", function() dap.step_into() end,         desc = "Step into" },
  { "<leader>do", function() dap.step_out() end,          desc = "Step out" },
  { "<leader>db", function() dap.toggle_breakpoint() end, desc = "Toggle breakpoint" },
  { "<leader>dl", function() dap.run_last() end,          desc = "Run last" },
  { "<leader>du", function() dapui.toggle() end,          desc = "UI?" },
})


-- Lua
lspconfig.lua_ls.setup {}

-- Rust
add('mrcjkb/rustaceanvim')

-- Get codelldb path
local codelldb_folder = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
local codelldb_path = codelldb_folder .. 'adapter/codelldb'
local liblldb_path = codelldb_folder .. 'lldb/lib/liblldb'
if vim.uv.os_uname().sysname:find "Windows" then
  codelldb_path = codelldb_folder .. 'adapter/codelldb.exe'
  liblldb_path = codelldb_folder .. 'lldb/lib/liblldb.dll'
end

vim.g.rustaceanvim = {
  server = {
    capabilities = {
      textDocument = {
        completion = {
          completionItem = {
            -- Workaround to snippets completion not supported by mini.completion
            snippetSupport = false,
          },
        }
      },
    },
  },
  dap = {
    adapter = require('rustaceanvim.config').get_codelldb_adapter(codelldb_path, liblldb_path)
  },
}

dap.adapters.codelldb = {
  type = "server",
  port = 13000,
  executable = {
    command = codelldb_path,
    args = { "--port", "13000" },
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


-- ZIG
add('ziglang/zig.vim')
lspconfig.zls.setup {}
-- dap.adapters.lldb = {
--   type = 'executable',
--   command = 'C:\\Program Files\\LLVM\\bin\\lldb-vscode.exe', -- adjust as needed, must be absolute path
--   name = 'lldb'
-- }

dap.configurations.zig = {
  {
    name = 'Launch',
    type = 'codelldb',
    request = 'launch',
    program = '${workspaceFolder}/zig-out/bin/zig_hello_world.exe',
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

-- Go
lspconfig.gopls.setup({
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
})

-- Web
lspconfig.ts_ls.setup {
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "/usr/local/lib/node_modules/@vue/language-server",
        languages = { "javascript", "typescript", "vue" },
      }
    }
  },
  filetypes = {
    "javascript",
    "typescript",
    "vue",
  },
}
-- lspconfig.volar.setup {
--     filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
--     init_options = {
--         vue = {
--             hybridMode = false,
--         },
--         typescript = {
--             tsdk = "/home/guille/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib/"
--         },
--     },
-- }
--
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.html.setup {
  capabilities = capabilities
}
lspconfig.eslint.setup {}
lspconfig.cssls.setup {
  capabilities = capabilities,
}

-- Python
lspconfig.pyright.setup({})
local group = vim.api.nvim_create_augroup("Black", { clear = true })
vim.api.nvim_create_autocmd("bufWritePost", {
	pattern = "*.py",
	command = "silent !black %",
	group = group,
})

-- Markdown
add('MeanderingProgrammer/render-markdown.nvim')
require('render-markdown').setup({})
