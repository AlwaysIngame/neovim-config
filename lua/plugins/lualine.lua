local function configure()
	local lualine = require("lualine")

	local lsp_component = {
		function()
			if not vim.lsp.buf.server_ready() then return "LSP Inactive" end
			-- Thank you LunarVim part of this function
			local buf_clients = vim.lsp.get_active_clients()
			local buf_ft = vim.bo.filetype
			local names = {}

			-- add client
			for _, client in pairs(buf_clients) do
				if client.name ~= "null-ls" then
					table.insert(names, client.name)
				end
			end
			local sources = require("null-ls").get_sources()
			for _, source in ipairs(sources) do
				if source.filetypes[buf_ft] and not source.generator._failed then
					table.insert(names, source.name)
				end
			end

			if next(names) == nil then
				return "LSP Inactive"
			end
			names = vim.fn.uniq(names)

			local language_servers = table.concat(names, ", ")

			return language_servers
		end,
		color = {gui = 'italic'}
	}

	local function diff_source()
		local gitsigns = vim.b.gitsigns_status_dict
		if gitsigns then
			return {
				added = gitsigns.added,
				modified = gitsigns.changed,
				removed = gitsigns.removed,
			}
		end
	end

	-- Config
	local config = {
		options = {
			globalstatus = true,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			},
		},
		sections = {
			lualine_a = { {
				"mode",
				fmt = function(a)
					return " " .. a
				end,
			} },
			lualine_b = {
				"branch",
				{ "diff", source = diff_source, symbols = { added = " ", modified = " ", removed = " " } },
			},
			lualine_c = { "%=", {"filetype", color = {gui = 'bold'}}, lsp_component },
			lualine_x = { "searchcount", "diagnostics" },
			lualine_y = { { "fileformat", padding = 0 }, { "hostname", padding = { right = 0, left = 1 } }, "encoding" },
			lualine_z = { { "location", padding = 0 }, "progress" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {"mode", "branch", { "diff", source = diff_source } },
			lualine_c = { "%=", "filetype", "filename" },
			lualine_x = {},
			lualine_y = { { "fileformat", padding = 0 }, { "hostname", padding = { right = 0, left = 1 } }, "encoding" },
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {},
	}

	lualine.setup(config)
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = configure,
	lazy = false,
}
