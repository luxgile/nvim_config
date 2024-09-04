local M = {}

local p = {
  -- Add plugins here
}

function init()
  -- Add setup here
end

function M.setup(plugins, setups)
  table.foreach(p, function(k, v) table.insert(plugins, v) end)
  table.insert(setups, init)
end

return M
