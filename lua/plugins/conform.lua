-- Форматирует код с помощью внешних инструментов (Prettier, Black и т.п.).
-- Форматтеры автоматически устанавливаются через Mason благодаря mason-conform.nvim.
-- ESLint и Stylelint применяются после основных форматтеров.
return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',                    -- перед записью файла на диск
  dependencies = {
    'zapling/mason-conform.nvim',           -- синхронизирует Mason и Conform
  },
  config = function()
    require('conform').setup({
      formatters_by_ft = {
        javascript = { 'prettier', 'eslint' },
        typescript = { 'prettier', 'eslint' },
        css = { 'prettier', 'stylelint' },
        html = { 'prettier' },
        lua = { 'stylua' },
        python = { 'black' },
        go = { 'gofmt' },
        rust = { 'rustfmt' },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      -- Определение кастомных форматтеров
      formatters = {
        eslint = {
          command = 'eslint',
          args = { '--fix', '--stdin', '--stdin-filename', '$FILENAME' },
          stdin = true,
        },
        stylelint = {
          command = 'stylelint',
          args = { '--fix', '--stdin', '--stdin-filename', '$FILENAME' },
          stdin = true,
        },
      },
    })
  end,
}