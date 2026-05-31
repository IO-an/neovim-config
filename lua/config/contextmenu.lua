-- Контекстное меню, вызываемое правой кнопкой мыши или <leader>m.
-- Показывает список действий в командной строке, выбор через стрелки и Enter.

local function show_context_menu()
  local items = {
    'Copy (yank to clipboard)',
    'Paste from clipboard',
    'Quick Fix (Code Action)',
    'Go to Definition',
    'Find References',
    'Rename',
    'Format buffer',
  }

  vim.ui.select(items, {
    prompt = 'Context Menu',
    format_item = function(item)
      return item
    end,
  }, function(choice)
    if not choice then return end

    if choice == 'Copy (yank to clipboard)' then
      pcall(vim.cmd, 'normal! "+y')
    elseif choice == 'Paste from clipboard' then
      pcall(vim.cmd, 'normal! "+p')
    elseif choice == 'Quick Fix (Code Action)' then
      pcall(vim.lsp.buf.code_action)
    elseif choice == 'Go to Definition' then
      pcall(vim.lsp.buf.definition)
    elseif choice == 'Find References' then
      pcall(vim.lsp.buf.references)
    elseif choice == 'Rename' then
      pcall(vim.lsp.buf.rename)
    elseif choice == 'Format buffer' then
      pcall(vim.lsp.buf.format)
    end
  end)
end

-- Маппинг на правый клик мыши (работает в Neovide и GUI-терминалах)
vim.keymap.set('n', '<RightMouse>', show_context_menu, { desc = 'Контекстное меню' })
-- Резервный маппинг на клавиатуру: <leader>m
vim.keymap.set('n', '<leader>m', show_context_menu, { desc = 'Контекстное меню' })