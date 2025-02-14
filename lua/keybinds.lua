wk = require("which-key")

wk.add({
  { "<leader>f", group = "Files" },
  { "<leader>ft", "<cmd>Oil --float<cr>", desc = "File tree" },
  { "<leader>ff", function() Snacks.picker.files() end, desc = "Find file" },
  { "<leader>fg", function() Snacks.picker.grep() end, desc = "Fuzzy find" },
  { "<leader>b", group = "Buffers" },
  { "<leader>bb", function () Snacks.picker.buffers() end, desc = "Select buffer" },

  { "<leader>p",  group = "Projects" },
  { "<leader>pp", function() Snacks.picker.projects() end, desc = "Select project" },

  { "<leader>u",  function() Snacks.picker.undo() end,                desc = "Undo history" },
  { "gD",         function() Snacks.picker.lsp_declarations() end,    desc = "Go to declaration" },
  { "gd",         function() Snacks.picker.lsp_definitions() end,     desc = "Go to definition" },
  { "gi",         function() Snacks.picker.lsp_implementations() end, desc = "Go to implementation" },
  { "gr",         function() Snacks.picker.lsp_references() end,      desc = "Go to references" },
  { "<leader>rn", function() vim.lsp.buf.rename() end,                 desc = "Rename" },
  { "K",          function() vim.lsp.buf.hover(opts) end,              desc = "Hover" },
  { "<leader>a",  function() vim.lsp.buf.code_action(opts) end,        desc = "Code action" },
  { "<leader>cf", function() vim.lsp.buf.format(opts) end,             desc = "Code format" },
  { "<leader>cq", function() Snacks.picker.diagnostics() end,          desc = "Open diagnostics" },
})
