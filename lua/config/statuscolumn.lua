-- Заменяет стандартную колонку номеров строк: если на строке есть ошибка,
-- выводится ' E', иначе – номер строки.

function _G.statuscolumn()
  local line = vim.v.lnum                -- абсолютный номер строки
  local buf = vim.api.nvim_get_current_buf()
  local diagnostics = vim.diagnostic.get(buf, { lnum = line - 1 })

  -- Проверяем наличие ошибок (severity ERROR)
  local has_error = false
  for _, d in ipairs(diagnostics) do
    if d.severity == vim.diagnostic.severity.ERROR then
      has_error = true
      break
    end
  end

  if has_error then
    return ' E'    -- можно заменить на иконку Nerd Font, если шрифт поддерживает
  else
    -- Абсолютный номер строки
    return ' ' .. line
  end
end

-- Применяем функцию для каждой строки
vim.opt.statuscolumn = '%!v:lua.statuscolumn()'