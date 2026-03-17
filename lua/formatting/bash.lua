local job = require("plenary.job")
local on_exit = require("formatting.utils.format_exit")

return function()
	return job:new({
		command = "beautysh",
		args = { vim.g.formatting_buf_name },
		on_exit = on_exit,
	})
end
