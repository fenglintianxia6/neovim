return {
  -- LazyGit 插件
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      -- 设置 LazyGit 快捷键
      vim.keymap.set('n', '<leader>gg', '<Cmd>LazyGit<CR>', { 
        noremap = true, 
        silent = true, 
        desc = "Open LazyGit" 
      })
      
      -- 在项目根目录打开 LazyGit
      vim.keymap.set('n', '<leader>gG', function()
        local project_root = vim.fn.fnamemodify(vim.fn.getcwd(), ':p')
        vim.cmd('LazyGit ' .. project_root)
      end, { 
        noremap = true, 
        silent = true, 
        desc = "Open LazyGit in project root" 
      })
      
      -- 查看当前文件的 Git 历史
      vim.keymap.set('n', '<leader>gh', function()
        local current_file = vim.fn.expand('%:p')
        if current_file ~= "" then
          vim.cmd('LazyGit --filter ' .. current_file)
        else
          vim.notify("No file is currently open", vim.log.levels.WARN)
        end
      end, { 
        noremap = true, 
        silent = true, 
        desc = "View Git history for current file" 
      })
      
      -- 查看当前文件的变更
      vim.keymap.set('n', '<leader>gd', function()
        local current_file = vim.fn.expand('%:t')
        if current_file ~= "" then
          vim.cmd('LazyGit --filter ' .. current_file)
        else
          vim.notify("No file is currently open", vim.log.levels.WARN)
        end
      end, { 
        noremap = true, 
        silent = true, 
        desc = "View Git diff for current file" 
      })
    end,
  },
} 