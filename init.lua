require("core")

local lazy_setup = require("lazy_setup")
lazy_setup.lazy_bootstrap()

local plugins = {}
local setups = {}
local setup = function(plugin) require(plugin).setup(plugins, setups) end

setup("color_scheme")
setup("file_browser")
setup("misc")

lazy_setup.setup(plugins)
table.foreach(setups, function(k, v) pcall(v) end)
