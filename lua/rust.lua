local add = MiniDeps.add
local lspconfig = require('lspconfig')

-- Rust
add('mrcjkb/rustaceanvim')

-- WGSL
vim.cmd("au BufNewFile,BufRead *.wgsl set filetype=wgsl")
vim.filetype.add({
  extenstion = {
    wgsl = "wgsl",
  }
})
lspconfig.wgsl_analyzer.setup {}
