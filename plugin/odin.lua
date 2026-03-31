vim.lsp.enable("ols")

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "odin" },
	callback = function()
		vim.treesitter.start()
	end,
})
