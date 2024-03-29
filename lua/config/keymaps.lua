local sections = {
	f = {
		name = "󰍉 Find"
	},
	p = {
		name = "󰏖 Packages"
	},
	l = {
		name = " LSP"
	},
	u = {
		name = " UI"
	},
	b = {
		name = "󰓩 Buffers"
	},
	d = {
		name = " Debugger"
	},
	g = {
		name = " Git" },
	s = {
		name = "󱂬 Session"
	},
	t = {
		name = " Terminal"
	},
	w = { "<cmd>w<cr>", "Save" },
	q = { "<cmd>confirm q<cr>", "Quit" },
	n = { "<cmd>enew<cr>", "New File" },
}

vim.keymap.set({ 'n', 'v' }, 'j', "v:count ? 'j' : 'gj'", { expr = true, desc = "Move Cursor Down" })
vim.keymap.set({ 'n', 'v' }, 'k', "v:count ? 'k' : 'gk'", { expr = true, desc = "Move Cursor Up" })

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Line Down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Indent in visual
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

sections.p.i = { function() require("lazy").install() end, "Plugins Install" }
sections.p.s = { function() require("lazy").home() end, "Plugins Status" }
sections.p.S = { function() require("lazy").sync() end, "Plugins Sync" }
sections.p.u = { function() require("lazy").check() end, "Plugins Check Updates" }
sections.p.U = { function() require("lazy").update() end, "Plugins Update" }

sections.g.l = {
	function()
		require("gitsigns").blame_line()
	end,
	"View Git blame"
}
sections.g.p = {
	function()
		require("gitsigns").preview_hunk()
	end,
	"Preview Git hunk"
}
sections.g.h = {
	function()
		require("gitsigns").reset_hunk()
	end,
	"Reset Git hunk"
}
sections.g.r = {
	function()
		require("gitsigns").reset_buffer()
	end,
	"Reset Git buffer"
}
sections.g.s = {
	function()
		require("gitsigns").stage_hunk()
	end,
	"Stage Git hunk"
}
sections.g.S = {
	function()
		require("gitsigns").stage_buffer()
	end,
	"Stage Git buffer"
}
sections.g.u = {
	function()
		require("gitsigns").undo_stage_hunk()
	end,
	"Unstage Git hunk"
}
sections.g.d = {
	function()
		require("gitsigns").diffthis()
	end,
	"View Git diff"
}

sections.f["<CR>"] = {
	function()
		require("telescope.builtin").resume()
	end,
	"Resume previous search"
}
sections.f["'"] = {
	function()
		require("telescope.builtin").marks()
	end,
	"Find marks"
}
sections.f.c = {
	function()
		require("telescope.builtin").grep_string()
	end,
	"Find for word under cursor"
}
sections.f.C = {
	function()
		require("telescope.builtin").commands()
	end,
	"Find commands"
}
sections.f.f = {
	function()
		require("telescope.builtin").find_files()
	end,
	"Find files"
}
sections.f.F = {
	function()
		require("telescope.builtin").find_files {
			hidden = true,
			no_ignore = true
		}
	end,
	"Find all files"
}
sections.f.H = {
	function()
		require("telescope.builtin").help_tags()
	end,
	"Find help"
}
sections.f.k = {
	function()
		require("telescope.builtin").keymaps()
	end,
	"Find keymaps"
}
sections.f.m = {
	function()
		require("telescope.builtin").man_pages()
	end,
	"Find man"
}

-- Neotree
sections.e = { "<cmd>Neotree toggle<cr>", "Toggle Explorer" }
sections.o = {
	function()
		if vim.bo.filetype == "neo-tree" then
			vim.cmd.wincmd "p"
		else
			vim.cmd.Neotree "focus"
		end
	end,
	"Toggle Explorer Focus",
}

vim.keymap.set({ 'n', 't' }, "<C-h>", function() require("smart-splits").move_cursor_left() end,
{ desc = "Move to left split" })
vim.keymap.set({ 'n', 't' }, "<C-j>", function() require("smart-splits").move_cursor_down() end,
{ desc = "Move to below split" })
vim.keymap.set({ 'n', 't' }, "<C-k>", function() require("smart-splits").move_cursor_up() end,
{ desc = "Move to above split" })
vim.keymap.set({ 'n', 't' }, "<C-l>", function() require("smart-splits").move_cursor_right() end,
{ desc = "Move to right split" })
vim.keymap.set({ 'n', 't' }, "<C-Up>", function() require("smart-splits").resize_up() end, { desc = "Resize split up" })
vim.keymap.set({ 'n', 't' }, "<C-Down>", function() require("smart-splits").resize_down() end,
{ desc = "Resize split down" })
vim.keymap.set({ 'n', 't' }, "<C-Left>", function() require("smart-splits").resize_left() end,
{ desc = "Resize split left" })
vim.keymap.set({ 'n', 't' }, "<C-Right>", function() require("smart-splits").resize_right() end,
{ desc = "Resize split right" })

sections.c = { function() require("bufdelete").bufdelete() end, "Close buffer" }
sections.C = { function() require("bufdelete").bufdelete(0, true) end, "Force close buffer" }
sections.b['>'] = {
	"<cmd>BufferLineMoveNext<cr>",
	"Move buffer tab right",
}
sections.b['<'] = {
	"<cmd>BufferLineMovePrev<cr>",
	"Move buffer tab left",
}
sections.b.d =
{ "<cmd>BufferLinePickClose<cr>", "Pick Buffer To Close" }
sections.b.C = { name = "Directional Close" }
sections.b.C['>'] = { "<cmd>BufferLineCloseRight<cr>", "Close Right Buffers" }
sections.b.C['<'] = { "<cmd>BufferLineCloseLeft<cr>", "Close Left buffers" }
sections.b.c = { "<cmd>BufferLineCloseRight<cr><cmd>BufferLineCloseRight<cr>", "Close All" }
sections.b.b = {
	"<cmd>BufferLinePick<cr>",
	"Select buffer from tabline",
}
sections.s.h = {
	function() vim.cmd.split() end,
	"Horizontal Split",
}
sections.s.v = {
	function() vim.cmd.vsplit() end,
	"Vertical Split",
}

sections.g.g = { function() require('neogit').open() end, "Neogit" }
sections.t.f = { "<cmd>ToggleTerm direction=float<cr>", "ToggleTerm float" }
sections.t.h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "ToggleTerm horizontal split" }
sections.t.v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "ToggleTerm vertical split" }
vim.keymap.set({ 'n', 't' }, "<C-\\>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })

sections.l.a = { vim.lsp.buf.code_action, "Code Action" }
sections.l.f = { vim.lsp.buf.format, "Format" }
sections.l.i = { "<cmd>LspInfo<cr>", "Info" }
sections.l.I = { "<cmd>Mason<cr>", "Mason Info" }
sections.l.j = { vim.diagnostic.goto_next, "Next Diagnostic", }
sections.l.k = { vim.diagnostic.goto_prev, "Prev Diagnostic", }
sections.l.r = { vim.lsp.buf.rename, "Rename" }
sections.l.s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" }
sections.l.c = { vim.lsp.codelens.run, "CodeLens Action" }

vim.keymap.set('n', "K", vim.lsp.buf.hover, { desc = "Show hover" })
vim.keymap.set('n', "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set('n', "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "Go to references" })
vim.keymap.set('n', "gI", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set('n', "gs", vim.lsp.buf.signature_help, { desc = "Show signature help" })

require("which-key").register(sections, { prefix = "<leader>", mode = "n" });
