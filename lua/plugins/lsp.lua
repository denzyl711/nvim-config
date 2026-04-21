return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			--LSP config by language
			require("lsp.python")
			require("lsp.lua")
			require("lsp.json")
			require("lsp.markdown")

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<leader>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				end,
			})

			-- Quickfix keymaps for LSP references
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "qf",
				callback = function()
					-- Enter: jump to reference and close the quickfix window
					vim.keymap.set("n", "<CR>", function()
						local idx = vim.fn.line(".")
						vim.cmd("cclose")
						vim.cmd(idx .. "cc")
					end, { buffer = true })

					-- Shift+Enter: open reference but keep cursor in quickfix window
					vim.keymap.set("n", "<S-CR>", function()
						local qf_win = vim.api.nvim_get_current_win()
						local idx = vim.fn.line(".")
						vim.cmd(idx .. "cc")
						vim.api.nvim_set_current_win(qf_win)
					end, { buffer = true })
				end,
			})
		end,
	},
}
