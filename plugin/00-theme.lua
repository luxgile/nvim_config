vim.pack.add({
	"https://github.com/navarasu/onedark.nvim",
	"https://github.com/ellisonleao/gruvbox.nvim",
	"https://github.com/sainnhe/gruvbox-material",
})

-- require("gruvbox").setup({})
-- vim.cmd.colorscheme("gruvbox")

-- require("onedark").setup({})
-- vim.cmd.colorscheme("onedark")

vim.g.gruvbox_material_foreground = "original"
vim.cmd.colorscheme("gruvbox-material")
