return {
  'echasnovski/mini.statusline',
  event = 'VeryLazy',
  config = function()
    local statusline = require('mini.statusline')

    statusline.setup({
      use_icons = false,
      set_vim_settings = false,
      content = {
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local file = vim.fn.expand('%:t')                     -- только имя файла
          local diag = MiniStatusline.section_diagnostics({
            symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
            options = { count = true },
          })
          local position = string.format('%d:%d', vim.fn.line('.'), vim.fn.col('.'))

          return MiniStatusline.combine_groups({
            { hl = mode_hl, strings = { mode, ' ', file } },
            '%<',
            diag,
            '%=',
            position,
          })
        end,
      },
    })
  end,
}