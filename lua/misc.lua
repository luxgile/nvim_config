local M = {}
local p = {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
    }
  },
  { "ahmedkhalf/project.nvim" },
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'nvim-tree/nvim-web-devicons' },
  { 'nvim-lualine/lualine.nvim' },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },
  -- Dap
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui" },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
    },
  },

  -- Indents
  { "lukas-reineke/indent-blankline.nvim", main = "ibl" },

  -- Godot
  {
    "habamax/vim-godot",
  },

  -- Completion framework:
  { 'hrsh7th/nvim-cmp' },

  -- LSP completion source:
  { 'hrsh7th/cmp-nvim-lsp' },

  -- Useful completion sources:
  { 'hrsh7th/cmp-nvim-lua' },
  { 'hrsh7th/cmp-nvim-lsp-signature-help' },
  { 'hrsh7th/cmp-vsnip' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/vim-vsnip' },

  -- Floating terminal
  { 'voldikss/vim-floaterm' },

  -- Comment toggle
  { 'terrortylor/nvim-comment',            lazy = false },
}


function init()
  local wk = require("which-key")
  -- Window management
  wk.register({
    w = {
      name = "Window",
      q = { "<cmd>q<cr>", "Close" },
      h = { "<cmd>wincmd h<cr>", "Focus left" },
      j = { "<cmd>wincmd j<cr>", "Focus down" },
      k = { "<cmd>wincmd k<cr>", "Focus up" },
      l = { "<cmd>wincmd l<cr>", "Focus right" },
      v = { "<cmd>vs<cr>", "Vertical split" },
      s = { "<cmd>ws<cr>", "Horizontal split" },
    }
  }, { prefix = "<leader>" })

  -- PROJECT BROWSER
  require("project_nvim").setup {}
  require('telescope').load_extension('projects')
  wk.register({
    p = {
      name = "Project",
      p = { "<cmd>Telescope projects<cr>", "Browse projects" },
    }
  }, { prefix = "<leader>" })

  -- TROUBLE DIAGNOSTICS
  local trb = require("trouble")
  vim.keymap.set("n", "<leader>xx", function() trb.toggle() end)
  vim.keymap.set("n", "<leader>xw", function() trb.toggle("workspace_diagnostics") end)
  vim.keymap.set("n", "<leader>xd", function() trb.toggle("document_diagnostics") end)
  vim.keymap.set("n", "<leader>xq", function() trb.toggle("quickfix") end)
  vim.keymap.set("n", "<leader>xl", function() trb.toggle("loclist") end)
  vim.keymap.set("n", "gr", function() trb.toggle("lsp_references") end)

  -- DAP SETUP
  local dap = require('dap')
  vim.keymap.set('n', '<Leader>dc', function() dap.continue() end)
  vim.keymap.set('n', '<Leader>dp', function() dap.step_over() end)
  vim.keymap.set('n', '<Leader>di', function() dap.step_into() end)
  vim.keymap.set('n', '<Leader>do', function() dap.step_out() end)
  vim.keymap.set('n', '<Leader>db', function() dap.toggle_breakpoint() end)
  vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)
  vim.keymap.set('n', '<Leader>df', function() require("dapui").float_element('scopes', { enter = true }) end)
  dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
      -- Change this to your path!
      command = 'codelldb',
      args = { "--port", "${port}" },
    }
  }

  dap.configurations.rust = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
    },
  }
  require("dapui").setup({})

  -- LUA LINE SETUP
  require('lualine').setup {
    options = {
      theme = 'gruvbox'
    }
  }

  -- INDENT
  require("ibl").setup({
    scope = { enabled = false },
  })


  -- TREESITTER SETUP
  require('nvim-treesitter.configs').setup {
    ensure_installed = { "lua", "rust", "toml", "wgsl" },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    ident = { enable = true },
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
    }
  }


  local lspconfig = require 'lspconfig'

  -- GODOT SETUP
  lspconfig.gdscript.setup {
    cmd = { 'ncat', "127.0.0.1", "6005" },
  }
  dap.adapters.godot = {
    type = 'server',
    host = '127.0.0.1',
    port = 6006,
  }

  lspconfig.clangd.setup {}

  -- LUA SETUP
  lspconfig.lua_ls.setup {}

  -- JS & TS SETUP
  lspconfig.eslint.setup({
    on_attach = function(client, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
  })
  lspconfig.tsserver.setup {}
  lspconfig.html.setup {}


  -- LSP Diagnostics Options Setup
  vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
      vim.lsp.buf.format({ async = true })
    end
  })

  local sign = function(opts)
    vim.fn.sign_define(opts.name, {
      texthl = opts.name,
      text = opts.text,
      numhl = ''
    })
  end

  sign({ name = 'DiagnosticSignError', text = '' })
  sign({ name = 'DiagnosticSignWarn', text = '' })
  sign({ name = 'DiagnosticSignHint', text = '' })
  sign({ name = 'DiagnosticSignInfo', text = '' })

  vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
    },
  })

  vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

  -- AUTOCOMPLETE SETUP
  local cmp = require 'cmp'
  cmp.setup({
    -- Enable LSP snippets
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      -- Add tab support
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      })
    },
    -- Installed sources:
    sources = {
      { name = 'path' },                                       -- file paths
      { name = 'nvim_lsp',               keyword_length = 1 }, -- from language server
      { name = 'nvim_lsp_signature_help' },                    -- display function signatures with current parameter emphasized
      { name = 'nvim_lua',               keyword_length = 1 }, -- complete neovim's Lua runtime API such vim.lsp.*
      { name = 'buffer',                 keyword_length = 2 }, -- source current buffer
      { name = 'vsnip',                  keyword_length = 1 }, -- nvim-cmp source for vim-vsnip
      { name = 'calc' },                                       -- source for math calculation
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    formatting = {
      fields = { 'menu', 'abbr', 'kind' },
      format = function(entry, item)
        local menu_icon = {
          nvim_lsp = 'λ',
          vsnip = '⋗',
          buffer = 'Ω',
          path = '🖫',
        }
        item.menu = menu_icon[entry.source.name]
        return item
      end,
    },
  })

  -- COMMENTING SETUP
  require("nvim_comment").setup()
end

function M.setup(plugins, setups)
  table.foreach(p, function(k, v) table.insert(plugins, v) end)
  table.insert(setups, init)
end

return M
