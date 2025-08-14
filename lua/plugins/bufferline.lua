return {
  -- Buffer 标签页插件
  {
    "akinsho/bufferline.nvim",
    dependencies = { 
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      local ok, bufferline = pcall(require, 'bufferline')
      if not ok then
        vim.notify("bufferline not found!", vim.log.levels.ERROR)
        return
      end

      bufferline.setup({
        options = {
          mode = "buffers", -- 设置为 buffers 模式
          separator_style = "slant", -- 分隔符样式
          always_show_bufferline = true, -- 始终显示 bufferline
          show_buffer_close_icons = true, -- 显示关闭按钮
          show_close_icon = true,
          show_tab_indicators = true,
          show_duplicate_prefix = true,
          tab_size = 18,
          max_name_length = 18,
          max_prefix_length = 15,
          diagnostics = "nvim_lsp", -- 显示 LSP 诊断
          diagnostics_indicator = function(_, _, _)
            local icons = {
              Error = " ",
              Warn = " ",
              Hint = " ",
              Info = " ",
            }
            local ret = {}
            
            -- 安全地获取诊断信息
            local ok, diagnostics = pcall(vim.diagnostic.get, 0)
            if not ok or not diagnostics then
              return ""
            end
            
            for severity, icon in pairs(icons) do
              local severity_num = vim.diagnostic.severity[string.upper(severity)]
              if severity_num then
                local count = #vim.diagnostic.get(0, {severity = severity_num})
                if count > 0 then
                  table.insert(ret, icon .. count)
                end
              end
            end
            return table.concat(ret, " ")
          end,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              separator = true
            },
            {
              filetype = "Outline",
              text = "Symbols Outline",
              text_align = "center",
              separator = true
            }
          },
          color_icons = true,
          get_element_icon = function(element)
            local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
            return icon, hl
          end,
          modified_icon = "●",
          close_icon = "󰅖",
          left_trunc_marker = "󰅒",
          right_trunc_marker = "󰅓",
          name_formatter = function(buf)
            if buf.name:match('%.md') then
              return vim.fn.fnamemodify(buf.name, ':t')
            end
          end,
        },
        highlights = {
          fill = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "StatusLineNC" },
          },
          background = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "StatusLineNC" },
          },
          tab = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "StatusLineNC" },
          },
          tab_selected = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "StatusLine" },
          },
          tab_close = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "StatusLineNC" },
          },
          close_button = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "StatusLineNC" },
          },
          close_button_visible = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "StatusLineNC" },
          },
          close_button_selected = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "StatusLine" },
          },
          buffer_visible = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "StatusLineNC" },
          },
          buffer_selected = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "StatusLine" },
            bold = true,
            italic = true,
          },
          separator = {
            fg = { attribute = "bg", highlight = "StatusLineNC" },
            bg = { attribute = "bg", highlight = "StatusLineNC" },
          },
          separator_visible = {
            fg = { attribute = "bg", highlight = "StatusLineNC" },
            bg = { attribute = "bg", highlight = "StatusLineNC" },
          },
          separator_selected = {
            fg = { attribute = "bg", highlight = "StatusLine" },
            bg = { attribute = "bg", highlight = "StatusLine" },
          },
          modified = {
            fg = { attribute = "fg", highlight = "Special" },
          },
          modified_visible = {
            fg = { attribute = "fg", highlight = "Special" },
          },
          modified_selected = {
            fg = { attribute = "fg", highlight = "Special" },
          },
          duplicate = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "StatusLineNC" },
          },
          duplicate_visible = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "StatusLineNC" },
          },
          duplicate_selected = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "StatusLine" },
          },
          pick = {
            fg = { attribute = "fg", highlight = "Special" },
            bg = { attribute = "bg", highlight = "StatusLineNC" },
          },
          pick_visible = {
            fg = { attribute = "fg", highlight = "Special" },
            bg = { attribute = "bg", highlight = "StatusLineNC" },
          },
          pick_selected = {
            fg = { attribute = "fg", highlight = "Special" },
            bg = { attribute = "bg", highlight = "StatusLine" },
          },
          error = {
            fg = { attribute = "fg", highlight = "DiagnosticError" },
            bg = { attribute = "bg", highlight = "StatusLineNC" },
          },
          error_visible = {
            fg = { attribute = "fg", highlight = "DiagnosticError" },
            bg = { attribute = "bg", highlight = "StatusLineNC" },
          },
          error_selected = {
            fg = { attribute = "fg", highlight = "DiagnosticError" },
            bg = { attribute = "bg", highlight = "StatusLine" },
          },
          warning = {
            fg = { attribute = "fg", highlight = "DiagnosticWarn" },
            bg = { attribute = "bg", highlight = "StatusLineNC" },
          },
          warning_visible = {
            fg = { attribute = "fg", highlight = "DiagnosticWarn" },
            bg = { attribute = "bg", highlight = "StatusLineNC" },
          },
          warning_selected = {
            fg = { attribute = "fg", highlight = "DiagnosticWarn" },
            bg = { attribute = "bg", highlight = "StatusLine" },
          },
          info = {
            fg = { attribute = "fg", highlight = "DiagnosticInfo" },
            bg = { attribute = "bg", highlight = "StatusLineNC" },
          },
          info_visible = {
            fg = { attribute = "fg", highlight = "DiagnosticInfo" },
            bg = { attribute = "bg", highlight = "StatusLineNC" },
          },
          info_selected = {
            fg = { attribute = "fg", highlight = "DiagnosticInfo" },
            bg = { attribute = "bg", highlight = "StatusLine" },
          },
          hint = {
            fg = { attribute = "fg", highlight = "DiagnosticHint" },
            bg = { attribute = "bg", highlight = "StatusLineNC" },
          },
          hint_visible = {
            fg = { attribute = "fg", highlight = "DiagnosticHint" },
            bg = { attribute = "bg", highlight = "StatusLineNC" },
          },
          hint_selected = {
            fg = { attribute = "fg", highlight = "DiagnosticHint" },
            bg = { attribute = "bg", highlight = "StatusLine" },
          },
        }
      })

      -- 设置快捷键
      local opts = { noremap = true, silent = true }
      
      -- Buffer 导航快捷键
      vim.keymap.set('n', '<S-l>', '<Cmd>BufferLineCycleNext<CR>', opts)
      vim.keymap.set('n', '<S-h>', '<Cmd>BufferLineCyclePrev<CR>', opts)
      
      -- Buffer 关闭快捷键
      vim.keymap.set('n', '<leader>bc', '<Cmd>Bdelete<CR>', opts)
      vim.keymap.set('n', '<leader>bh', '<Cmd>BufferLineCloseLeft<CR>', opts)
      vim.keymap.set('n', '<leader>bl', '<Cmd>BufferLineCloseRight<CR>', opts)
      
      -- Buffer 排序快捷键
      vim.keymap.set('n', '<leader>bs', '<Cmd>BufferLineSortByDirectory<CR>', opts)
      vim.keymap.set('n', '<leader>bt', '<Cmd>BufferLineSortByTabs<CR>', opts)
      
      -- Buffer 选择快捷键
      vim.keymap.set('n', '<leader>bp', '<Cmd>BufferLinePick<CR>', opts)
      vim.keymap.set('n', '<leader>bn', '<Cmd>BufferLinePickClose<CR>', opts)
    end,
  },
} 