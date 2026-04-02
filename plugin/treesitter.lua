vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

require("nvim-treesitter").setup({
	ensure_installed = {
		"lua",
		"odin",
		"c",
		"cpp",
		"rust",
		"vim",
		"vimdoc",
		"markdown",
	},
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true },
})
