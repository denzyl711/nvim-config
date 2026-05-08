return {
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
					component_separators = { left = "|", right = "|" },
          section_separators = { left = "|", right = "|" },
					globalstatus = true,
				},
				sections = {
					lualine_a = {
						{ "mode", separator = { left = "|" }, right_padding = 2 },
					},
					lualine_b = { "branch", { "filename", path = 1 }, "diagnostics" },
					lualine_c = { "fileformat" },
					lualine_x = {
						{
							require("noice").api.status.command.get,
							cond = require("noice").api.status.command.has,
							color = { fg = "#ff9e64", bg = "#1a1b26" },
						},
					},
					lualine_y = { "filetype", "progress" },
					lualine_z = {
						{ "location", separator = { right = "|" }, left_padding = 2 },
					},
				},
				tabline = {},
				extensions = {},
			})
		end,
	},
}
