vim.g.mapleader = ' '

vim.opt.background = "dark"
vim.opt.clipboard = 'unnamedplus'
-- vim.opt.completeopt = { 'noinsert', 'menuone', 'noselect' } Disabled because of Mini Completion
-- vim.opt.shortmess = vim.opt.shortmess + { c = true }
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
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.keymap.set('n', '<leader>fp', ':e ~/AppData/Local/nvim/<CR>')
elseif vim.loop.os_uname().sysname == "Linux" then
  vim.keymap.set('n', '<leader>fp', ':e ~/.config/nvim/<CR>')
end

if vim.g.neovide then
  vim.o.guifont = "Iosevka Nerd Font Propo:h20"
  -- vim.o.guifont = "JetBrainsMono NF:h18"
  vim.g.neovide_transparency = 0.95
end
