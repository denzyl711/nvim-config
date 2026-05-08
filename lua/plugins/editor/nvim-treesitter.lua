return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			-- New nvim-treesitter only manages parser installation.
			-- Highlighting/indent are now built into neovim natively.
			require("nvim-treesitter").setup()

			-- Auto-install parsers for these languages
			local langs = {
				"c", "lua", "vim", "vimdoc", "query",
				"python", "dart", "typescript", "regex",
				"bash", "markdown", "json", "markdown_inline",
				"sql", "go", "rust", "yaml", "cmake", "nix",
			}
			require("nvim-treesitter.install").install(langs)

			-- Enable native treesitter highlighting and indentation
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(ev)
					pcall(vim.treesitter.start, ev.buf)
					vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
	{
		"https://github.com/apple/pkl-neovim",
		lazy = true,
		event = "BufReadPre *.pkl",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		build = function()
			vim.cmd("TSInstall! pkl")
		end,
	},
}
