-- Oil.nvim – файловый менеджер в виде буфера.
-- Показывает скрытые файлы по умолчанию; H переключает их видимость.
return {
  'stevearc/oil.nvim',
  cmd = 'Oil',
  keys = { { '-', '<cmd>Oil<cr>', desc = 'Открыть папку' } },
  config = function()
    require('oil').setup({
      default_file_explorer = true,
      view_options = {
        show_hidden = true,   -- показываем скрытые файлы и папки
      },
      keymaps = {
        ['H'] = 'actions.toggle_hidden',   -- переключение видимости скрытых
      },
    })
  end,
}