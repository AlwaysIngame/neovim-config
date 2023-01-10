-- Move between windows
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
-- Save File
vim.keymap.set({'n','i'}, "<C-s>", "<cmd>w<CR>")
-- Better Indent
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
-- Move line up/down vs-code style
vim.keymap.set('v', "<A-j>", ":m '>+1<CR>gv-gv")
vim.keymap.set('v', "<A-k>", ":m '<-2<CR>gv-gv")

-- Commenting keybinds (Note there are more keybinds defined by the plugin)
-- https://github.com/numToStr/Comment.nvim
vim.keymap.set('n', '<leader>/',function() require('Comment.api').toggle.linewise.current() end, {desc = "Toggle Comment", silent = true})
vim.keymap.set('v', '<leader>/', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", {desc = "Toggle Comment", silent = true})

-- change leader key in init.lua
-- loads which key plugin
local wk = require("which-key")

wk.register({
	l = {
		name = "+LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
		w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
		f = {
			function()
				vim.lsp.buf.format({ async = true })
			end,
			"Format",
		},
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>Mason<cr>", "Mason Info" },
		j = {
			vim.diagnostic.goto_next,
			"Next Diagnostic",
		},
		k = {
			vim.diagnostic.goto_prev,
			"Prev Diagnostic",
		},
		l = { vim.lsp.codelens.run, "CodeLens Action" },
		q = { vim.diagnostic.setloclist, "Quickfix" },
		r = { vim.lsp.buf.rename, "Rename" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
		e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
	},
}, { prefix = "<leader>" })
