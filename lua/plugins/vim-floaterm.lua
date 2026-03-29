return {
	{
		"voldikss/vim-floaterm",
		keys = {
			{ "<F60>", desc = "Toggle floaterm" },
			{ "<leader>tt", desc = "New floaterm" },
			{ "<leader>td", desc = "Kill floaterm" },
			{ "<leader>tk", desc = "Next floaterm" },
			{ "<leader>tj", desc = "Previous floaterm" },
			{ "<leader>th", desc = "First floaterm" },
			{ "<leader>tl", desc = "Last floaterm" },
		},
		cmd = { "FloatermNew", "FloatermToggle", "FloatermKill", "FloatermSend" },
		init = function()
			-- These need to be set before the plugin loads
			vim.g.floaterm_height = 0.9
			vim.g.floaterm_width = 0.9
		end,
	},
}
