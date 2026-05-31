-- Настройка LSP: установка серверов через Mason и интеграция через nvim-lspconfig.
-- Используется nvim-lspconfig с capabilities от cmp. Депрекейшн-сообщения подавлены.
return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    require('mason').setup()

    local servers = {
      'cssls', 'html', 'clangd', 'glsl_analyzer', 'eslint',
      'pyright', 'gopls', 'rust_analyzer', 'bashls', 'jsonls',
      'yamlls', 'ts_ls', 'stylelint_lsp',
    }
    require('mason-lspconfig').setup({ ensure_installed = servers })

    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lspconfig = require('lspconfig')

    for _, server in ipairs(servers) do
      lspconfig[server].setup({ capabilities = capabilities })
    end

    -- Тяжёлые серверы, которые могут быть установлены вручную
    local optional = { 'jdtls', 'csharp_ls', 'metals', 'pasls' }
    for _, server in ipairs(optional) do
      pcall(function()
        lspconfig[server].setup({ capabilities = capabilities })
      end)
    end
  end,
}