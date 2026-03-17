return {
	{
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify").setup({
				-- Animation style (see below for details)
				stages = "static",
				fps = 60,

				-- Default timeout for notifications
				timeout = 5000,

				-- For stages that change opacity this is treated as the highlight behind the window
				background_colour = "#000000",

				-- Icons for the different levels
				icons = {
					ERROR = "",
					WARN = "",
					INFO = "",
					DEBUG = "",
					TRACE = "✎",
				},
			})
		end,
	},
}
