-- Установка LSP-серверов через Mason и их настройка через встроенный API Neovim.
-- Никаких депрекаций, всё по официальной документации 0.12+.
return {
  'williamboman/mason.nvim',
  event = 'VeryLazy',
  opts = {
    ensure_installed = {
      'cssls', 'html', 'clangd', 'glsl_analyzer',
      'pyright', 'gopls', 'rust_analyzer', 'bashls', 'jsonls',
      'yamlls', 'ts_ls', 'eslint', 'stylelint_lsp',
    },
  },
  config = function(_, opts)
    require('mason').setup(opts)

    -- Передаём возможности автодополнения всем LSP-клиентам
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    vim.lsp.config('*', { capabilities = capabilities })

    -- Серверы, которые мы хотим запускать (Mason уже должен их установить)
    local servers = {
      'cssls', 'html', 'clangd', 'glsl_analyzer', 'pasls',
      'pyright', 'gopls', 'rust_analyzer', 'bashls', 'jsonls',
      'yamlls', 'ts_ls', 'eslint', 'stylelint_lsp',
      'jdtls', 'csharp_ls', 'metals',
    }

    -- Включаем каждый сервер; если он не установлен, выведется предупреждение,
    -- но Neovim продолжит работу.
    for _, server in ipairs(servers) do
      local ok, err = pcall(vim.lsp.enable, server)
      if not ok then
        vim.notify('LSP server not found: ' .. server, vim.log.levels.WARN)
      end
    end
  end,
}