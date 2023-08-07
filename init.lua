local set = vim.o
set.number = true
set.relativenumber = true
set.clipboard = "unnamed"


vim.api.nvim_create_autocmd({ "TextYankPost" },{

	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({
			timeout = 300,
		})
	end,
})



-- key binding 
local opt = { noremap = true, silent = true}

vim.g.mapleader = " "


vim.keymap.set("n","<C-l>","<C-w>l",opt)
vim.keymap.set("n","<C-h>","<C-w>h",opt)
vim.keymap.set("n","<C-j>","<C-w>j",opt)
vim.keymap.set("n","<C-k>","<C-w>k",opt)
vim.keymap.set("n","<leader>v","<C-w>v",opt)
vim.keymap.set("n","<leader>s","<C-w>s",opt)
vim.keymap.set("n","k",[[v:count ? 'k':'gk']],{ noremap = true,expr = true })
vim.keymap.set("n","j",[[v:count ? 'j':'gj']],{ noremap = true,expr = true })








