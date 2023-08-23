local set = vim.o
set.number = true
set.relativenumber = true
set.scrolloff = 10
set.clipboard = "unnamed"

--禁用默认的文件浏览器
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- key binding
local opts = { noremap = true, silent = true }

vim.g.mapleader = ";"


vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<leader>v", "<C-w>v", opts)
vim.keymap.set("n", "<leader>s", "<C-w>s", opts)

vim.keymap.set("n", "<leader>[", "<C-o>", opts)
vim.keymap.set("n", "<leader>]", "<C-i>", opts)
vim.keymap.set("n", "k", [[v:count ? 'k':'gk']], { noremap = true, expr = true })
vim.keymap.set("n", "j", [[v:count ? 'j':'gj']], { noremap = true, expr = true })


-- 文件浏览器快捷键
vim.keymap.set("n", "<leader>t", ":Neotree toggle<CR>", opts)


--保存上次编辑的事件
-- restore the session for the current directory
vim.api.nvim_set_keymap("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {})
-- restore the last session
vim.api.nvim_set_keymap("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<cr>]], {})


--剪贴板历史--yankring
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")
vim.keymap.set("n", "<M-S-V>", ":YankyRingHistory<CR>", opts)



-- 添加lazy插件管理器
-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

--设置插件
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	{
		--自动完成括号的
		"windwp/nvim-autopairs",
		event = "VeryLazy",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		--剪贴板
		"gbprod/yanky.nvim",
		event = "VeryLazy",
		config = function()
			require("yanky").setup({})
		end
	},
	{
		--保存上次回话的seesion
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = {
			dir = "../seesions/"
		}
	},
	{
		--主题
		"RRethy/nvim-base16",
		lazy = true,
	},
	{
		-- 查找文件相关的
		cmd = 'Telescope',
		keys = {
			{ "<leader>p", ":Telescope find_files<CR>", desc = "查找文件" },
			{ "<leader>P", ":Telescope live_grep<CR>", desc = "grep file" },
			{ "<leader>rs", ":Telescope resume<CR>", desc = "恢复文件" },
			{ "<leader>e", ":Telescope oldfiles<CR>", desc = "最近文件" },
		},
		'nvim-telescope/telescope.nvim',
		tag = '0.1.2',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		--快捷键相关的
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
		}
	},
	{
		---添加语言支持
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup()
		end
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("null-ls").setup()
		end
	},
	{
		"hrsh7th/nvim-cmp",
		event = "VeryLazy",
		dependencies = {
			'neovim/nvim-lspconfig',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/nvim-cmp',
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip'
		}
	},
	{
		'akinsho/flutter-tools.nvim',
		lazy = false,
		dependencies = {
			'nvim-lua/plenary.nvim',
			'stevearc/dressing.nvim', -- optional for vim.ui.select
		},
		config = true,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		}
	},
})

--设置theme

vim.cmd.colorscheme("base16-tender")


--设置文件浏览器 nvim-tree



--- null-ls 格式化

-- LSP code completion
-- Installation
-- mason: https://github.com/williamboman/mason.nvim
-- lspconfig https://github.com/neovim/nvim-lspconfig


local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason").setup()
require("mason-lspconfig").setup()
require("lspconfig").lua_ls.setup {
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
		},

	}
}

require("flutter-tools").setup {
	flutter_path = 'C:\\Users\\Administrator\\flutter\\bin'
}

require 'lspconfig'.dartls.setup {
	capabilities = capabilities,
	filetypes = { 'dart' }
}
require 'lspconfig'.volar.setup {
	capabilities = capabilities,
	filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' }
}

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opt = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opt)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opt)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opt)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opt)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opt)
		vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opt)
		vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opt)
		vim.keymap.set('n', '<leader>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opt)
		vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opt)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opt)
		vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opt)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opt)
		vim.keymap.set('n', '<leader>f', function()
			vim.lsp.buf.format { async = true }
		end, opt)
	end,
})

--
local cmp = require 'cmp'
local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local luasnip = require 'luasnip'

luasnip.filetype_extend("vue", { "vue" })


cmp.setup({
	snippet = {
		expand = function(args)
			--			require('luasnip').lsp_expand(args.body)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping({
			i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
			c = function(fallback)
				if cmp.visible() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
				else
					fallback()
				end
			end
		}),
		["<Tab>"] = cmp.mapping({
			c = function()
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
				else
					cmp.complete()
				end
			end,
			i = function(fallback)
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
				elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
					vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
				else
					fallback()
				end
			end,
			s = function(fallback)
				if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
					vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
				else
					fallback()
				end
			end
		}),
		['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
		['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' }, -- For vsnip users.
		{ name = 'luasnip' }, -- For luasnip users.
		{ name = 'ultisnips' }, -- For ultisnips users.
		{ name = 'snippy' }, -- For snippy users.
	}, {
		{ name = 'buffer' },
	})
})


--命令模式下禁用自动补全
cmp.setup.cmdline(':', {
	completion = { autocomplete = false },
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})
--查找模式下禁用自动补全
cmp.setup.cmdline('/', {
	completion = { autocomplete = false },
	sources = {
		-- { name = 'buffer' }
		{ name = 'buffer', opts = { keyword_pattern = [=[[^[:blank:]].*]=] } }
	}
})
