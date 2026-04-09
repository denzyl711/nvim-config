local language_server = vim.fn.stdpath("data") .. "/lazy/copilot.lua/copilot/js/language-server.js"

vim.lsp.config("copilot", {
	cmd = { "node", language_server, "--stdio" },
	filetypes = { "*" },
	root_markers = { ".git" },
	settings = {},
})
vim.lsp.enable("copilot", true)

return
