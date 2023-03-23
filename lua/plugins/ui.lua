return { {
	"folke/noice.nvim",
	lazy = false,
	dependencies = { "MunifTanjim/nui.nvim" },
	config = function()
		require("noice").setup({
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true
				},
				signature = {
					enabled = false,
				}
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = false,        -- use a classic bottom cmdline for search
				command_palette = true,       -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false,           -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false        -- add a border to hover docs and signature help
			}
		})
	end
}, {
	"rcarriga/nvim-notify",
	config = function()
		require('notify').setup { top_down = false }
	end
}, {
	"akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
		close_command = function(bufnum)
			require('bufdelete').bufdelete(bufnum, true)
		end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
},
 {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },}
