local M = {}

local p = {
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'nvim-telescope/telescope.nvim',            tag = '0.1.4' },
  { 'nvim-tree/nvim-tree.lua' },
}

function init()
  -- TELESCOPE SETUP
  local tlcp = require('telescope.builtin')
  vim.keymap.set('n', '<Leader>ff', tlcp.find_files, {})
  vim.keymap.set('n', '<Leader>bb', tlcp.buffers, {})
  vim.keymap.set('n', '<Leader>fg', tlcp.live_grep, {})
  -- vim.keymap.set('n', '<Leader>fd', tlcp.diagnostics, {})

  require("telescope").setup {
    pickers = {
      find_files = {
        hidden = false
      }
    }
  }

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
  vim.keymap.set('n', '<Leader>ft', ":NvimTreeToggle<cr>", { silent = true, noremap = true })
end

function M.setup(plugins, setups)
  table.foreach(p, function(k, v) table.insert(plugins, v) end)
  table.insert(setups, init)
end

return M
