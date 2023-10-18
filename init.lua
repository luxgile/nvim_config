
-- GENERAL SETTINGS
vim.keymap.set('n', '<F10>', ':e ~/AppData/Local/nvim/init.lua<CR>')

vim.g.mapleader = ' '

vim.opt.background = "dark"
vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = {'noinsert', 'menuone', 'noselect'}
vim.opt.number = true
vim.opt.hidden = true
vim.opt.relativenumber = true
vim.opt.title = true
vim.opt.autoindent = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- LAZY VIM BOOTSTRAP
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- LAZY VIM SETUP
require('lazy').setup({

})
