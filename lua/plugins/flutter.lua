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
      -- 自动检测 FVM 管理的 Flutter 路径
      local function get_fvm_flutter_path()
        local current_dir = vim.fn.getcwd()
        local fvm_config_path = current_dir .. "/.fvm/flutter_sdk"
        
        -- 检查当前目录是否有 FVM 配置
        if vim.fn.isdirectory(fvm_config_path) == 1 then
          local flutter_executable = fvm_config_path .. "/bin/flutter"
          if vim.fn.executable(flutter_executable) == 1 then
            return flutter_executable
          end
        end
        
        -- 向上查找父目录中的 FVM 配置
        local parent_dir = current_dir
        for i = 1, 10 do -- 最多向上查找10层目录
          parent_dir = vim.fn.fnamemodify(parent_dir, ":h")
          if parent_dir == current_dir then
            break -- 已经到达根目录
          end
          
          local parent_fvm_path = parent_dir .. "/.fvm/flutter_sdk"
          if vim.fn.isdirectory(parent_fvm_path) == 1 then
            local flutter_executable = parent_fvm_path .. "/bin/flutter"
            if vim.fn.executable(flutter_executable) == 1 then
              return flutter_executable
            end
          end
          current_dir = parent_dir
        end
        
        -- 如果没有找到 FVM 配置，返回 nil 使用系统默认的 Flutter
        return nil
      end
      
      require("flutter-tools").setup({
        ui = {
          border = "rounded",
        },
        flutter_path = get_fvm_flutter_path(),
      })
    end
  }
} 