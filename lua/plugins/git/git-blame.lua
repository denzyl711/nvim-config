return {
	{
		"f-person/git-blame.nvim",
		cmd = { "GitBlameToggle", "GitBlameEnable", "GitBlameDisable" },
		keys = {
			{ "<leader>gb", "<cmd>GitBlameToggle<cr>", desc = "Toggle Git Blame" },
		},
		config = function()
			require("gitblame").setup({
				enabled = false, -- Start disabled, enable on demand
				virt_text = true,
				virt_text_pos = "eol",
				delay = 1000,
			})
		end,
	},
}
