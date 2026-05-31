-- Базовые параметры редактора.
-- Полностью отключены временные файлы: swap, backup, undo, shada.

-- Нумерация строк: только абсолютная
vim.opt.number = true
vim.opt.relativenumber = false

-- Включаем поддержку мыши во всех режимах (выделение, клики)
vim.opt.mouse = 'a'

-- Командная строка всегда занимает ровно одну строку внизу
vim.opt.cmdheight = 1

-- Резервируем 1 колонку для знаков (например, диагностики)
vim.opt.signcolumn = 'yes:1'

-- 24-битный цвет для корректной работы темы
vim.opt.termguicolors = true

-- Интервал проверки изменений (мс) – быстрее отображается диагностика
vim.opt.updatetime = 300

-- Не подсвечиваем строку с курсором
vim.opt.cursorline = false

-- Показываем частично введённые команды (например, после <leader>)
vim.opt.showcmd = true

-- Отключаем перенос строк
vim.opt.wrap = false

-- Полное отключение временных файлов
vim.opt.swapfile = false          -- никаких *.swp
vim.opt.backup = false            -- никаких *~
vim.opt.undofile = false          -- никаких .un~
vim.opt.shada = ''                -- не сохранять историю/метки

-- Убираем лишние сообщения (например, "written" при сохранении)
vim.opt.shortmess:append({ W = true, I = true })

-- Клавиша-лидер: пробел
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Символы для разделителей окон и пустых областей
vim.opt.fillchars = {
  vert = '│',   -- вертикальный разделитель окон
  fold = ' ',   -- за свёрнутым блоком
  eob = ' ',    -- после конца файла (убирает тильды)
}

-- Диагностика: ошибки не показываем виртуальным текстом в строке,
-- только подчёркивание и значок в статус-колонке
vim.diagnostic.config({
  virtual_text = false,   -- убираем виртуальный текст
  signs = false,          -- значки в signcolumn мы заменяем своей индикацией
  underline = true,       -- подчёркиваем ошибочный фрагмент
})

-- Компактное плавающее окно для диагностики при наведении курсора
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focus = false,
      scope = 'line',
      border = 'single',       -- тонкая рамка, как в VSCode
      header = '',             -- без заголовка
      prefix = '',             -- без префикса
      source = true,           -- показываем источник (eslint, ts_ls)
    })
  end,
})

-- Универсальные настройки для всех LSP-плавающих окон (ховер, сигнатура)
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = 'single' }
)
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = 'single' }
)

-- Автосоздание родительской папки при сохранении нового файла
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})