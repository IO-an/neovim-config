-- Добавляет анимированную подсветку совпадений при поиске через / или ?.
-- Показывает количество найденных результатов и сохраняет контекст.
return {
  'kevinhwang91/nvim-hlslens',
  keys = { '/', '?', '*', '#', 'n', 'N' },
  config = function()
    require('hlslens').setup()
    -- Переназначаем n/N, чтобы обновлять подсветку после перемещения
    vim.keymap.set('n', 'n',
      '<cmd>execute("normal! " . v:count1 . "n")<cr><cmd>lua require("hlslens").start()<cr>')
    vim.keymap.set('n', 'N',
      '<cmd>execute("normal! " . v:count1 . "N")<cr><cmd>lua require("hlslens").start()<cr>')
  end,
}