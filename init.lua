-- Точка входа конфигурации Neovim.
-- Устанавливает lazy.nvim, подключает базовые настройки, горячие клавиши,
-- кастомную статусную колонку, настройки Neovide и контекстное меню.

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  -- Клонируем lazy.nvim, если он ещё не установлен
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Базовые параметры редактора
require('config.options')
-- Дополнительные горячие клавиши
require('config.keymaps')
-- Кастомная статусная колонка с индикацией ошибок
require('config.statuscolumn')

-- Настройки Neovide (только при запуске через него)
if vim.g.neovide then
  require('config.neovide')
end

-- Контекстное меню (правая кнопка мыши и <leader>m)
require('config.contextmenu')

-- Инициализация плагинов. Все спецификации плагинов лежат в lua/plugins/
require('lazy').setup({
  { import = 'plugins' },
}, {
  ui = { border = 'none' },   -- минималистичный вид lazy.nvim
})