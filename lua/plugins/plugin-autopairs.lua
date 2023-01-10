local function configure()
	local npairs = require "nvim-autopairs"
	local rule = require "nvim-autopairs.rule"

	npairs.setup({
		check_ts = true,
		ignored_next_char = "[%w%.]",
		fast_wrap = {}
	})
end
return {
	"windwp/nvim-autopairs",
	config = configure,
}
