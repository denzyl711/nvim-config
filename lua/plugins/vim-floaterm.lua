local FLOATERM_BG = "#0d1117"
local FLOATERM_BORDER_FG = "#1e3a5f"

local function set_floaterm_highlights()
	vim.api.nvim_set_hl(0, "Floaterm", { bg = FLOATERM_BG })
	vim.api.nvim_set_hl(0, "FloatermBorder", { bg = FLOATERM_BG, fg = FLOATERM_BORDER_FG })
end

return {
	{
		"voldikss/vim-floaterm",
		keys = {
			{
				"<F60>",
				function()
					local visible = vim.fn["floaterm#window#find"]() ~= 0
					if visible then
						vim.cmd("FloatermHide!")
					else
						vim.cmd("FloatermToggle")
					end
				end,
				desc = "Hyper+T — toggle shell",
				mode = { "n", "t", "i" },
			},
			{ "<leader>tt", desc = "New floaterm" },
			{ "<leader>td", desc = "Kill floaterm" },
			{ "<leader>tk", desc = "Next floaterm" },
			{ "<leader>tj", desc = "Previous floaterm" },
			{ "<leader>th", desc = "First floaterm" },
			{ "<leader>tl", desc = "Last floaterm" },
		},
		cmd = { "FloatermNew", "FloatermToggle", "FloatermKill", "FloatermSend" },
		init = function()
			vim.g.floaterm_height = 0.9
			vim.g.floaterm_width = 0.9
		end,
		config = function()
			set_floaterm_highlights()
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "*",
				callback = set_floaterm_highlights,
			})
		end,
	},
}
