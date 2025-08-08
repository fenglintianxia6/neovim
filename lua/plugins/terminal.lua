return {
  -- 悬浮终端
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        -- 终端大小
        size = 20,
        -- 打开方向
        open_mapping = [[<c-\>]],
        -- 隐藏数字
        hide_numbers = true,
        -- 阴影
        shade_filetypes = {},
        -- 阴影程度
        shade_terminals = true,
        -- 阴影程度
        shading_factor = 2,
        -- 开始插入模式
        start_in_insert = true,
        -- 插入模式快捷键
        insert_mappings = true,
        -- 终端映射
        terminal_mappings = true,
        -- 持久化大小
        persist_size = true,
        -- 方向
        direction = "float",
        -- 关闭退出
        close_on_exit = true,
        -- 外壳
        shell = vim.o.shell,
        -- 浮动窗口配置
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })
    end,
  },
  
  -- Git 插件
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      -- 配置 lazygit
      vim.g.lazygit_floating_window_winblend = 0
      vim.g.lazygit_floating_window_scaling_factor = 0.9
      vim.g.lazygit_floating_window_border_chars = { '╭', '╮', '╰', '╯' }
      vim.g.lazygit_floating_window_use_plenary = 0
      vim.g.lazygit_use_neovim_remote = 1
      vim.g.lazygit_use_custom_config_file_path = 0
      vim.g.lazygit_config_file_path = ''
    end,
  },
  
  -- Git 状态显示
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
          ignore_whitespace = false,
        },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
      })
    end,
  },
} 