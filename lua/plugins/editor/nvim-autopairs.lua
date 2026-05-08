return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter", -- Only load when entering insert mode
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
}
