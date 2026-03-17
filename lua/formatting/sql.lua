local job = require("plenary.job")
local on_exit = require("formatting.utils.format_exit")

local added_ext = false
local name = ""

local function on_exit_override(_, return_val)
	if added_ext then
		os.rename(name, vim.g.formatting_buf_name)
		added_ext = false
		name = ""
	end
	on_exit(_, return_val)
end

return function()
	if
		not string.match(vim.g.formatting_buf_name, "%.sql")
		and not string.match(vim.g.formatting_buf_name, "%.plsql")
		and not string.match(vim.g.formatting_buf_name, "%.mysql")
	then
		name = vim.g.formatting_buf_name .. ".sql"
		os.execute("cp " .. vim.g.formatting_buf_name .. " " .. name)
		added_ext = true
	end

	if not added_ext then
		name = vim.g.formatting_buf_name
	end

	local args = { "fix", name, "--dialect", "postgres", "-q" }
	if vim.g.file_exists("./pyproject.toml") then
		table.insert(args, "--config")
		table.insert(args, "./pyproject.toml")
	end

	return {
		job:new({
			command = "sqlfluff",
			args = args,
			on_exit = on_exit_override,
		}),
	}
end
