-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
return { "Mofiqul/vscode.nvim", {
	"NTBBloodbath/doom-one.nvim",
	'shaunsingh/nord.nvim',
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		opts = {
			flavour = "frappe",
			integrations = {
				gitsigns = true,
				mason = true,
				mini = true,
				neotree = true,
				neogit = true,
				noice = true,
				cmp = true,
				dap = {
					enable = true,
					enable_ui = true,
				},
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
				},
				navic = {
					enabled = true
				},
				notify = true,
				treesitter_context = true,
				treesitter = true,
				telescope = true,
				lsp_trouble = true,
				illuminate = true,
				which_key = true,
			}
		}
	},
	config = function()
		-- Add color to cursor
		vim.g.doom_one_cursor_coloring = false
		-- Set :terminal colors
		vim.g.doom_one_terminal_colors = true
		-- Enable italic comments
		vim.g.doom_one_italic_comments = false
		-- Enable TS support
		vim.g.doom_one_enable_treesitter = true
		-- Color whole diagnostic text or only underline
		vim.g.doom_one_diagnostics_text_color = false
		-- Enable transparent background
		vim.g.doom_one_transparent_background = false

		-- Pumblend transparency
		vim.g.doom_one_pumblend_enable = false
		vim.g.doom_one_pumblend_transparency = 20

		-- Plugins integration
		vim.g.doom_one_plugin_neorg = true
		vim.g.doom_one_plugin_barbar = false
		vim.g.doom_one_plugin_telescope = false
		vim.g.doom_one_plugin_neogit = true
		vim.g.doom_one_plugin_nvim_tree = true
		vim.g.doom_one_plugin_dashboard = true
		vim.g.doom_one_plugin_startify = true
		vim.g.doom_one_plugin_whichkey = true
		vim.g.doom_one_plugin_indent_blankline = true
		vim.g.doom_one_plugin_vim_illuminate = true
		vim.g.doom_one_plugin_lspsaga = false
	end
}, {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		-- char = "▏",
		char = "│",
		filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
		show_trailing_blankline_indent = false,
		show_current_context = true,
		show_current_context_start = true
	}
}, {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		icons = {
			group = vim.g.icons_enabled and "" or "+",
		},
		disable = {
			filetypes = { "TelescopePrompt" }
		}
	},
	config = function(_, opts)
		require("which-key").setup(opts)
	end
}, {
	'mrjones2014/smart-splits.nvim',
	lazy = false,
	config = function()
		require('smart-splits').setup({
			ignored_filetypes = {
				'nofile',
				'quickfix',
				'prompt',
			},
			ignored_buftypes = { 'neo-tree' },
			default_amount = 3,
			wrap_at_edge = true,
			move_cursor_same_row = false,
			cursor_follows_swapped_bufs = false,
			resize_mode = {
				quit_key = '<ESC>',
				resize_keys = { 'h', 'j', 'k', 'l' },
				silent = false,
				hooks = {
					on_enter = nil,
					on_leave = nil,
				},
			},
			ignored_events = {
				'BufEnter',
				'WinEnter',
			},
		})
	end
},
	{ 'famiu/bufdelete.nvim', cmd = { 'Bdelete', 'Bwipeout' }, },
	{
		'echasnovski/mini.bracketed',
		lazy = false,
		config = function()
			require('mini.bracketed').setup {
				buffer = { suffix = '' },
				quickfix = { suffix = '' },
			}
			vim.keymap.set('n', '[b', '<cmd>BufferLineCyclePrev<CR>')
			vim.keymap.set('n', '[B', '<cmd>BufferLineMovePrev<CR>')
			vim.keymap.set('n', ']b', '<cmd>BufferLineCycleNext<CR>')
			vim.keymap.set('n', ']B', '<cmd>BufferLineMoveNext<CR>')
		end
	},
	{
		'NvChad/nvim-colorizer.lua',
		lazy = false,
		config = function() require 'colorizer'.setup() end,
	}
}
