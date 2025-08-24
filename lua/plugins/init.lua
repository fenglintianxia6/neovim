local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 收集所有插件配置
local plugins = {}

-- 合并所有插件配置
local function merge_plugins(...)
  for _, plugin_group in ipairs({...}) do
    if type(plugin_group) == "table" then
      for _, plugin in ipairs(plugin_group) do
        table.insert(plugins, plugin)
      end
    end
  end
end

-- 加载所有插件配置
merge_plugins(
  require("plugins.colorscheme"),
  require("plugins.flutter-tools"),
  require("plugins.nvim-tree"),
  require("plugins.telescope"),
  require("plugins.nvim-cmp"),
  require("plugins.lua_snip"),
  require("plugins.nvim-lspconfig"),
  require("plugins.nvim-autopairs"),
  require("plugins.toggleterm"),
  require("plugins.which-key"),
  require("plugins.lualine"),
  require("plugins.lazygit"),
  require("plugins.hop"),
  require("plugins.auto-save"),
  require("plugins.bufferline"),
  -- require("plugins.copilot"),
  -- require("plugins.coc"),
  -- require("plugins.flutter-bloc"),
  require("plugins.codecompanion"),
  require("plugins.surround"),
  require("plugins.vim-bufkill"),
  require("plugins.markview")
  -- require("plugins.null-ls")
)

-- 设置插件
require("lazy").setup(plugins) 
