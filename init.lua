-- THEME
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true  
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- NVIM COMPLETIONS
vim.opt.completeopt = {'menuone', 'noinsert', 'noselect'}

-- CLIPBOARD
vim.opt.clipboard = 'unnamedplus'

-- KEYBINDS CONFIG
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.timeoutlen = 3000
vim.opt.ttimeoutlen = 100

keymap("n", "<leader>pc", ":e ~/Appdata/Local/nvim/init.lua<cr>", opts)
keymap("n", "<leader>pr", ":so ~/Appdata/Local/nvim/init.lua<cr>" , opts) 


-- AUTO INSTALLING PACKER
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- PACKER STARTS

return require('packer').startup(function(use)
	-- PACKER
	use 'wbthomason/packer.nvim'

	-- THEME
	use {
		'folke/tokyonight.nvim',
		config = function() 
			require("tokyonight").setup() 
			vim.cmd[[colorscheme tokyonight-moon]]
		end 
	}

	-- MASON - LSP MANAGER
	use {
		'williamboman/mason.nvim',
		config = function()
			require("mason").setup()
		end
	}
	use {
		'williamboman/mason-lspconfig.nvim',
		config = function()
			require("mason-lspconfig").setup()
		end
	}
	use 'neovim/nvim-lspconfig'


	-- RUST 
	use {
		'simrat39/rust-tools.nvim',
		config = function()
			require("rust-tools").setup({
				server = {
					on_attach = function(_, bufnr)
						-- Hover actions
						vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
						-- Code action groups
						vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
					end,
				},
			})
		end
	}

if packer_bootstrap then
	require('packer').sync()
	end
end)
