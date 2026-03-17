return {
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			preview = {
				preview_split = "belowright",
				vertical = true,
			},
			preview_win = {
				update_on_cursor_moved = true,
			},
			keymaps = {
				["<C-t>"] = false,
				["<C-v>"] = {
					"actions.select",
					opts = { vertical = true },
					desc = "Open the entry in a vertical split",
				},
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VimEnter",
		config = function(_, opts)
			require("oil").setup(opts)

			local preview_opened = {}
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "oil",
				callback = function(args)
					if vim.bo.filetype == "oil" and not preview_opened[args.buf] then
						preview_opened[args.buf] = true
						vim.defer_fn(function()
							if vim.bo.filetype == "oil" and vim.api.nvim_get_current_buf() == args.buf then
								require("oil.actions").preview.callback({ vertical = true, split = "belowright" })
							end
						end, 100)
					end
				end,
			})
		end,
	},
}
