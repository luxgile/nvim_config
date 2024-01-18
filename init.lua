require("core")

local lazy_setup = require("lazy_setup")
lazy_setup.lazy_bootstrap()


-- LAZY VIM SETUP
require('lazy').setup({
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'nvim-telescope/telescope.nvim',            tag = '0.1.4' },
  { 'nvim-treesitter/nvim-treesitter',          build = ':TSUpdate' },
  { 'nvim-tree/nvim-web-devicons' },
  { 'simrat39/rust-tools.nvim' },
  { 'nvim-tree/nvim-tree.lua' },
  { 'neovim/nvim-lspconfig' },
  { 'ggandor/leap.nvim' },
  { 'nvim-lualine/lualine.nvim' },
  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {},
  },
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = false,
    opts = {},
  },
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

  -- Color Scheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "morhetz/gruvbox",
    laze = false,
    priority = 1000,
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
  { 'terrortylor/nvim-comment',           lazy = false },
})

-- MOTION SETUP
require('leap').add_default_mappings()

-- COLOR SCHEME SETUP
require('tokyonight').setup {
  transparent = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent",
  },
  on_highlights = function(hl, c)
    local prompt = "#2d3149"
    hl.TelescopeNormal = {
      bg = c.bg_dark,
      fg = c.fg_dark,
    }
    hl.TelescopeBorder = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopePromptNormal = {
      bg = prompt,
    }
    hl.TelescopePromptBorder = {
      bg = prompt,
      fg = prompt,
    }
    hl.TelescopePromptTitle = {
      bg = prompt,
      fg = prompt,
    }
    hl.TelescopePreviewTitle = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopeResultsTitle = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
  end
}
-- vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
vim.cmd([[colorscheme gruvbox]])

-- TELESCOPE SETUP
local tlcp = require('telescope.builtin')
vim.keymap.set('n', '<Leader>ff', tlcp.find_files, {})
vim.keymap.set('n', '<Leader>b', tlcp.buffers, {})
vim.keymap.set('n', '<Leader>fg', tlcp.live_grep, {})
vim.keymap.set('n', '<Leader>fd', tlcp.diagnostics, {})

require("telescope").setup {
  pickers = {
    find_files = {
      hidden = false
    }
  }
}

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

-- FILE EXPLORER SETUP
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.5
require("nvim-tree").setup({
  view = {
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2)
            - vim.opt.cmdheight:get()
        return {
          border = 'rounded',
          relative = 'editor',
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
      end,
    },
    width = function()
      return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
    end,
  },
})
vim.keymap.set('n', '<Leader>t', ":NvimTreeToggle<cr>", { silent = true, noremap = true })

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

-- LSP SETUP
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts) Removed as we are using Trouble for this.
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

local lspconfig = require 'lspconfig'

-- GODOT SETUP
require 'lspconfig'.gdscript.setup {
  cmd = { 'ncat', "127.0.0.1", "6005" },
}


-- WGSL SETUP
vim.cmd("au BufNewFile,BufRead *.wgsl set filetype=wgsl")
vim.filetype.add({
  extenstion = {
    wgsl = "wgsl",
  }
})
lspconfig.wgsl_analyzer.setup {}

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

lspconfig.rust_analyzer.setup {
  root_dir = require "lspconfig/util".root_pattern("Cargo.toml"),
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}

require("rust-tools").setup({
  server = {
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
    -- root_dir = function(startpath)
    --   local startpath_uri = vim.uri_from_fname(startpath)
    --   if not is_in_workspace(startpath) then
    --     return nil
    --   end
    --
    --   return lspconfig.util.root_pattern("Cargo.toml", "rust-project.json")(startpath)
    -- end,
  }
})

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

-- TERMINAL SETUP
-- vim.keymap.set('n', "<leader>ft", ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 fish <CR> ")
-- vim.keymap.set('n', "t", ":FloatermToggle myfloat<CR>")
-- vim.keymap.set('t', "<Esc>", "<C-\\><C-n>:q<CR>")

-- COMMENTING SETUP
require("nvim_comment").setup()

