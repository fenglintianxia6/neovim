return {
  {
    'nvim-flutter/flutter-tools.nvim',
    lazy = true,
    ft = "dart",
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function()
      
      require("flutter-tools").setup({
        ui = {
          border = "rounded",
        },
        fvm = true,
        lsp = {
          on_attach = function(client, bufnr)
            -- 确保这些映射存在
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code Action' })
          end,
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
            settings = {
              analysisExcludedFolders = {
                vim.fn.expand("$HOME/.pub-cache"),
                vim.fn.expand("$HOME/.fvm"),
              },
              enableSnippets = true,
              lineLength = 160,
              enableSdkFormatter = true,
              enableSnippets = true,
              showTodos = true,
              completeFunctionCalls = true,
            }
        },
        blocs = {
            enabled = true,
            code_actions = true, 
        }
      })
    end
  },

  -- Flutter Bloc boilerplate generator
  {
    'wa11breaker/flutter-bloc.nvim',
    dependencies = { 'nvimtools/none-ls.nvim' },
    config = function()
        require('flutter-bloc').setup({
            bloc_type = 'default',
            use_sealed_classes = false,
            enable_code_actions = true,
        })
    end,
}
} 
