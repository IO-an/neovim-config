-- Настройка LSP-клиента. Устанавливает серверы через Mason и передаёт
-- им capabilities от nvim-cmp для корректной работы автодополнения.
-- ESLint и Stylelint добавлены как линтеры.
return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'williamboman/mason.nvim',             -- менеджер установки LSP-серверов
    'williamboman/mason-lspconfig.nvim',   -- интеграция Mason с lspconfig
  },
  config = function()
    require('mason').setup()

    -- Легковесные серверы, устанавливаются автоматически
    local servers = {
      'cssls', 'html', 'clangd', 'glsl_analyzer', 'ruby_lsp',
      'pyright', 'gopls', 'rust_analyzer', 'bashls', 'jsonls',
      'yamlls', 'ts_ls',
      'eslint',          -- ESLint: линтинг JS/TS
      'stylelint_lsp',   -- Stylelint: линтинг CSS/SCSS
    }
    require('mason-lspconfig').setup({ ensure_installed = servers })

    -- Возможности, которые клиент передаёт серверам
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    local lspconfig = require('lspconfig')
    for _, server in ipairs(servers) do
      lspconfig[server].setup({ capabilities = capabilities })
    end

    -- Тяжёлые серверы (jdtls, csharp_ls, metals, pasls) — устанавливаются вручную
    local optional_servers = { 'jdtls', 'csharp_ls', 'metals', 'pasls' }
    for _, server in ipairs(optional_servers) do
      pcall(function()
        lspconfig[server].setup({ capabilities = capabilities })
      end)
    end
  end,
}