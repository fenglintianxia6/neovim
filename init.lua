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

vim.keymap.set("n","<C-l>","<C-w>l",opt)
vim.keymap.set("n","<C-h>","<C-w>h",opt)
vim.keymap.set("n","<C-j>","<C-w>j",opt)
vim.keymap.set("n","<C-k>","<C-w>k",opt)








