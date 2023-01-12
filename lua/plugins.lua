function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
  vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

  return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
      'jedrzejboczar/possession.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
    }

    use 'nvim-telescope/telescope-file-browser.nvim' 

    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
      requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
      'goolord/alpha-nvim',
      config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
      end
    }

    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

    use {"akinsho/toggleterm.nvim", tag = '*', config = function()
      require("toggleterm").setup {
        size = 7, 
      }
    end}


    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    }

    require("telescope").load_extension "file_browser"
    require('telescope').load_extension('possession')
    require('possession').setup {
      commands = {
        save = "SSave",
        load = "SLoad",
        delete = "SDelete",
        list = "SList",
      },
      autosave = {
        current = true,
        tmp = true,
        tmp_name = "temp",
        on_load = true,
        on_quit = true,
      }
    }
    require'nvim-treesitter.configs'.setup {
      ensure_installed = {  "rust" },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    }

  end)
