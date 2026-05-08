return {
	"relf108/nvim-unstack",
	event = "VeryLazy",
	version = "*",
	opts = {
		debug = false, -- Disable debug logging for performance
		showsigns = true, -- Disable signs to reduce visual overhead
		layout = "quickfix_list", -- Use tab layout (default, but explicit for clarity)
		mapkey = "<leader>s", -- Keep default mapping
	},
}
