-- Устанавливает тёмную тему Gruvbox. Загружается первой.
return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000,   -- гарантирует применение темы до остальных плагинов
  config = function()
    vim.o.background = 'dark'
    vim.cmd.colorscheme('gruvbox')
  end,
}