return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "echasnovski/mini.icons",
    },
    config = function()
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
        actions = {
            change_dir = {
                enable = false,
                global = false,
                restrict_above_cwd = false,
            }
        },
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_cwd = true, -- 新增
        update_focused_file = {
          enable = true,
          update_root = true,
        },
      })

      -- 自动切换到 git 根目录
      vim.api.nvim_create_autocmd("BufWinEnter", {
        callback = function()
          local api = require("nvim-tree.api")
          if vim.bo.filetype == "NvimTree" then
            return
          end
          local path = vim.fn.expand("%:p")
          if path == "" then return end
          local git_root = vim.fn.systemlist("git -C " .. vim.fn.fnameescape(path) .. " rev-parse --show-toplevel")[1]
          if git_root and git_root ~= "" and vim.fn.isdirectory(git_root) == 1 then
            local current_root = vim.fn.getcwd()
            if not current_root or current_root ~= git_root then
              vim.cmd("lcd " .. git_root)
              api.tree.change_root(git_root)
            end
          end
        end
      })
    end
  }
}
