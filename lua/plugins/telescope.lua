-- Telescope – интерактивный поиск файлов, текста, буферов и диагностик с предпросмотром.
-- Предусмотрены версии без игнора скрытых/исключённых директорий.
return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = 'Telescope',   -- загружается только при вызове команды Telescope
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Поиск файлов (игнорируя node_modules/.git)' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>',  desc = 'Поиск текста (игнорируя node_modules/.git)' },
    { '<leader>fF', function() require('telescope.builtin').find_files({ hidden = true, no_ignore = true }) end, desc = 'Поиск файлов (все)' },
    { '<leader>fG', function() require('telescope.builtin').live_grep({ hidden = true, no_ignore = true }) end, desc = 'Поиск текста (все)' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>',    desc = 'Открытые буферы' },
    { '<leader>dd', '<cmd>Telescope diagnostics<cr>', desc = 'Диагностика проекта' },
  },
  config = function()
    require('telescope').setup({
      defaults = {
        layout_strategy = 'vertical',
        layout_config = {
          width = 0.9,
          height = 0.8,
          preview_width = 0.5,        -- превью занимает половину ширины окна
        },
        preview = {
          filesize_limit = 0.5,        -- максимальный размер файла для предпросмотра (МБ)
        },
        file_ignore_patterns = {
          'node_modules', '.git/',    -- исключаем из поиска служебные каталоги
        },
      },
    })
  end,
}