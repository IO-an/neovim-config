-- Установка и настройка LSP-серверов через Mason + встроенный клиент Neovim.
return {
  'williamboman/mason.nvim',
  event = 'VeryLazy',
  opts = {
    -- Серверы, которые Mason установит автоматически
    ensure_installed = {
      'cssls', 'html', 'clangd', 'glsl_analyzer', 'ruby_lsp',
      'pyright', 'gopls', 'rust_analyzer', 'bashls', 'jsonls',
      'yamlls', 'ts_ls', 'eslint', 'stylelint_lsp',
    },
  },
  config = function(plugin, opts)
    require('mason').setup(opts)

    -- Передаём capabilities от nvim-cmp глобально
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    vim.lsp.config['*'].capabilities = capabilities

    -- Все серверы (включая те, что могут быть установлены вручную)
    local servers = {
      'cssls', 'html', 'clangd', 'glsl_analyzer', 'ruby_lsp',
      'pyright', 'gopls', 'rust_analyzer', 'bashls', 'jsonls',
      'yamlls', 'ts_ls', 'eslint', 'stylelint_lsp',
      'jdtls', 'csharp_ls', 'metals', 'pasls',
    }

    -- Пытаемся включить LSP для каждого сервера
    for _, server in ipairs(servers) do
      local ok, _ = pcall(vim.lsp.enable, server)
      if not ok then
        vim.notify('LSP server not found: ' .. server, vim.log.levels.WARN)
      end
    end
  end,
}