return {
  -- 自动补全括号、引号等
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require('nvim-autopairs.rule')
      
      npairs.setup({
        check_ts = false, -- 禁用 Tree-sitter 检查以避免 Dart 解析器问题
        ts_config = {
          lua = {'string'},-- it will not add a pair on that treesitter node
          javascript = {'template_string'},
          java = false,-- don't check treesitter on java
        },
        disable_filetype = { "TelescopePrompt" },
        enable_check_bracket_line = false,
        ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
        enable_moveright = true,
        enable_afterquote = true,  -- add bracket pairs after quote
        enable_check_bracket_line = false,  --- check bracket in same line
        enable_bracket_in_quote = true, --
        enable_abbr = false, -- trigger abbreviation
        break_undo = true, -- switch for basic rule break undo sequence
        check_whitespace = true,
        pairs = {
          { '(', ')' },
          { '[', ']' },
          { '{', '}' },
          { '"', '"' },
          { "'", "'" },
          { '<', '>' }, -- 添加泛型支持
        },
      })
    end,
  },
} 