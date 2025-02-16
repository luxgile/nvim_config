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

lspconfig = require("lspconfig")

-- Lua
lspconfig.lua_ls.setup {}

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

-- dap.adapters.codelldb = {
--   type = "server",
--   port = 13000,
--   executable = {
--     command = codelldb_path,
--     args = { "--port", "13000" },
--   },
-- }

-- WGSL
vim.cmd("au BufNewFile,BufRead *.wgsl set filetype=wgsl")
vim.filetype.add({
  extenstion = {
    wgsl = "wgsl",
  }
})
lspconfig.wgsl_analyzer.setup {}

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
require('render-markdown').setup({})


-- C / C++
lspconfig.clangd.setup({})
