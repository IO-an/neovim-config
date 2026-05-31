-- Дополнительные горячие клавиши

-- Выход из режима вставки последовательностью "jk"
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Выход в нормальный режим' })

-- Закрыть текущий буфер (файл)
vim.keymap.set('n', '<leader>x', '<cmd>bd<cr>', { desc = 'Закрыть буфер' })

-- Показать все ошибки проекта в location list (окно внизу)
vim.keymap.set('n', '<leader>e', function()
  vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.ERROR })
end, { desc = 'Показать все ошибки проекта' })

-- Показать документацию (ховер) – стандартное поведение K
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Документация' })

-- Показать сигнатуру функции
vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, { desc = 'Сигнатура' })

-- Переименование символа под курсором (LSP rename)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Переименовать' })

-- Навигация по LSP: переход к определению
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Перейти к определению' })

-- Дополнительные полезные LSP-маппинги (можно добавить по желанию)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Перейти к объявлению' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Показать ссылки на символ' })