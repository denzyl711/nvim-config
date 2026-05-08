--- Load .env file from nvim config directory
local function load_dotenv()
	local env = {}
	local path = vim.fn.stdpath("config") .. "/.env"
	local file = io.open(path, "r")
	if not file then
		return env
	end
	for line in file:lines() do
		local key, value = line:match("^([%w_]+)%s*=%s*(.+)$")
		if key and value then
			env[key] = value
		end
	end
	file:close()
	return env
end

local dotenv = load_dotenv()
local AI_CLI = dotenv.AI_CLI or "copilot"
local AI_TERM_NAME = "ai"
local NAMED_FLOATERMS = { [AI_TERM_NAME] = true }
local FLOATERM_BG_DARKEN = 15 -- amount to darken theme bg for floaterm (0-255)

--- Check if a named floaterm exists
local function floaterm_exists(name)
	return vim.fn["floaterm#terminal#get_bufnr"](name) ~= -1
end

local function collect_unnamed_bufnrs()
	local last_bufnr = nil
	local bufnr_set = {}
	for _, bufnr in ipairs(vim.fn["floaterm#buflist#gather"]()) do
		local ok, name = pcall(vim.api.nvim_buf_get_var, bufnr, "floaterm_name")
		if not ok or not NAMED_FLOATERMS[name] then
			last_bufnr = bufnr
			bufnr_set[bufnr] = true
		end
	end
	return last_bufnr, bufnr_set
end

--- Find the last unnamed (non-dedicated) floaterm bufnr
local function find_unnamed_bufnr()
	local bufnr = collect_unnamed_bufnrs()
	return bufnr
end

--- Return a set of all unnamed floaterm bufnrs
local function unnamed_bufnr_set()
	local _, bufnr_set = collect_unnamed_bufnrs()
	return bufnr_set
end

--- Ensure the AI CLI floaterm and a plain shell both exist (hidden)
local function ensure_ai_and_shell()
	vim.cmd("FloatermNew --silent --name=" .. AI_TERM_NAME .. " --autoclose=0 " .. AI_CLI .. " --continue")
	vim.cmd("FloatermHide " .. AI_TERM_NAME)
	if not find_unnamed_bufnr() then
		vim.cmd("FloatermNew --silent")
		vim.cmd("FloatermHide!")
	end
end

local function set_floaterm_highlights()
	local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
	local border = vim.api.nvim_get_hl(0, { name = "FloatBorder", link = false })

	local function darken(color)
		local r = math.max(0, math.floor(color / 0x10000) - FLOATERM_BG_DARKEN)
		local g = math.max(0, math.floor((color % 0x10000) / 0x100) - FLOATERM_BG_DARKEN)
		local b = math.max(0, color % 0x100 - FLOATERM_BG_DARKEN)
		return string.format("#%02x%02x%02x", r, g, b)
	end

	local bg = normal.bg and darken(normal.bg) or "#0d1117"
	local border_fg = border.fg and string.format("#%06x", border.fg) or "#1e3a5f"
	vim.api.nvim_set_hl(0, "Floaterm", { bg = bg })
	vim.api.nvim_set_hl(0, "FloatermBorder", { bg = bg, fg = border_fg })
end

return {
	{
		"voldikss/vim-floaterm",
		keys = {
			{
				"<F60>",
				function()
					local unnamed = unnamed_bufnr_set()
					local cur_buf = vim.api.nvim_get_current_buf()
					local is_floaterm = vim.bo[cur_buf].filetype == "floaterm"

					if is_floaterm and unnamed[cur_buf] then
						vim.cmd("FloatermHide!")
						return
					end

					local bufnr = find_unnamed_bufnr()
					if bufnr then
						vim.fn["floaterm#terminal#open_existing"](bufnr)
					else
						vim.cmd("FloatermNew")
					end
				end,
				desc = "Hyper+T — toggle shell",
				mode = { "n", "t", "i", "v" },
			},
			{
				"<F59>",
				function()
					if not floaterm_exists(AI_TERM_NAME) then
						ensure_ai_and_shell()
					end
					vim.cmd("FloatermToggle " .. AI_TERM_NAME)
				end,
				desc = "Hyper+G — toggle AI CLI",
				mode = { "n", "t", "i", "v" },
			},
			{ "<C-t>n", "<cmd>FloatermNew<cr>",   desc = "New floaterm",      mode = { "n", "t" } },
			{ "<C-t>d", "<cmd>FloatermKill<cr>",  desc = "Kill floaterm",     mode = { "n", "t" } },
			{ "<C-t>k", "<cmd>FloatermNext<cr>",  desc = "Next floaterm",     mode = { "n", "t" } },
			{ "<C-t>j", "<cmd>FloatermPrev<cr>",  desc = "Prev floaterm",     mode = { "n", "t" } },
			{ "<C-t>h", "<cmd>FloatermFirst<cr>", desc = "First floaterm",    mode = { "n", "t" } },
			{ "<C-t>l", "<cmd>FloatermLast<cr>",  desc = "Last floaterm",     mode = { "n", "t" } },
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
