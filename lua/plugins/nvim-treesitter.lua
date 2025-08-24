return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- 启用语法高亮
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        -- 启用缩进
        indent = {
          enable = true,
        },
        -- 启用增量选择
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            node_decremental = "<BS>",
            scope_incremental = "<TAB>",
          },
        },
        -- 启用基于语法的代码折叠
        fold = {
          enable = true,
        },
        -- 确保安装的解析器
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "javascript",
          "typescript",
          "dart",  -- 重要：Dart 解析器
          "json",
          "yaml",
          "markdown",
          "bash",
          "python",
          "go",
          "rust",
          "cpp",
          "c",
          "java",
          "html",
          "css",
          "scss",
        },
        -- 自动安装解析器
        auto_install = true,
      })
    end,
  },
} 