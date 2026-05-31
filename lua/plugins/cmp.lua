-- Движок автодополнения. Использует два источника: LSP (контекстные символы)
-- и пути файловой системы (для импортов). Сниппеты полностью отключены.
return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',          -- загружается при первом входе в режим вставки
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',       -- источник данных от LSP-серверов
    'hrsh7th/cmp-path',           -- источник путей
  },
  config = function()
    local cmp = require('cmp')
    cmp.setup({
      -- Блок snippet оставлен пустым, чтобы отключить сниппеты
      snippet = {
        expand = function() end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.select_next_item(),      -- следующий пункт
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),    -- предыдущий пункт
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- подтверждение
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },   -- приоритет 1: LSP (функции, переменные, классы)
        { name = 'path' },       -- приоритет 2: пути к файлам
      }),
    })
  end,
}