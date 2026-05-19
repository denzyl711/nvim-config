return {
	{
		"xiyaowong/nvim-transparent",
		keys = {
			{ "<leader>``", "<cmd>TransparentToggle<cr>", desc = "Toggle transparency" },
		},
		opts = {
			extra_groups = {
				"NormalFloat",
				"NvimTreeNormal",
				"FloatBorder",
			},
		},
	},
}
