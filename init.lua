-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")

vim.cmd [[colorscheme doom-one]]
