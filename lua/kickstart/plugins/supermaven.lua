return {
  {
    'supermaven-inc/supermaven-nvim',
    event = 'InsertEnter',
    cmd = {
      'SupermavenUseFree',
      'SupermavenUsePro',
    },
    opts = {
      keymaps = {
        accept_suggestion = '<M-a>',
        clear_suggestion = '<M-s>',
        accept_word = '<M-w>',
      },
      color = {
        background = '#1e1e1e',
        foreground = '#d4be98',
        border = '#1e1e1e',
      },
    },
  },
}
