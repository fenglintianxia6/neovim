local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 设置 leader 键
vim.g.mapleader = ","

-- 等待插件加载完成后注册快捷键
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = function()
    -- 通用快捷键
    keymap("n", "<leader>?", "<cmd>WhichKey<cr>", { desc = "Show Keymaps" })
    
    -- 缓冲区管理
    keymap("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Delete Buffer" })
    keymap("n", "<leader>bn", "<cmd>bn<cr>", { desc = "Next Buffer" })
    keymap("n", "<leader>bp", "<cmd>bp<cr>", { desc = "Previous Buffer" })
  end,
})

keymap("n","<leader>w", "<cmd>w<cr>", { desc = "Save File" })
keymap("n","<leader>q", ":BD<cr>", { desc = "Quit" })

-- 窗口管理（这些不依赖插件，可以立即设置）
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- 窗口调整
keymap("n", "<C-Up>", "<cmd>resize -2<cr>", opts)
keymap("n", "<C-Down>", "<cmd>resize +2<cr>", opts)
keymap("n", "<C-Left>", "<cmd>vertical resize -2<cr>", opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +2<cr>", opts)

--切换缓冲区
keymap("n", ">", "<cmd>bn<cr>", { desc = "Next Buffer" })
keymap("n", "<", "<cmd>bp<cr>", { desc = "Previous Buffer" })

-- Visual 模式
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts) 


vim.api.nvim_set_keymap('i', '<C-l>', 'copilot#Accept("")', {
    noremap = true,
    silent = true,
    expr = true,
    replace_keycodes = false
})

keymap("n", "<leader>cc", ":BD<cr>", { desc = "Toggle Copilot" })


