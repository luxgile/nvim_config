local M = {}

local p = {
  -- Add plugins here
}

function init()
  local omnisharp_bin = "D:/Utils/Omnisharp/OmniSharp.exe"
  require 'lspconfig'.omnisharp.setup {
    cmd = {
      'mono',
      '--assembly-loader=strict',
      omnisharp_bin,
      use_mono = true,
    },
  }
end

function M.setup(plugins, setups)
  table.foreach(p, function(k, v) table.insert(plugins, v) end)
  table.insert(setups, init)
end

return M
