local sql = require("formatting.sql")
local lua = require("formatting.lua")
local markdown = require("formatting.markdown")
local python = require("formatting.python")
local bash = require("formatting.bash")
local yaml = require("formatting.yaml")
local nix = require("formatting.nix")
local xml = require("formatting.xml")
local toml = require("formatting.toml")

vim.g.formatting_buf_name = ""

local format_overrides = {
	sql = sql,
	plsql = sql,
	mysql = sql,
	lua = lua,
	md = markdown,
	markdown = markdown,
	bash = bash,
	sh = bash,
	yaml = yaml,
	yml = yaml,
	nix = nix,
	xml = xml,
	toml = toml,
}

return function()
	local success, buf_name = pcall(vim.api.nvim_buf_get_name, 0)
	if not success then
		vim.notify("Failed to get buffer name for formatting", vim.log.levels.ERROR)
		return
	end

	vim.g.formatting_buf_name = buf_name
	local filetype = vim.bo.filetype

	-- Set specific formatter for a directory
	if vim.g.work_dir and string.find(vim.g.formatting_buf_name, vim.g.work_dir) then
		format_overrides["python"] = python
		format_overrides["py"] = python
	end

	if format_overrides[filetype] then
		local save_success = pcall(vim.cmd, "silent! w!")
		if not save_success then
			vim.notify("Failed to save buffer before formatting", vim.log.levels.WARN)
		end

		local format_success, jobs = pcall(format_overrides[filetype])
		if format_success and jobs then
			for _, job in ipairs(jobs) do
				local buf = vim.g.get_buf_by_name(vim.g.formatting_buf_name)
				if buf and buf ~= 0 then
					pcall(vim.api.nvim_set_option_value, "readonly", true, { buf = buf })
					pcall(job.start, job)
				end
			end
		else
			vim.notify("Failed to run formatter for " .. filetype, vim.log.levels.ERROR)
		end
	else
		local lsp_success = pcall(vim.lsp.buf.format, { async = true })
		if not lsp_success then
			vim.notify("Failed to run LSP formatting", vim.log.levels.WARN)
		end
	end
end
