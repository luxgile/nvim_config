local M = {}

local p = {
  { 'echasnovski/mini-git', version = false, main = 'mini.git' },
}

function init()
  require('mini.git').setup()
end

function M.setup(plugins, setups)
  table.foreach(p, function(k, v) table.insert(plugins, v) end)
  table.insert(setups, init)
end

return M
