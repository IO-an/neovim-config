-- Простая строка состояния с отображением количества ошибок и предупреждений
-- во всём проекте, а также режима, имени файла и позиции.
return {
  'echasnovski/mini.statusline',
  event = 'VeryLazy',
  config = function()
    local statusline = require('mini.statusline')

    -- Функция, возвращающая строку с количеством ошибок и предупреждений
    local function diagnostics_summary()
      local counts = vim.diagnostic.count(nil)  -- nil = все буферы
      if not counts or vim.tbl_isempty(counts) then
        return ''
      end
      local errors = counts[vim.diagnostic.severity.ERROR] or 0
      local warnings = counts[vim.diagnostic.severity.WARN] or 0
      return string.format('E:%d W:%d', errors, warnings)
    end

    statusline.setup({
      use_icons = false,   -- только текст
      set_vim_settings = false,
      content = {
        active = {
          -- Левая часть статус-строки: режим, имя файла, диагностика
          left = function()
            local mode = statusline.section_mode()
            local file = statusline.section_file()
            local diag = diagnostics_summary()
            return mode .. ' ' .. file .. ' ' .. diag
          end,
          -- Правая часть: положение в файле
          right = function()
            return statusline.section_location()
          end,
        },
      },
    })
  end,
}