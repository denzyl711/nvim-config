-- Define capabilities
local capabilities = require("blink.cmp").get_lsp_capabilities()
capabilities["general"] = { positionEncodings = { "utf-16" } }

-- Ruff
local ruff_conf = vim.fn.expand("~/.config/ruff/ruff.toml")

vim.lsp.config("ruff", {
	capabilities = capabilities,
	on_attach = function(client)
		client.server_capabilities.hoverProvider = false
	end,
	init_options = {
		settings = {
			args = {
				"--config=" .. ruff_conf,
			},
		},
	},
})
vim.lsp.enable("ruff", true)

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
