return {
	{
		"toppair/peek.nvim",
		build = "deno task --quiet build:fast",
		ft = { "markdown" },
		opts = {
			auto_load = false,
			close_on_bdelete = true,
			syntax = true,
			theme = "dark",
			update_on_change = true,
			app = "browser",
		},
		keys = {
			{
				"<leader>mp",
				function()
					local peek = require("peek")
					if peek.is_open() then
						peek.close()
					else
						peek.open()
					end
				end,
				ft = "markdown",
				desc = "Markdown Preview (Browser)",
			},
		},
	},
}
