return {
  'supermaven-inc/supermaven-nvim',
  opts = {
    -- disable_inline_completion = false,
    -- keymaps = {
    --   accept_suggestion = nil,
    -- },
  },

  {
    'saghen/blink.cmp',
    opts = {
      sources = {
        completion = {
          enabled_providers = { 'supermaven' },
        },
        providers = {
          supermaven = {
            name = 'supermaven',
            module = 'blink.compat.source',
            score_offset = 3,
          },
        },
      },
    },
  },
}
