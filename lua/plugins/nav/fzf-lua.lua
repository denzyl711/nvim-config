return {
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VimEnter",
		keys = {
			{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
			{ "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
			{ "<leader>fw", "<cmd>FzfLua grep_cword<cr>", desc = "Grep word under cursor" },
			{ "<leader>fr", "<cmd>FzfLua lsp_references<cr>", desc = "LSP references" },
			{ "<leader>fd", "<cmd>FzfLua lsp_definitions<cr>", desc = "LSP definitions" },
			{ "<leader>gC", "<cmd>FzfLua git_commits<cr>", desc = "Git commits" },
			{ "<leader>gb", "<cmd>FzfLua git_branches<cr>", desc = "Git branches" },
			{ "<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "Git status" },
		},
		opts = {},
		config = function()
			require("fzf-lua").setup({})
			if vim.bo.filetype == "" then
				require("fzf-lua").files({ winopts = { fullscreen = true } })
			end
		end,
	},
}
