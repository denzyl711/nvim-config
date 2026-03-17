local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("jsonls", {
	capabilities = capabilities,
	settings = {
		json = {
			format = {
				enable = true,
			},
		},
		validate = { enable = true },
	},
})
vim.lsp.enable("jsonls", true)
return
