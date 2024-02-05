require("core")

local lazy_setup = require("lazy_setup")
lazy_setup.lazy_bootstrap()

local plugins = {}
local setups = {}
local setup = function(plugin)
  local ok, plugin = pcall(require, plugin)
  if ok then
    plugin.setup(plugins, setups)
  else
    print(plugin)
  end
end

setup("color_scheme")
setup("file_browser")
setup("lsp")
setup("rust")
setup("csharp")
setup("misc")

lazy_setup.setup(plugins)
table.foreach(setups,
  function(k, v)
    local ok, msg = pcall(v)
    if not ok then
      print(msg)
    end
  end
)
