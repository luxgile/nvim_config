vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/nvim-neo-tree/neo-tree.nvim",
	"https://github.com/nvim-mini/mini.files",
})

require("neo-tree").setup({
	sources = { "filesystem", "buffers", "git_status" },
	default_component_configs = {
		indent = {
			with_expanders = true,
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
		git_status = {
			symbols = {
				unstaged = "󰄱",
				staged = "󰱒",
			},
		},
	},
})
require("mini.files").setup({
	mappings = {
		close = "<esc>",
		go_in = "<Right>",
		go_out = "<Left>",
		mark_goto = "'",
		mark_set = "m",
		reset = "<BS>",
		reveal_cwd = "@",
		show_help = "g?",
		synchronize = "=",
		trim_left = "<",
		trim_right = ">",
	},
})

vim.keymap.set("n", "<leader>ft", MiniFiles.open, { desc = "Open file tree" })
vim.keymap.set("n", "<leader>fT", "<cmd>Neotree<CR>", { desc = "Open neo tree" })
