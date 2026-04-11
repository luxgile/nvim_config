vim.lsp.config("clangd", {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--function-arg-placeholders",
		"--fallback-style=llvm",
	},
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
		clangdFileStatus = true,
	},
	capabilities = {
		offsetEncoding = { "utf-16" },
	},
	root_markers = {
		"compile_commands.json",
		"compile_flags.txt",
		"configure.ac",
		"Makefile",
		"configure.ac",
		"configure.in",
		"config.h.in",
		"meson.build",
		"meson_options.txt",
		"build.ninja",
		".git",
	},
	on_attach = function()
		vim.keymap.set(
			"n",
			"<leader>fh",
			"<cmd>ClangdSwitchSourceHeader<cr>",
			{ desc = "Switch Source/Header (C/C++)" }
		)
		require("clangd_extensions").setup()
	end,
})
vim.lsp.enable("clangd")

vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/p00f/clangd_extensions.nvim",
	"https://github.com/Mythos-404/xmake.nvim",
	"https://github.com/mfussenegger/nvim-dap",
})

require("clangd_extensions").setup({
	inlay_hints = {
		inline = true,
	},
	ast = {
		role_icons = {
			type = "",
			declaration = "",
			expression = "",
			specifier = "",
			statement = "",
			["template argument"] = "",
		},
		kind_icons = {
			Compound = "",
			Recovery = "",
			TranslationUnit = "",
			PackExpansion = "",
			TemplateTypeParm = "",
			TemplateTemplateParm = "",
			TemplateParamObject = "",
		},
	},
})

require("xmake").setup({})

local dap = require("dap")
if not dap.adapters["codelldb"] then
	require("dap").adapters["codelldb"] = {
		type = "server",
		host = "localhost",
		port = "${port}",
		executable = {
			command = "codelldb",
			args = {
				"--port",
				"${port}",
			},
		},
	}
end

for _, lang in ipairs({ "c", "cpp" }) do
	dap.configurations[lang] = {
		{
			type = "codelldb",
			request = "launch",
			name = "Launch file",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
		},
		{
			type = "codelldb",
			request = "attach",
			name = "Attach to process",
			pid = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
	}
end
