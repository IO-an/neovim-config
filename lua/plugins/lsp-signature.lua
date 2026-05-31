-- Плагин для отображения сигнатуры функции при вводе аргументов.
-- Окно компактное, без лишних рамок, появляется автоматически.
return {
  'ray-x/lsp_signature.nvim',
  event = 'InsertEnter',          -- загружается при входе в режим вставки
  config = function()
    require('lsp_signature').setup({
      floating_window = true,
      floating_window_above_cur_line = true,
      handler_opts = { border = 'single' },  -- тонкая рамка
      hint_enable = false,
      hi_parameter = 'LspSignatureActiveParameter',
    })
  end,
}