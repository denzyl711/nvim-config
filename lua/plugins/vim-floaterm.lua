local NAMED_FLOATERMS = { copilot = true }
local FLOATERM_BG = "#0d1117"
local FLOATERM_BORDER_FG = "#1e3a5f"

--- Check if a named floaterm exists
local function floaterm_exists(name)
	return vim.fn["floaterm#terminal#get_bufnr"](name) ~= -1
end

--- Find the last unnamed (non-dedicated) floaterm bufnr
local function find_unnamed_bufnr()
	local result = nil
	for _, bufnr in ipairs(vim.fn["floaterm#buflist#gather"]()) do
		local ok, name = pcall(vim.api.nvim_buf_get_var, bufnr, "floaterm_name")
		if not ok or not NAMED_FLOATERMS[name] then
			result = bufnr
		end
	end
	return result
end

--- Ensure the copilot floaterm and a plain shell both exist (hidden)
local function ensure_copilot_and_shell()
	vim.cmd("FloatermNew --silent --name=copilot --autoclose=0 copilot")
	vim.cmd("FloatermHide copilot")
	if not find_unnamed_bufnr() then
		vim.cmd("FloatermNew --silent")
		vim.cmd("FloatermHide!")
	end
end

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
						local bufnr = find_unnamed_bufnr()
						if bufnr then
							vim.fn["floaterm#terminal#open_existing"](bufnr)
						else
							vim.cmd("FloatermNew")
						end
					end
				end,
				desc = "Hyper+T — toggle shell",
				mode = { "n", "t", "i" },
			},
			{
				"<F59>",
				function()
					vim.cmd("normal! y")
					local text = vim.fn.getreg('"')
					if not floaterm_exists("copilot") then
						ensure_copilot_and_shell()
					end
					vim.cmd("FloatermShow copilot")
					vim.fn["floaterm#terminal#send"](vim.fn["floaterm#terminal#get_bufnr"]("copilot"), { text })
				end,
				desc = "Hyper+G — send selection to Copilot",
				mode = { "v" },
			},
			{
				"<F59>",
				function()
					if not floaterm_exists("copilot") then
						ensure_copilot_and_shell()
						vim.cmd("FloatermToggle copilot")
					else
						vim.cmd("FloatermToggle copilot")
					end
				end,
				desc = "Hyper+G — toggle Copilot",
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
