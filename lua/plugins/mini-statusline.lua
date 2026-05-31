-- Простая строка состояния с количеством ошибок/предупреждений,
-- режимом, именем файла и позицией.
return {
  'echasnovski/mini.statusline',
  event = 'VeryLazy',
  config = function()
    local statusline = require('mini.statusline')
    local diagnostics = require('mini.statusline').diagnostics  -- модуль диагностики

    statusline.setup({
      use_icons = false,
      set_vim_settings = false,
      -- Функция для активной статус-строки (возвращает строку)
      content = {
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local file = MiniStatusline.section_file({ trunc_width = 140 })
          local diag = MiniStatusline.section_diagnostics({
            symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
            -- nil для отображения количества всех severity
            -- Можно оставить все, чтобы видеть и предупреждения
            options = { count = true },
          })
          local location = MiniStatusline.section_location()

          -- Формируем строку: режим + файл + диагностика слева, позиция справа
          return MiniStatusline.combine_groups({
            { hl = mode_hl, strings = { mode, ' ', file } },
            '%<',  -- обрезать слева при нехватке места
            diag,
            '%=',  -- заполнить пространство
            location,
          })
        end,
      },
    })
  end,
}