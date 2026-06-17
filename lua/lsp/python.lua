-- Define capabilities
local capabilities = require("blink.cmp").get_lsp_capabilities()
capabilities["general"] = { positionEncodings = { "utf-16" } }

-- Pyright
vim.lsp.config("pyright", {
	capabilities = capabilities,
	settings = {
		pyright = {
			disableOrganizeImports = true,
		},
		python = {
			pythonPath = vim.g.python_path(),
			analysis = {
				ignore = { "*" },
			},
		},
	},
})
vim.lsp.enable("pyright", true)

return
