local M = {}

local p = {
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'nvim-telescope/telescope.nvim',            tag = '0.1.4' },
  { 'stevearc/oil.nvim', },
  { 'nvim-tree/nvim-tree.lua' },
}

function init()
  local wk = require("which-key")

  -- TELESCOPE SETUP
  local tlcp = require('telescope.builtin')
  wk.add({
    { "<leader>f",  group = "File" },
    { "<leader>ff", tlcp.find_files,        desc = "Find in current" },
    { "<leader>ft", "<cmd>Oil --float<cr>", desc = "File tree" },
    { "<leader>fg", tlcp.live_grep,         desc = "Grep" },
    { "<leader>b",  group = "Buffer" },
    { "<leader>bb", tlcp.buffers,           desc = "Browse" },
  })

  require("telescope").setup {
    pickers = {
      find_files = {
        hidden = false
      }
    }
  }

  -- OIL
  require('oil').setup()

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
end

function M.setup(plugins, setups)
  table.foreach(p, function(k, v) table.insert(plugins, v) end)
  table.insert(setups, init)
end

return M
