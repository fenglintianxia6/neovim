return {
  -- LSP 配置插件
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- LSP 配置
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- 通用 LSP 设置
      local function on_attach(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        
        -- LSP 快捷键
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)
        
        -- 显示诊断信息
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', 'K', vim.diagnostic.open_float, opts)
        
        -- 自动修复快捷键
        vim.keymap.set('n', '<leader>cf', function()
          vim.lsp.buf.code_action({ only = { 'quickfix' } })
        end, opts)
        
        vim.keymap.set('n', '<leader>cr', function()
          vim.lsp.buf.code_action({ only = { 'refactor' } })
        end, opts)
      end

      -- 获取 FVM 的 Dart 路径
      local function get_fvm_dart_path()
        local current_dir = vim.fn.getcwd()
        local fvm_config_path = current_dir .. "/.fvm/flutter_sdk"
        
        -- 检查当前目录是否有 FVM 配置
        if vim.fn.isdirectory(fvm_config_path) == 1 then
          local dart_executable = fvm_config_path .. "/bin/dart"
          if vim.fn.executable(dart_executable) == 1 then
            return dart_executable
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
            local dart_executable = parent_fvm_path .. "/bin/dart"
            if vim.fn.executable(dart_executable) == 1 then
              return dart_executable
            end
          end
          current_dir = parent_dir
        end
        
        -- 如果没有找到 FVM 配置，使用全局 FVM
        local global_fvm_dart = vim.fn.expand("$HOME/fvm/versions/3.27.2/bin/dart")
        if vim.fn.executable(global_fvm_dart) == 1 then
          return global_fvm_dart
        end
        
        -- 最后回退到系统 Dart
        return "dart"
      end

      -- 获取当前 FVM Flutter 版本
      local function get_fvm_flutter_version()
        local current_dir = vim.fn.getcwd()
        local fvm_config_path = current_dir .. "/.fvm/flutter_sdk"
        
        -- 检查当前目录是否有 FVM 配置
        if vim.fn.isdirectory(fvm_config_path) == 1 then
          local version_file = fvm_config_path .. "/version"
          if vim.fn.filereadable(version_file) == 1 then
            local version = vim.fn.readfile(version_file)[1]
            return version:gsub("%s+", "") -- 移除空白字符
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
              return version:gsub("%s+", "")
            end
          end
          current_dir = parent_dir
        end
        
        -- 如果没有找到 FVM 配置，使用全局 FVM
        local global_fvm_version = vim.fn.expand("$HOME/fvm/versions/3.27.2/version")
        if vim.fn.filereadable(global_fvm_version) == 1 then
          local version = vim.fn.readfile(global_fvm_version)[1]
          return version:gsub("%s+", "")
        end
        
        return "unknown"
      end

      -- 添加命令来显示当前 FVM Flutter 版本
      vim.api.nvim_create_user_command('FVMVersion', function()
        local version = get_fvm_flutter_version()
        print("Current FVM Flutter version: " .. version)
      end, {})

      -- 获取当前 FVM Flutter 版本和来源信息
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
              path = fvm_config_path,
              icon = "󰘧"
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
                path = parent_fvm_path,
                icon = "󰘧"
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
            path = vim.fn.expand("$HOME/fvm/versions/3.27.2"),
            icon = "󰎚"
          }
        end
        
        -- 检查系统全局 Flutter
        local system_flutter = vim.fn.executable("flutter")
        if system_flutter == 1 then
          return {
            version = "system",
            source = "system",
            path = "system PATH",
            icon = "󰎙"
          }
        end
        
        return nil
      end

      -- 添加命令来显示详细的 Flutter SDK 信息
      vim.api.nvim_create_user_command('FlutterSDKInfo', function()
        local info = get_fvm_flutter_info()
        if info then
          print("Flutter SDK Information:")
          print("  Icon: " .. info.icon)
          print("  Version: " .. info.version)
          print("  Source: " .. info.source)
          print("  Path: " .. info.path)
          
          if info.source == "local" then
            print("  Status: Using local FVM SDK (project-specific)")
          elseif info.source == "parent" then
            print("  Status: Using parent directory FVM SDK")
          elseif info.source == "global_fvm" then
            print("  Status: Using global FVM SDK")
          elseif info.source == "system" then
            print("  Status: Using system Flutter (not FVM)")
          end
        else
          print("No Flutter SDK found")
        end
      end, {})

      -- Dart/Flutter LSP 配置
      lspconfig.dartls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { get_fvm_dart_path(), "language-server", "--protocol=lsp" },
        settings = {
          dart = {
            analysisExcludedFolders = {
              vim.fn.expand("$HOME/.pub-cache"),
              vim.fn.expand("$HOME/.fvm"),
            },
            lineLength = 160,
            enableSdkFormatter = true,
            enableSnippets = true,
            showTodos = true,
            completeFunctionCalls = true,
          },
        },
        init_options = {
          -- 自动导入
          onlyAnalyzeProjectsWithOpenFiles = false,
          suggestFromUnimportedLibraries = true,
        },
      })

      -- 设置诊断显示
      vim.diagnostic.config({
        virtual_text = {
          spacing = 4,
          prefix = "●",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
          header = "",
          prefix = function(diagnostic)
            local icons = {
              Error = " ",
              Warn = " ",
              Info = " ",
              Hint = " ",
            }
            return icons[diagnostic.severity] .. " "
          end,
        },
      })

      -- 设置浮动窗口样式
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = "rounded" }
      )

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = "rounded" }
      )
    end,
  },
} 
