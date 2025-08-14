return {
  -- 自动保存插件
  {
    "pocco81/auto-save.nvim",
    config = function()
      local ok, autosave = pcall(require, 'auto-save')
      if not ok then
        vim.notify("auto-save.nvim not found!", vim.log.levels.ERROR)
        return
      end

      autosave.setup({
        enabled = true, -- 启用自动保存
        execution_message = {
          message = function() -- 自定义保存消息
            return "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S")
          end,
          dim = 0.18, -- 消息透明度
          cleaning_interval = 1250, -- 清理间隔（毫秒）
        },
        trigger_events = { -- 触发自动保存的事件
          "InsertLeave", -- 离开插入模式
          "TextChanged", -- 文本改变
          "BufLeave", -- 离开 buffer
          "FocusLost", -- 失去焦点
        },
        write_all_buffers = false, -- 是否保存所有 buffer
        debounce_delay = 135, -- 防抖延迟（毫秒）
        callbacks = { -- 回调函数
          before_saving = function()
            -- 保存前的操作
            vim.notify("正在自动保存...", vim.log.levels.INFO)
          end,
          after_saving = function()
            -- 保存后的操作
            vim.notify("自动保存完成！", vim.log.levels.INFO)
          end,
        },
        -- 排除的文件类型
        excluded_filetypes = {
          "NvimTree", -- 文件浏览器
          "Outline", -- 大纲
          "TelescopePrompt", -- Telescope 提示
          "TelescopeResults", -- Telescope 结果
          "lazy", -- Lazy 插件管理器
          "help", -- 帮助文档
          "terminal", -- 终端
          "toggleterm", -- 终端
          "qf", -- 快速修复
          "lspinfo", -- LSP 信息
          "checkhealth", -- 健康检查
          "man", -- 手册页
          "gitcommit", -- Git 提交
          "gitrebase", -- Git 变基
          "gitconfig", -- Git 配置
          "gitignore", -- Git 忽略
          "gitattributes", -- Git 属性
          "gitmodules", -- Git 模块
          "git-blame", -- Git 责备
          "git-diff", -- Git 差异
          "git-log", -- Git 日志
          "git-status", -- Git 状态
          "git-reflog", -- Git 引用日志
          "git-stash", -- Git 储藏
          "git-tag", -- Git 标签
          "git-branch", -- Git 分支
          "git-remote", -- Git 远程
          "git-submodule", -- Git 子模块
          "git-worktree", -- Git 工作树
          "git-notes", -- Git 笔记
          "git-credential", -- Git 凭据
          "git-attributes", -- Git 属性
          "git-blame", -- Git 责备
          "git-diff", -- Git 差异
          "git-log", -- Git 日志
          "git-status", -- Git 状态
          "git-reflog", -- Git 引用日志
          "git-stash", -- Git 储藏
          "git-tag", -- Git 标签
          "git-branch", -- Git 分支
          "git-remote", -- Git 远程
          "git-submodule", -- Git 子模块
          "git-worktree", -- Git 工作树
          "git-notes", -- Git 笔记
          "git-credential", -- Git 凭据
        },
        -- 排除的文件路径模式
        excluded_paths = {
          "*.tmp", -- 临时文件
          "*.temp", -- 临时文件
          "*.swp", -- Vim 交换文件
          "*.swo", -- Vim 交换文件
          "*.bak", -- 备份文件
          "*.backup", -- 备份文件
          "*.orig", -- 原始文件
          "*.rej", -- 拒绝文件
          "*.log", -- 日志文件
          "*.cache", -- 缓存文件
          "*.tmp", -- 临时文件
          "*.temp", -- 临时文件
          "*.swp", -- Vim 交换文件
          "*.swo", -- Vim 交换文件
          "*.bak", -- 备份文件
          "*.backup", -- 备份文件
          "*.orig", -- 原始文件
          "*.rej", -- 拒绝文件
          "*.log", -- 日志文件
          "*.cache", -- 缓存文件
        },
      })

      -- 设置快捷键
      local opts = { noremap = true, silent = true }

      -- 切换自动保存
      vim.keymap.set('n', '<leader>as', function()
        if autosave.opts.enabled then
          autosave.disable()
          vim.notify("自动保存已禁用", vim.log.levels.WARN)
        else
          autosave.enable()
          vim.notify("自动保存已启用", vim.log.levels.INFO)
        end
      end, { desc = "Toggle auto-save" })

      -- 手动保存
      vim.keymap.set('n', '<leader>aw', function()
        autosave.save()
      end, { desc = "Manual auto-save" })

      -- 显示自动保存状态
      vim.keymap.set('n', '<leader>ast', function()
        local status = autosave.opts.enabled and "启用" or "禁用"
        vim.notify("自动保存状态: " .. status, vim.log.levels.INFO)
      end, { desc = "Show auto-save status" })

      -- 添加命令
      vim.api.nvim_create_user_command('AutoSaveToggle', function()
        if autosave.opts.enabled then
          autosave.disable()
          print("自动保存已禁用")
        else
          autosave.enable()
          print("自动保存已启用")
        end
      end, {})

      vim.api.nvim_create_user_command('AutoSaveStatus', function()
        local status = autosave.opts.enabled and "启用" or "禁用"
        print("自动保存状态: " .. status)
      end, {})

      -- 在状态栏显示自动保存状态
      vim.opt.statusline = vim.opt.statusline .. "%{v:lua.require('auto-save').opts.enabled ? ' [AutoSave]' : ''}"
    end,
  },
} 