local add = MiniDeps.add

-- File difference visualizer
add('echasnovski/mini.diff')
require('mini.diff').setup()

add('echasnovski/mini-git')
require('mini.git').setup()
