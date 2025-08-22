return {
  -- 状态栏插件
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local lualine = require('lualine')
      
      -- 获取 FVM Flutter 版本和来源信息
      local function get_fvm_flutter_info()
        local current_dir = vim.fn.getcwd()
        local fvm_config_path = current_dir .. "/.fvm/flutter_sdk"
        
        -- 检查当前目录是否有 FVM 配置
        if vim.fn.isdirectory(fvm_config_path) == 1 then
          local version_file = fvm_config_path .. "/version"
          if vim.fn.filereadable(version_file) == 1 then
            local version = vim.fn.readfile(version_file)[1]
            return {
              version = version:gsub("%s+", ""),
              source = "local",
              icon = "󰘧" -- 本地 FVM 图标
            }
          end
        end
        
        -- 向上查找父目录中的 FVM 配置
        local parent_dir = current_dir
        for i = 1, 10 do
          parent_dir = vim.fn.fnamemodify(parent_dir, ":h")
          if parent_dir == current_dir then
            break
          end
          
          local parent_fvm_path = parent_dir .. "/.fvm/flutter_sdk"
          if vim.fn.isdirectory(parent_fvm_path) == 1 then
            local version_file = parent_fvm_path .. "/version"
            if vim.fn.filereadable(version_file) == 1 then
              local version = vim.fn.readfile(version_file)[1]
              return {
                version = version:gsub("%s+", ""),
                source = "parent",
                icon = "󰘧", -- 父目录 FVM 图标
                path = parent_dir
              }
            end
          end
          current_dir = parent_dir
        end
        
        -- 如果没有找到 FVM 配置，使用全局 FVM
        local global_fvm_version = vim.fn.expand("$HOME/fvm/versions/3.27.2/version")
        if vim.fn.filereadable(global_fvm_version) == 1 then
          local version = vim.fn.readfile(global_fvm_version)[1]
          return {
            version = version:gsub("%s+", ""),
            source = "global_fvm",
            icon = "󰎚" -- 全局 FVM 图标
          }
        end
        
        -- 检查系统全局 Flutter
        local system_flutter = vim.fn.executable("flutter")
        if system_flutter == 1 then
          return {
            version = "system",
            source = "system",
            icon = "󰎙" -- 系统 Flutter 图标
          }
        end
        
        return nil
      end
      
      -- 自定义 FVM 版本组件
      local function fvm_version_component()
        local info = get_fvm_flutter_info()
        if info then
          local display_text = info.icon .. " "
          
          if info.source == "local" then
            display_text = display_text .. "Flutter " .. info.version
          elseif info.source == "parent" then
            display_text = display_text .. "Flutter " .. info.version .. " (parent)"
          elseif info.source == "global_fvm" then
            display_text = display_text .. "Flutter " .. info.version .. " (global FVM)"
          elseif info.source == "system" then
            display_text = display_text .. "Flutter (system)"
          end
          
          return display_text
        end
        return ""
      end
      
      lualine.setup({
        options = {
          theme = 'auto',
          component_separators = { left = '|', right = '|'},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {},
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {
            {'filename', path = 1},
            fvm_version_component, -- 添加 FVM 版本显示
          },
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        extensions = {}
      })
    end,
  },
} 