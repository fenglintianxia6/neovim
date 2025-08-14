return {
  -- Hop.nvim - 快速跳转和搜索插件
  {
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      local ok, hop = pcall(require, 'hop')
      if not ok then
        vim.notify("hop.nvim not found!", vim.log.levels.ERROR)
        return
      end

      -- 配置 Hop
      hop.setup({
        keys = 'etovxqpdygfblzhckisuran',
        char2_fallback_key = '<CR>',
        multi_windows = true,
        jump_on_sole_occurrence = false,
        create_hl_autocmd = false,
        uppercase_labels = false,
        current_line_only = false,
        hint_position = require 'hop.hint'.HintPosition.END,
        hint_offset = 1,
        -- 自定义高亮颜色
        highlights = {
          HopNextKey = { fg = '#ff007c', bold = true },
          HopNextKey1 = { fg = '#00dfff', bold = true },
          HopNextKey2 = { fg = '#2b8db3', bold = true },
          HopUnmatched = { fg = '#666666', bold = true },
        },
        -- 支持更长的字符搜索
        char2_fallback_key = '<CR>',
        char2_fallback_key_sequence = '<CR>',
      })

      -- 设置快捷键
      local opts = { noremap = true, silent = true }

      -- 主要搜索功能
      vim.keymap.set('n', 's', '<Cmd>HopChar2<CR>', opts) -- 搜索2个字符
      vim.keymap.set('n', 'S', '<Cmd>HopChar1<CR>', opts) -- 搜索1个字符
      
      -- 多字符搜索功能
      vim.keymap.set('n', '<leader>sc', '<Cmd>HopChar2<CR>', opts) -- 搜索2个字符
      vim.keymap.set('n', '<leader>s3', '<Cmd>HopChar3<CR>', opts) -- 搜索3个字符
      vim.keymap.set('n', '<leader>s4', '<Cmd>HopChar4<CR>', opts) -- 搜索4个字符
      vim.keymap.set('n', '<leader>s5', '<Cmd>HopChar5<CR>', opts) -- 搜索5个字符
      
      -- 其他搜索模式
      vim.keymap.set('n', '<leader>hw', '<Cmd>HopWord<CR>', opts) -- 搜索单词
      vim.keymap.set('n', '<leader>hl', '<Cmd>HopLine<CR>', opts) -- 搜索行
      vim.keymap.set('n', '<leader>hp', '<Cmd>HopPattern<CR>', opts) -- 搜索模式（支持正则表达式）
      
      -- 当前行搜索
      vim.keymap.set('n', '<leader>hc', '<Cmd>HopChar1CurrentLine<CR>', opts) -- 当前行搜索字符
      vim.keymap.set('n', '<leader>hwc', '<Cmd>HopWordCurrentLine<CR>', opts) -- 当前行搜索单词
      
      -- 多窗口搜索
      vim.keymap.set('n', '<leader>hm', '<Cmd>HopChar2Multi<CR>', opts) -- 多窗口搜索字符
      vim.keymap.set('n', '<leader>hwm', '<Cmd>HopWordMulti<CR>', opts) -- 多窗口搜索单词
      
      -- 可视模式搜索
      vim.keymap.set('v', 's', '<Cmd>HopChar2<CR>', opts)
      vim.keymap.set('v', 'S', '<Cmd>HopChar1<CR>', opts)
      
      -- 操作模式搜索
      vim.keymap.set('o', 's', '<Cmd>HopChar2<CR>', opts)
      vim.keymap.set('o', 'S', '<Cmd>HopChar1<CR>', opts)
      
      -- 添加说明注释
      vim.api.nvim_create_user_command('HopHelp', function()
        print("Hop.nvim 搜索快捷键:")
        print("  s          - 搜索2个字符")
        print("  S          - 搜索1个字符")
        print("  <leader>sc - 搜索2个字符")
        print("  <leader>s3 - 搜索3个字符")
        print("  <leader>s4 - 搜索4个字符")
        print("  <leader>s5 - 搜索5个字符")
        print("  <leader>hp - 搜索模式（支持正则表达式）")
        print("  <leader>hw - 搜索单词")
        print("  <leader>hl - 搜索行")
      end, {})
    end,
  },
} 