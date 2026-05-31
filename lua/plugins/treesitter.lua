-- Tree-sitter – парсер, который строит синтаксическое дерево и даёт точную
-- подсветку, структурную навигацию и отступы.
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',          -- обновляет парсеры после установки
  event = 'VeryLazy',           -- загружается без блокировки стартового экрана
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'html', 'css', 'scss', 'less',
        'javascript', 'typescript', 'tsx',
        'json', 'yaml',
        'c', 'cpp', 'glsl',
        'ruby', 'python', 'go', 'rust',
        'bash',
        'java', 'c_sharp', 'scala',
        'pascal',
        'lua',
        'styled',  -- styled-components
        'dotenv',  -- .env файлы
      },
      highlight = { enable = true },   -- включаем подсветку Tree-sitter
      indent = { enable = true },      -- включаем отступы по синтаксису
    })
  end,
}