return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		cmd = { "Catppuccin", "CatppuccinCompile"},
		config = function ()
			require("catppuccin").setup({
				integrations = {treesitter = true, cmp = true, },
				flavour = "macchiato",
			})
		end,
	},
	{
		"folke/tokyonight.nvim"
	},
	{
		"navarasu/onedark.nvim",
		config = function() require('onedark').load() end,
	},
	{
		"marko-cerovac/material.nvim",
		config = function()

			vim.g.material_style = "oceanic"
			-- deep ocean, palenight, oceanic, darker, lighter
			require('material').setup({
				styles = { -- Give comments style such as bold, italic, underline etc.
					comments = { --[[ italic = true ]] },
					strings = { --[[ bold = true ]] },
					keywords = { --[[ underline = true ]] },
					functions = { --[[ bold = true, undercurl = true ]] },
					variables = {},
					operators = {},
					types = {},
				},

				plugins = { -- Uncomment the plugins that you use to highlight them
					-- Available plugins:
					-- "dap",
					-- "dashboard",
					-- "gitsigns",
					-- "hop",
					-- "indent-blankline",
					-- "lspsaga",
					-- "mini",
					-- "neogit",
					"nvim-cmp",
					-- "nvim-navic",
					-- "nvim-tree",
					"nvim-web-devicons",
					-- "sneak",
					-- "telescope",
					-- "trouble",
					-- "which-key",
				},

				lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )
			})
		end,
	},
	{'Mofiqul/vscode.nvim',},
}
