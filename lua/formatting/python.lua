local job = require("plenary.job")
local on_exit = require("formatting.utils.format_exit")

local black = function()
	return job:new({
		command = "black",
		args = { vim.g.formatting_buf_name },
		on_exit = on_exit,
	})
end

local isort = function()
	return job:new({
		command = "isort",
		args = { "--profile", "black", "--case-sensitive", vim.g.formatting_buf_name },
		on_exit = on_exit,
	})
end

return function()
	return { black(), isort() }
end
