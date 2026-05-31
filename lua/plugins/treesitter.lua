-- Дерево синтаксического разбора – точная подсветка и отступы.
-- Использует новое API nvim-treesitter (без nvim-treesitter.configs).
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = 'VeryLazy',
  opts = {
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
      'dotenv',  -- .env
    },
    highlight = { enable = true },
    indent = { enable = true },
  },
}