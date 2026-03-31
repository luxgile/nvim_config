vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",
})

require("telescope").setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
})

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

-- See `:help telescope.builtin`
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find with Grep" })
vim.keymap.set("n", "<leader>qt", builtin.diagnostics, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>fr.", builtin.oldfiles, { desc = "Find Recent files" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })

-- Shortcut for searching your Neovim configuration files
vim.keymap.set("n", "<leader>fc", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find Config" })
