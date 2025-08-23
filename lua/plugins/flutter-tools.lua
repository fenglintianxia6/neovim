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
  }
} 
