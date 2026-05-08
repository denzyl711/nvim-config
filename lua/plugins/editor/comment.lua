return {
	{
		"numToStr/Comment.nvim",
		keys = {
			{ "<M-/>", mode = { "n", "v" }, desc = "Comment toggle" },
		},
		config = function()
			require("Comment").setup({
				mappings = { basic = false, extra = false },
			})
			local api = require("Comment.api")
			vim.keymap.set("n", "<M-/>", api.toggle.linewise.current, { desc = "Comment toggle line" })
			vim.keymap.set("v", "<M-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", { desc = "Comment toggle selection" })
		end,
	},
}
