vim.api.nvim_create_user_command('LOpenConfig',
  function()
    vim.cmd(":cd ~/AppData/Local/nvim")
    vim.cmd(":e init.lua")
  end,
  {})


vim.keymap.set('n', '<F10>', ':e ~/AppData/Local/nvim/init.lua<CR>')

vim.g.mapleader = ' '
vim.opt.timeoutlen = 3000
vim.opt.ttimeoutlen = 100

vim.opt.background = "dark"
vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = { 'noinsert', 'menuone', 'noselect' }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option('updatetime', 300)
vim.opt.number = true
vim.opt.hidden = true
vim.opt.relativenumber = true
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.encoding = 'utf-8'
vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
