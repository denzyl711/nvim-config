return {
	{
		"voldikss/vim-floaterm",
		keys = {
			{ "<F60>", desc = "Toggle floaterm" },
			{ "TT", desc = "New floaterm" },
			{ "TD", desc = "Kill floaterm" },
			{ "TK", desc = "Next floaterm" },
			{ "TJ", desc = "Previous floaterm" },
			{ "TH", desc = "First floaterm" },
			{ "TL", desc = "Last floaterm" },
		},
		cmd = { "FloatermNew", "FloatermToggle", "FloatermKill", "FloatermSend" },
		init = function()
			-- These need to be set before the plugin loads
			vim.g.floaterm_height = 0.9
			vim.g.floaterm_width = 0.9
		end,
	},
}
