local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("marksman", {
	capabilities = capabilities,
})
vim.lsp.enable("marksman", true)
return
