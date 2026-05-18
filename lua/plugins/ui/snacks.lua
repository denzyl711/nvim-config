return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			dashboard = {
				preset = {
					header = "TODO: add header",
					keys = {
						{ icon = " ", key = "f", desc = "Find File",    action = ":FzfLua files" },
						{ icon = " ", key = "g", desc = "Live Grep",    action = ":FzfLua live_grep" },
						{ icon = " ", key = "r", desc = "Recent Files", action = ":FzfLua oldfiles" },
						{ icon = " ", key = "l", desc = "Lazy",         action = ":Lazy" },
						{ icon = " ", key = "q", desc = "Quit",         action = ":qa" },
					},
				},
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
					{ section = "startup" },
				},
			},
		},
	},
}
