if true then
  return {}
end

return {
  "neovim/nvim-lspconfig",
  keys = {
    {
      "gd",
      function()
        local oe = require("omnisharp_extended")
        if LazyVim.has("telescope.nvim") then
          oe.telescope_lsp_definitions()
        else
          oe.lsp_definitions()
        end
      end,
      desc = "Goto Definition (OmniSharp)",
      ft = "cs", -- Only apply this to C# files
    },
  },
}
